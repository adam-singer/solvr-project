// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full

part of solvr_kernel_types;

/** Base for all types that have super types for example Lists are sub types of collection */
abstract class SuperTypeable<T extends SuperTypeable> extends IType {
  const SuperTypeable(this.simpleName, this.superType);

  List<IType> get interfaces;

  String get qualifiedName {
     var types = <IType>[ this ];
     types.addAll(superTypes);
     var names = reverseList(types).map((IType type) => type.simpleName);
     return names.join(".");
  }

  List<IType> get superTypes {
    var types = <IType>[];
    T type = this.superType;
    while(type != null) {
      types.add(type);
      type = type.superType;
    }
    return types;
  }

  bool hasInterface(var inf) => interfaces.any((var i) => i == inf);

  final T superType;
  final String simpleName;
}

bool isSuperTypeable(var type) => type is SuperTypeable;
