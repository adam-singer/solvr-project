// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ui_framework;

/** Handles page and URL registration and sets up bidirectional navigation between them */
class NavigationManager {
  NavigationManager(this._injector, this._frame) {
    // TODO set up URL listener
  }
    
  registerPage(String url, Type pageType) {
    if(_urlToPageMap.containsKey(url) || _pageToUrlMap.containsKey(pageType)) {
      throw "registration already exists for ${url} and ${pageType}";
    }
    _urlToPageMap[url] = pageType;
    _pageToUrlMap[pageType] = url;
  }
  
  /// show the page represented by the passed type
  showPage(Type pageType) {
    Page page = _injector.getInstance(pageType);
    // TODO change page URL
    _frame.showPage(page);
  }
  
  final Injector _injector; // used to instantiate concrete pages
  final Frame _frame;       // the frame to do navigation within
  final Map<String, Type> _urlToPageMap = new Map<String, Type>();
  final Map<Type, String> _pageToUrlMap = new Map<Type, String>();
}

// TODO is this needed
typedef Page PageBuilder(Type pageType);