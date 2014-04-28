// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_kernel_math_functions_builtin;

/** Convert list of expressions into a single expression */
@FunctionType("construct", AreaTypes.BUILT_IN)
Expr construct(List<Expr> list, Expr constructor(Expr e1, Expr e2)) {
  return tail(list).fold(list[0], constructor);
}

/** Evaluate a sequence expression */
@FunctionType("evaluate", AreaTypes.BUILT_IN)
Expr evaluateSeq(SeqExpr seq) {
  throw "TODO evaluate seq";
}

/**
 * Factor out the part of [expr] that depends on [x] from those part that does not
 *
 * returns a list
 */
@FunctionType("factors", AreaTypes.BUILT_IN)
List<Expr> factors(Expr expr, Expr x) {
  if(isProduct(expr)) {
    var freeOfPart = one;
    var dependentPart = one;
    expr.operands.forEach((operand) {
      if(freeOf(operand, x)) {
        freeOfPart = operand * freeOfPart;
      } else {
        dependentPart = operand * dependentPart;
      }
    });
    return [freeOfPart, dependentPart];
  } else if(freeOf(expr, x)) {
      return [x, one];
  } else {
      return [one, x];
  }
}

/** True when [target] is free of any occurences of [expr] */
@FunctionType("freeOf", AreaTypes.BUILT_IN)
bool freeOf(Expr target, Expr expr) {
  if(expr == target) {
    return false;
  } else if(isNullary(target)) {
    return true;
  } else {
    bool free = true;
    target.operands.forEach((Expr operand) {
      if(!freeOf(operand, expr)) {
        free = false;
        return;
      }
    });
    return free;
  }
  // TODO should be boxed as BoolExpr 
}

/** True when [target] is free of all [variables] */
@FunctionType("freeOfAll", AreaTypes.BUILT_IN)
bool freeOfAll(Expr target, SetExpr variables) {
  bool res = true;
  variables.forEach((Expr variable) {
    if(!freeOf(target, variable)) {
      res = false;
      return;
    }
  });
  return res;
}

/** Excempt expression from automatic simplification */
@FunctionType("hold", AreaTypes.BUILT_IN)
Expr hold(Expr expr) {
  // hold is a meta function, it's only purpose is to stop the reducer from
  // reducing expressions so its execution is not handled here. It must however
  // still be registered so it can take part in the help system and tab completion
  return asInvoke("hold", asTuple(expr));
}

/** Get the length (number of operands) of [expr] */
@FunctionType("lengthOf", AreaTypes.BUILT_IN)
int lengthOf(Expr expr) {
  // TODO should be boxed as NumberExpr 
  return expr.operands.length;
}

/** The natural logarithm */
@FunctionType("ln", AreaTypes.BUILT_IN)
NumberExpr ln(NumberExpr number) {
  if(number.isReal) {

  }
  return null;
  //var number = number.value;
}

/** Get the n-th operand of [expr] counted from 1 */
@FunctionType("operandOf", AreaTypes.BUILT_IN)
Expr operandOf(Expr expr, int index) {
  return expr.operands[index - 1];
}

/** Get list of operands from [expr] */
@FunctionType("operandsOf", AreaTypes.BUILT_IN)
List<Expr> operandsOf(Expr expr) {
  return expr.operands;
}

/** Sequentially replace free occurences of [origVar] with [newVar] in [expr] */
@FunctionType("replace", AreaTypes.BUILT_IN)
Expr replace(Expr expr, Expr origVar, Expr newVar) {
  var clone = expr.clone;
  clone.map((Expr part) {
    if(part == origVar) {
      return newVar;
    } else {
      if(isNullary(part)) {
        return part;
      } else {
        return replace(part, origVar, newVar);
      }
    }
  });
  return clone;
}

/** Sequentially replace free occurences of [originals] with [substitutions] in [expr] */
@FunctionType("replaceAll", AreaTypes.BUILT_IN)
Expr replaceAll(Expr expr, List<Expr> originals, List<Expr> substitutions) {
  assert(originals.length == substitutions.length);

  var clone = expr.clone;
  mapI(originals, (Expr origVar, int i) {
    var newVar = substitutions[i];
    clone = replace(clone, origVar, newVar);
  });
  return clone;
}

/** Run automatic simplify dirrectly using the current scope */
@FunctionType("simplify", AreaTypes.BUILT_IN)
Expr simplify(var expr) {
  //var kernel = new Kernel.keepScope();
  //return kernel.simplify(expr);
  // TODO figure out how to get access to kernel here
  return null;
}

/** Concurrently replace free occurences of [originals] with [substitutions] in [expr] */
@FunctionType("substitute", AreaTypes.BUILT_IN)
Expr substitute(Expr expr, List<Expr> originals, List<Expr> substitutions) {
  assert(originals.length == substitutions.length);

  var clone = expr.clone;
  clone.map((Expr part) {
    Expr res = part;
    mapI(originals, (Expr origVar, int i) {
      if(part == origVar) {
        res = substitutions[i];
        return;
      } else {
        if(!isNullary(part)) {
          res = substitute(part, originals, substitutions);
          return;
        }
      }
    });
    assert(res != null);
    return res;
  });
  return clone;
}

/**
 * Return the symbolic type name of a expression
 *
 * Note this name is printer friendly but is not guarantied to be unique (unlike the fullname). For example
 * !true and 4! will have the same symbolic type(!) but not the same fullname (negation vs factorial)
 */
@FunctionType("typeOf", AreaTypes.BUILT_IN)
SymbolExpr typeOf(var expr) {
  String typename = expr.type.name;
  if(isInvoke(expr)) {
    typename = expr.name;
  }
  return asSymbol(typename);
}
