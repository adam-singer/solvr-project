// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

library solvr_site_app;

import 'package:polymer/polymer.dart';

@CustomTag('solvr-site')
class SolvrSite extends PolymerElement {
  SolvrSite.created(): super.created() {
    print("app created");
  }
}