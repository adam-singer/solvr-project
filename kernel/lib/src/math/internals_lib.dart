// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

/** 
 * Internal utilties and APIs used inside the math kernel. Also acts as meta library 
 * exporting various packages commonly used inside the kernel
 */
library solvr_kernel_math_internals;

import 'package:solvr_common/solvr_common.dart';
export 'package:solvr_common/solvr_common.dart';

import '../ast_lib.dart';
export '../ast_lib.dart';
import '../matcher_lib.dart';
export '../matcher_lib.dart';
import '../types_lib.dart';
export '../types_lib.dart';

part 'internals/expr_helpers.dart';
part 'internals/kernel_errors.dart';
part 'internals/memorizer.dart';
part 'internals/quotients.dart';
part 'internals/rational_number.dart';
part 'internals/visitor.dart';

part 'internals/api/function_object.dart';
part 'internals/api/invokable_object.dart';
part 'internals/api/method_object.dart';
part 'internals/api/module_object.dart';

/** evaluates f in a logging diagnostic context named "contextName" */
Expr inContext(Logger logger, String contextName, Expr expr, Expr f(Expr)) {
  logger.putContext(contextName, contextName);
  logger.debug('handling $expr');
  try {
    var res = f(expr);
    return res;
  } finally {
    logger.removeContext(contextName);
  }
}

