// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

library solvr_ui;

import 'dart:html';
export 'src/solvr_ui_web.dart';
export 'src/solvr_ui_web_components.dart';

Element createElement(String type, [String id = null, String text = null, var classes = null, Map<String,String> attributes = null, Element parent = null]) {
  var element = new Element.tag(type);
  if(id != null) element.id = id;
  if(text != null) element.innerHtml = text;
  if(attributes != null) attributes.forEach((k,v) => element.attributes[k] = v);
  if(parent != null) parent.nodes.add(element);
  if(classes != null) {
    if(classes is List<String>) element.classes = classes;
    if(classes is String) element.classes.add(classes);
  }
  
  return element;
}

/** Find the nearest parent matching type and/or class */
Element nearestParent(Element elm, {String type:null, String clazz:null}) {
  if(type == null && clazz == null) {
    throw new ArgumentError("atleast one of type or class must be specified");
  }
  
  Element working = elm;
  while(working.parent != null && !(working.parent is Document)) {
    working = working.parent;
    if(type == null || working.tagName.toUpperCase() == type.toUpperCase()) {
      if(clazz == null || working.classes.contains(clazz)) {
        return working;
      }
    }
  }
  return null;
}

/** True when element self or its parent has a given class */
bool matchesParentOrSelf(Element elm, String cssClass) {
  return elm.classes.contains(cssClass) || nearestParent(elm, clazz:cssClass) != null;
}

queryAs(Element target, String queryString, func(var res)) {
  var result = target.query(queryString);
  func(result);
}
