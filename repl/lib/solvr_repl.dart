// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

library solvr_repl;

import 'dart:core';
import 'dart:io';

import 'package:solvr_kernel/solvr_kernel.dart';

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
