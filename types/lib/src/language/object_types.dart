// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_types;

class ObjectTypes {
  // basic
  static const ObjectType OBJECT = const ObjectType("Object");

  // collections
  static const ObjectType DICT = const ObjectType("Dictionary", OBJECT, const [InterfaceTypes.COLLECTION]);
  static const ObjectType LIST = const ObjectType("List", OBJECT, const [InterfaceTypes.COLLECTION, InterfaceTypes.ALGEBRAIC_COLLECTION]);
  static const ObjectType MATRIX = const ObjectType("Matrix", OBJECT, const [InterfaceTypes.ALGEBRAIC_COLLECTION]);
  static const ObjectType SET = const ObjectType("Set", OBJECT, const [InterfaceTypes.COLLECTION, InterfaceTypes.ALGEBRAIC_COLLECTION]);
  static const ObjectType TUPLE = const ObjectType("Tuple", OBJECT, const [InterfaceTypes.COLLECTION, InterfaceTypes.ALGEBRAIC_COLLECTION]);
  static const ObjectType VECTOR = const ObjectType("Vector", OBJECT, const [InterfaceTypes.COLLECTION, InterfaceTypes.ALGEBRAIC_COLLECTION]);

  // values
  static const ObjectType BOOL = const ObjectType("Bool", OBJECT);
  static const ObjectType NUMBER = const ObjectType("Number", OBJECT, const [InterfaceTypes.EXPRESSION]);
  static const ObjectType STRING = const ObjectType("String", OBJECT);
  static const ObjectType SYMBOL = const ObjectType("Symbol", OBJECT, const [InterfaceTypes.EXPRESSION]);
}

/////////////////
// Collections //
/////////////////
class ListMethods {
  static const MethodType ADD = const MethodType("add", ObjectTypes.LIST, const [ObjectTypes.OBJECT], LanguageTypes.NOTHING);
  static const MethodType GET = const MethodType("get", ObjectTypes.LIST, const [ObjectTypes.NUMBER], ObjectTypes.OBJECT);
  static const MethodType MAP = const MethodType("map", ObjectTypes.LIST, const [LanguageTypes.INVOKE], ObjectTypes.LIST);
  static const MethodType MAP_I = const MethodType("mapI", ObjectTypes.LIST, const [LanguageTypes.INVOKE], ObjectTypes.LIST);
  static const MethodType REMOVE = const MethodType("remove", ObjectTypes.LIST, const [ObjectTypes.NUMBER], LanguageTypes.NOTHING);
}

class VectorMethods {
  static const MethodType AS_COLUMN = const MethodType("asColumn", ObjectTypes.VECTOR, const [], ObjectTypes.VECTOR);
  static const MethodType AS_ROW = const MethodType("asRow", ObjectTypes.VECTOR, const [], ObjectTypes.VECTOR);
  static const MethodType IS_COLUMN = const MethodType("isColumn", ObjectTypes.VECTOR, const [], ObjectTypes.BOOL);
  static const MethodType IS_ROW = const MethodType("isRow", ObjectTypes.VECTOR, const [], ObjectTypes.BOOL);
}
