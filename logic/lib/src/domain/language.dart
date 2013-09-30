// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic;

/**
 * Languages supported by the app
 * 
 * TODO perhaps move to Ding (search engine) as we should have stemmers for each supported language
 */
class Language {
  const Language(this.name);
  
  static const English = const Language("english");
  static const Unknown = const Language("unknown");
  
  final String name;
}
