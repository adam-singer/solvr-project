// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_registry;

class BuiltinModule extends AbstractModule {
  BuiltinModule() {
    _registerFunctions();
    _registerMethods();
  }

  _registerFunctions() {
    registerFunction(new _ConstructFn());
    registerFunction(new _FactorsFn());
    registerFunction(new _FreeOfFn());
    registerFunction(new _HoldFn());
    registerFunction(new _LengthFn());
    registerFunction(new _OperandFn());
    registerFunction(new _OperandsFn());
    registerFunction(new _ReplaceFn());
    registerFunction(new _ReplaceAllFn());
    registerFunction(new _SubstituteFn());
    registerFunction(new _SimplifyFn());
    registerFunction(new _TypeOfFn());
  }

  _registerMethods() {
    registerMethod(new _LengthMethod());
  }
}

class _ConstructFn extends AbstractFunction {
  _ConstructFn(): super(BuiltinFunctions.CONSTRUCT);

  Expr apply(TupleExpr args) {
    var operands = args.operands;
    construct(operands, expectExpr(operands[0], operands[1]));
  }
}

class _FactorsFn extends AbstractFunction {
  _FactorsFn(): super(BuiltinFunctions.FACTORS);

  Expr apply(TupleExpr args) {
    return listOf(factors(args[0], args[1]));
  }
}

class _FreeOfFn extends AbstractFunction {
  _FreeOfFn(): super(BuiltinFunctions.FREE_OF);

  Expr apply(TupleExpr args) {
    return asBool(freeOf(args[0], args[1]));
  }
}

class _HoldFn extends AbstractFunction {
  _HoldFn(): super(BuiltinFunctions.HOLD);

  // hold is a meta function, it's only purpose is to stop the reducer from
  // reducing expressions so its execution is not handled here. It must however
  // still be registered so it can take part in the help system and tab completion
  Expr apply(TupleExpr args) {
    throw "invoking hold directly makes no sense";
  }
}

class _LengthFn extends AbstractFunction {
  _LengthFn(): super(BuiltinFunctions.LENGTH);

  Expr apply(TupleExpr args) {
    return asNumber(lengthOf(args[0]));
  }
}

class _OperandFn extends AbstractFunction {
  _OperandFn(): super(BuiltinFunctions.OPERAND);

  Expr apply(TupleExpr args) {
    var rational = valueOf(args[1]);
    if(!rational.isInteger) {
      // TODO type check this (add Integer, Rational and Real number types)
      throw new ArgumentError("operand number must be integer");
    }
    var opNum = rational.numerator.asInt;
    return operandOf(args[0], opNum);
  }
}

class _OperandsFn extends AbstractFunction {
  _OperandsFn(): super(BuiltinFunctions.OPERANDS);

  Expr apply(TupleExpr args) {
    return listOf(args[0].operands);
  }
}

class _ReplaceFn extends AbstractFunction {
  _ReplaceFn(): super(BuiltinFunctions.REPLACE);

  Expr apply(TupleExpr args) {
    var subs = asSubstitution(args[1]);
    var origVar = subs.left;
    var newVar = subs.right;
    return replace(args[0], origVar, newVar);
  }
}

class _ReplaceAllFn extends AbstractFunction {
  _ReplaceAllFn(): super(BuiltinFunctions.REPLACE_ALL);

  Expr apply(TupleExpr args) {
    var subsList = asList(args[1], converters:[asSubstitution]);
    var origVars = subsList.map((subs) => subs.left);
    var newVars = subsList.map((subs) => subs.right);
    return replaceAll(args[0], origVars, newVars);
  }
}

class _SimplifyFn extends AbstractFunction {
  _SimplifyFn(): super(BuiltinFunctions.SIMPLIFY);

  Expr apply(TupleExpr args) {
    return simplify(args[0]);
  }
}

class _SubstituteFn extends AbstractFunction {
  _SubstituteFn(): super(BuiltinFunctions.SUBSTITUTE);

  Expr apply(TupleExpr args) {
    var subsList = asList(args[1], converters:[asSubstitution]);
    var origVars = subsList.map((subs) => subs.left);
    var newVars = subsList.map((subs) => subs.right);
    return substitute(args[0], origVars, newVars);
  }
}

class _TypeOfFn extends AbstractFunction {
  _TypeOfFn(): super(BuiltinFunctions.TYPE_OF);

  Expr apply(TupleExpr args) {
    return typeOf(args[0]);
  }
}

// TODO add type matcher
class _LengthMethod extends AbstractMethod<CollectionExpr> {
  _LengthMethod(): super(CollectionsKeys.LENGTH);

  Expr applyOn(CollectionExpr collection, TupleExpr args) {
    return asNumber(collection.length);
  }
}

