// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_web_app;

/**
 * Callout widget with accept/decline buttons.
 *
 * Note: only one instance of this widget can be active at a time
 */
class AcceptWidget extends CalloutWidget {
  AcceptWidget(String acceptText, String declineText, Element content): super(content) {
    _accept = createElement("button", text:acceptText, classes:"widget-button", parent:widget);
    _decline = createElement("button", text:declineText, classes:"widget-button", parent:widget);
    _error = createElement("p", classes:"error-message", parent:widget);
    _error.style.display = "none";
    
    // remove widget when user clicks outside of it
    window.onClick.listen((Event e) {
      if(!matchesParentOrSelf(e.target, 'widget-callout')) {
        remove();
      }
    });
  }
  
  set errorMessage(String message) {
    _error.innerHtml = message;
    _error.style.display = "block";
  }
  
  set onAccept(EventListener handler) => _accept.onMouseDown.listen(handler);
  
  set onDecline(EventListener handler) => _decline.onMouseDown.listen(handler);
  
  Element _accept, _decline, _error;
}
