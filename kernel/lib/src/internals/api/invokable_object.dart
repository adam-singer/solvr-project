// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_internals;

/** A invokableobject, such as a function or method */
abstract class InvokableObject {
  String get name;

  ModuleObject module;

  List<IType> get expectedArgumentTypes;

  IType get expectedReturnType;

  bool matchesArguments(TupleExpr args);

  /**
   * Specificity controls how well a function matches arguments.
   *
   * Negative specificity means the arguments don't match, zero that the types match perfectly
   * and a positive specificity means that the arguments match through inheritance
   */
  int specificity(TupleExpr args);
}

/** Base class extended by invokable objects */
abstract class AbstractInvokable implements InvokableObject {
  AbstractInvokable(InvokableType invokable)
    : expectedArgumentTypes = invokable.argumentTypes,
      name = invokable.simpleName,
      expectedReturnType = invokable.returnType;

  Logger get logger;

  /** [true] when the supplied arguments matches the expected arguments */
  bool matchesArguments(TupleExpr args) => specificity(args) >= 0;

  int specificity(TupleExpr args) {
    List<IType> actualArgumentTypes = args.mapThis((Expr expr) => expr.type);
    if(expectedArgumentTypes.length == 1 && expectedArgumentTypes[0] is VarargType) {
       if(_checkVararg(expectedArgumentTypes[0], actualArgumentTypes)) {
         return 0;
       }
    }
    if(actualArgumentTypes.length != expectedArgumentTypes.length) {
      return -1;
    }

    int res = 0;
    mapI(actualArgumentTypes, (var actualType, int i) {
      var expectedType = expectedArgumentTypes[i];
      res += _specificityOf(actualType, expectedType, "argument type");
      if(res < 0) {
        return;
      }
    });
    return res;
  }

  /** [true] when the supplied return type matches the expected return type */
  bool matchesReturnType(IType actualReturnType) => _specificityOf(actualReturnType, expectedReturnType, "return type") >= 0;

  /*
   * return zero when types matches perfectly, negative when they don't 
   * match and positive when they match because of inheritance
   */
  int _specificityOf(IType actualType, IType expectedType, String boundaryType) {
    var actualBoundary = _typesFrom(actualType);
    var expectedBoundary = _typesFrom(expectedType);
    assert(actualBoundary.isEmpty == false || expectedBoundary.isEmpty == false);

    if(logger.debugEnabled) {
      logger.debug("actual ${boundaryType}: [$actualType] expected ${boundaryType}: [$expectedType]");
      logger.debug("actual ${boundaryType} boundary: [${actualBoundary.join()}] expected ${boundaryType} boundary: [${expectedBoundary.join()}]");
    }

    // start at minus one in specificity so if the first type match, then we get a perfect score
    int res = -1;
    bool matches = false;
    if(expectedBoundary.any(isGenericType)) {
      // generics are checked by looping the expected type hireachy and seeing if
      // any of the expected types matches the provided - this way generic types
      // get a higher specificity than non generics
      expectedBoundary.forEach((IType expected) {
        res += 1;
        if(isGenericType(expected)) {
          if(_checkGeneric(expected, actualBoundary)) {
            matches = true;
            return;
          }
        }
      });
    } else {
      // non generics are handled by looping the actual types and checking if they match
      // the expected, this way the most specific object type wins
      actualBoundary.forEach((IType actual) {
        res += 1;
        if(expectedBoundary.contains(actual)) {
          matches = true;
          return;
        } else if(isGenericType(actual)) {
          if(_checkGeneric(actual, expectedBoundary)) {
            matches = true;
            return;
          }
        }
      });
    }
    if(!matches) {
      // no match return negative specificity
      return -1;
    }
    // match return the actual specificity
    return res;
  }

  /* Check that a generic type matches a boundary */
  bool _checkGeneric(GenericType generic, Set<IType> actualBoundary) {
    var template = generic.template;
    if(!actualBoundary.contains(template)) {
      logger.debug("generic with template ${template} does not match [${actualBoundary.join()}]");
      return false;
    }
    if(logger.debugEnabled) {
      logger.debug("generic with template ${template} matched [${actualBoundary.join()}]");
    }
    // TODO also check that the generic boundary is matches (i.e List<Expr> should match both List and all elements should be Expr)
    return true;
  }

  /* Check that var args matches supplied arguments */
  bool _checkVararg(VarargType vararg, List<IType> suppliedTypes) {
    if(suppliedTypes.length < vararg.minArgs) {
      return false;
    }
    var matches = true;
    suppliedTypes.forEach((IType argType) {
      matches = vararg.bounds.any((IType boundType) => boundType == argType);
      if(!matches) {
        return;
      }
    });
    return matches;
  }

  /* Get all types assignable from this type */
  Set<IType> _typesFrom(IType type) {
    // TODO cache this stuff as its an expensive lookup
    var types = new Set<IType>();

    if(type == LanguageTypes.INVOKE) {
      // TODO check function boundary
      types.add(InterfaceTypes.EXPRESSION);
    } else if(isOperator(type)) {
      types.add(InterfaceTypes.EXPRESSION);
    } else {
      // add the type itself
      types.add(type);
      if(isSuperTypeable(type)) {
        // add the types supertypes
        types.addAll((type as SuperTypeable).superTypes);
        // add all interfaces known
        List<IType> interfaces = [];
        types.forEach((SuperTypeable assignableType) {
          interfaces.addAll(assignableType.interfaces);
        });
        types.addAll(interfaces);
        // add all interfaces super types
        interfaces.forEach((InterfaceType inf) {
          types.addAll(inf.superTypes);
        });
      }
    }
    return types;
  }

  // converters

  List asList(CollectionExpr args, {List<ExprConverter> converters:null}) {
    List res = [];
    mapI(args.operands, (Expr arg, int index) {
      if(converters == null) {
        // for no converter just return expression
        res.add(arg);
      } else if(converters.length == 1) {
        // for one converter apply it to all arguements
        var converter = converters[0];
        res.add(converter(arg));
      } else {
        // for n converters expect a converter to exist for each argument
        var converter = converters[index];
        res.add(converter(arg));
      }
    });
    return res;
  }

  List<Integer> asIntegerList(CollectionExpr args) => asList(args, converters:[asInteger]);

  int asInt(var expr) {
    assert(isNumber(expr));
    return asInteger(expr).asInt;
  }

  Integer asInteger(var expr) {
    RationalNumber number = asRationalNumber(expr);
    assert(number.isInteger);
    return number.asInteger;
  }

  NumberExpr asNonNegativeIntegerExpr(var expr) {
    assert(isNumber(expr) && !isNegativeNumber(expr));
    return expr;
  }

  SubstitutionExpr asSubstitution(var expr) {
    assert(isSubstitution(expr));
    return expr;
  }

  Expr asExpr(var expr) => expr as Expr;

  RationalNumber asRationalNumber(var expr) {
    assert(isNumber(expr));
    return new RationalNumber(expr.numerator, expr.denominator);
  }

  ModuleObject module;
  final String name;
  final List<IType> expectedArgumentTypes;
  final IType expectedReturnType;
}




