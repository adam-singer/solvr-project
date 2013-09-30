// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_types;

class LanguageTypes {
  static const LanguageType ANONYMOUS_FUNCTION = const LanguageType("Anonymous function", AREA);
  static const LanguageType ASSIGN = const LanguageType("Assign", AREA);
  static const LanguageType BLOCK = const LanguageType("Block", AREA);
  static const LanguageType CONDITIONAL = const LanguageType("Conditional", AREA);
  static const LanguageType FUNCTION = const LanguageType("Function", AREA);
  static const LanguageType GENERIC = const LanguageType("Generic", AREA);
  static const LanguageType INTERVAL = const LanguageType("Interval", AREA);
  static const LanguageType INVOKE = const LanguageType("Invoke", AREA);
  static const LanguageType METHOD = const LanguageType("Method", AREA);
  static const LanguageType NOTHING = const LanguageType("Nothing", AREA);
  static const LanguageType TYPED = const LanguageType("Typed expression", AREA);
  static const LanguageType RETURN = const LanguageType("Return", AREA);
  static const LanguageType SEQUENCE = const LanguageType("Sequence", AREA);
  static const LanguageType VAR_ARGS = const LanguageType("Var args", AREA);

  static const AreaType AREA = const AreaType("Builtin");
}


