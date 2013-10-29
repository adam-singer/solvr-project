// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_checker;

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
