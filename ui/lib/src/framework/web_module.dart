// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS
// file for details. All rights reserved. Use of this source code is
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ui_framework;

/**
 * Module used for framework registration
 */
abstract class WebModule extends Module {
  /**
    * Implement page registration here
    * 
    * This method is called automatically on [Frame] creation 
    */
  registerPages(NavigationManager navigationManager);
}
