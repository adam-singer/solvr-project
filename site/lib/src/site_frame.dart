// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

library solvr_site_frame;

import '../solvr_site.dart';

@CustomTag('site-frame')
class SiteFrame extends Frame {
  SiteFrame.created(): super.created() {
    initSite();
  }
  
  initSite() {
    var module = new SiteModule();
    var injector = new Injector(module);
    navigationManager = new NavigationManager(injector, this);
  }
  
  NavigationManager navigationManager;
}