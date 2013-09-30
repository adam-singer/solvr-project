// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Represents a dictionary fx. {x:2, y:3, z:4} */
class DictionaryExpr extends _MapBasedCollection {
  factory DictionaryExpr(List<Expr> operands) {
    var keyMapper = (EntryExpr e) => e.left.toString();
    return new DictionaryExpr._internal(operands, keyMapper);
  }

  DictionaryExpr._internal(List<Expr> operands, _KeyMapper keyMapper): super(operands, keyMapper, ObjectTypes.DICT);

  Expr get clone => dictionaryOf(_cloneExprList(operands));
}

DictionaryExpr dictionaryOf(List<Expr> elements) {
  if(!elements.every((e) => e is EntryExpr)) {
    throw new ArgumentError("all entries in a map must be of the form key:value");
  }
  return new DictionaryExpr(elements);
}

