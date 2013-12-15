// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ui;

abstract class NavigationManager {
  NavigationManager(this._injector);
  
  registerPage(String url, Type pageType) {
    _urlMap[url] = pageType;
    _pageMap[pageType] = url;
  }
  
  showPage(Type pageType) {
      
  }
  
  final Injector _injector;
  final Map<String, Type> _urlMap = new Map<String, Type>();
  final Map<Type, String> _pageMap = new Map<Type, String>();
}

typedef Page PageBuilder(Type pageType);