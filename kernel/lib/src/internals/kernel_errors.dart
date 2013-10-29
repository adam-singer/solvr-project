// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_internals;

/// error for internal kernel 
class KernelError extends SolvrError {
  KernelError(this.errorMessage);

  final String errorMessage;
}

//class KernelArgumentError extends KernelError {
//  KernelError(String errorMessage): super(errorMessage);
//}

