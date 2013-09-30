// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_types;

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

