// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_type_checker;

abstract class Checker {
  check(var expr);

  TypeChecker get typeChecker;

  Registry get registry;

  error(String message) => typeChecker.error(message);

  // TODO check that symbols used in algebraic expressions are not type names

  /**
   * Check functions have the correct return type and arity
   */
  checkFunctions(String operatorName, List<InvokeExpr> functions, List<TypeMatcher> returnTypeMatchers) {
    functions.forEach((InvokeExpr invocation) {
      var function = registry.getFunction(invocation);
      if(function == null) {
        // Return on undefined functions since these will just not be evaluated
        return;
      }
      // Check return expr
      if(function.expectedReturnType != null) {
        returnTypeMatchers.forEach((TypeMatcher matcher) {
          if(!matcher(function.expectedReturnType)) {
            error("cannot apply function ${function.name} with return expr ${function.expectedReturnType} to $operatorName");
            // Break out of match loop on first matcher failure
            return;
          }
        });
      } else {
        // Function does not have a return type where we expected, so it must be an error
        if(returnTypeMatchers.length > 0) {
          error("void function ${function.name} cannot be applied to $operatorName");
        }
      }
      // TODO check arguments
    });
  }
}
