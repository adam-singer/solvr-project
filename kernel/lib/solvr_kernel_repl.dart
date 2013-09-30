// Copyright (c) 2013 Solvr. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr Aps is prohibited.

library solvr_kernel_repl;

import 'dart:core';
import 'dart:io';

import 'solvr_kernel.dart';

main() {
  final prompt = 'solvr> ';
  var stream = stdin.transform(new StringDecoder());
  final lines = new List<String>();
  
  final options = new Options();
  
  print('${prompt}');
  
  stream.listen((String line) { 
    if (line != null) {
      try {
        var kernel = new Kernel();
        var value = kernel.evaluate(line).toString();
        print(line);
        print(value);
      } catch (ex) {
        print('Exception: ${ex}');
        print('Error kernel.evaluate: ${line}');
      }
    }
    
    print('${prompt}');
  });
}
