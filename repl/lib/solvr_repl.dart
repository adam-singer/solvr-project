// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

library solvr_repl;

import 'dart:convert';
import 'dart:io';

import 'package:solvr_kernel/solvr_kernel.dart';

main(List<String> args) {
  final prompt = 'solvr> ';
  print('${prompt}');
  
  var stream = stdin.transform(UTF8.decoder);
  stream.listen((String line) { 
    if (line != null) {
      try {
        // TODO handle scope
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
