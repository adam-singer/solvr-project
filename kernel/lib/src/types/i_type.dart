// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_types;

/** Base type extended by all types in Solvr. */
abstract class IType {
  const IType();

  /** The fully-qualified name for this language entity. */
  String get qualifiedName;

  /** The identifier name of the entity */
  String get simpleName;

  int get hashCode => qualifiedName.hashCode;

  String toString() => simpleName;

  operator ==(var other) {
    if(other == null) {
      return false;
    }
    return hashCode == other.hashCode;
  }
}

