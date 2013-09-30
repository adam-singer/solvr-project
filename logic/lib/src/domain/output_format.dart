// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic;

/**
 * The output format of a calculation (i.e. LaTeX or Solvr code)
 */
class OutputFormat {
  const OutputFormat(this.type);
  
  static const TEXT = const OutputFormat("text");
  static const MATH = const OutputFormat("math");
  
  static OutputFormat valueOf(String type) {
    if(type == "text") return OutputFormat.TEXT;
    if(type == "math") return OutputFormat.MATH;
    throw new ArgumentError("unhandled output format type $type");
  }
  
  final String type;
}
