// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ui_framework;

/**
 * A [Frame] is a unit which contains pages and navigation 
 */
abstract class Frame extends Component {
  Frame.created(WebModule module): super.created() {
    _injector = new Injector(module);
    _navigationManager = new NavigationManager(_injector, this);
    module.registerPages(_navigationManager);
  }
  
  /**
   * Implement DOM manipulation for showing a new page here
   * 
   * This method is called automatically by the [NavigationManager] when 
   * asked to navigate to a new page
   */
  showPage(Page page);
  
  Injector _injector;
  
  NavigationManager _navigationManager;
}