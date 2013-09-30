// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_functions_builtin;

/** Evaluate a sequence expression */
Expr evaluateSeq(SeqExpr seq) {
  throw "TODO evaluate seq";
}

/** True when [target] is free of any occurences of [expr] */
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
}

/**
 * Factor out the part of [expr] that depends on [x] from those part that does not
 *
 * returns a list
 */
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

/** True when [target] is free of all [variables] */
bool setFreeOf(Expr target, SetExpr variables) {
  bool res = true;
  variables.forEach((Expr variable) {
    if(!freeOf(target, variable)) {
      res = false;
      return;
    }
  });
  return res;
}

InvokeExpr hold(Expr expr) => asInvoke("hold", tupleOf(expr));

/** Get the length (number of operands) of [expr] */
int lengthOf(Expr expr) => expr.operands.length;

/** Get the n-th operand of [expr] counted from 1! */
Expr operandOf(Expr expr, int index) => expr.operands[index - 1];

/**
 * Return the symbolic type name of a expression
 *
 * Note this name is printer friendly but is not guarantied to be unique (unlike the fullname). For example
 * !true and 4! will have the same symbolic type(!) but not the same fullname (negation vs factorial)
 */
SymbolExpr typeOf(var expr) {
  String typename = expr.type.name;
  if(isInvoke(expr)) {
    typename = expr.name;
  }
  return asSymbol(typename);
}

/** The natural logarithm */
NumberExpr ln(NumberExpr number) {
  if(number.isReal) {

  }
  //var number = number.value;
}

/**
 * Sequentially replace free occurences of [origVar] with [newVar] in [expr]
 */
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
Expr replaceAll(Expr expr, List<Expr> originals, List<Expr> substitutions) {
  assert(originals.length == substitutions.length);

  var clone = expr.clone;
  mapI(originals, (Expr origVar, int i) {
    var newVar = substitutions[i];
    clone = replace(clone, origVar, newVar);
  });
  return clone;
}

/** Concurrently replace free occurences of [originals] with [substitutions] in [expr] */
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

/** Run automatic simplify dirrectly using the current scope */
Expr simplify(var expr) {
  var kernel = new Kernel.keepScope();
  return kernel.simplify(expr);
}
