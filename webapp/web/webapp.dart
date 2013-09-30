// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

library solvr_webapp;

import 'dart:html';

import 'package:route/client.dart';

import 'ui/ui_lib.dart';

main() {
  bindMockLogic().then((LogicConfig config) {
    var controller = new AppController(config.messageBus, config.viewModelRepository);
    controller.go();
  });
}

class AppController implements AppRouter {
  AppController(this._messageBus, this._viewModelRepository) {
    _setupRoutes();
    _setupUi();
  }
  
  _createWidgets() {
    _menuWidget = new MenuWidget(_messageBus);
    _contentWidget = new ContentWidget(_messageBus);
  }
  
  _setupRoutes() {
    //var contentWidget = _contentWidget.xtag as ContentWidget;
    //_contentWidget.xtag.notebook = _viewModelRepository.getNotebookById(message.notebookId);
    // TODO change URL instead and move this code down there 
    // TODO discard navigation request if URL is the current
    // TODO use some user/notebook/note pattern (fx root/my-notebook)
    /*
    TODO this is a general responsability move it to app controller
    
    if(_viewModelRepository.activeResource is NotebookViewModel) {
      var active = (_viewModelRepository.activeResource as NotebookViewModel);
      if(active.id == notebook.id) {
        return;
      }
    } 
    */
    _router.addHandler(_homeUrl, (_) => null);
  }
  
  _setupUi() {
    addComponent(_menuWidget, tag:'aside', container:document.body, type:'x-menu-widget');
    addComponent(_contentWidget, tag:'div', container:document.body, type:'x-content-widget');
  }
  
  go() {
    _router.listen();
    _router.gotoUrl(_homeUrl, ["a", "b"], "");
  }
  
  WebComponent _menuWidget, _contentWidget;
  final MessageBus _messageBus;
  final ViewModelRepository _viewModelRepository;
  final _router = new Router(useFragment:true);
  final _homeUrl = new UrlPattern(r'(.*)root');
}

// see https://github.com/dart-lang/web-ui/blob/master/test/data/input/component_created_in_code_test.html
addComponent(WebComponent component, { String tag, Element container, String type }) {
  var host = new Element.tag(tag);
  host.attributes['is'] = host;
  component.host = host;
  var lifecycleCaller = new ComponentItem(component)..create();
  container.nodes.add(component.host);
  lifecycleCaller.insert();
}
