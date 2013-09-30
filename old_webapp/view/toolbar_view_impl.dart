// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_web_app;

class ToolbarViewImpl extends AbstractView implements ToolbarView {
  ToolbarViewImpl(Element container): super(container) {
    // TODO move template call into super(container) so its more clear what happens
    view.query("button[name='new']").onClick.listen((Event event) => _presenter.onNewNotebook());
    view.query("button[name='save']").onClick.listen((Event event) => _presenter.onSaveNotebook());
    
    view.query("button[name='share']").onClick.listen((Event event) => _presenter.onShareNotebook());
    view.query("button[name='discover']").onClick.listen((Event event) => _presenter.onDiscoverNotebooks());

    view.query("button[name='calculate']").onClick.listen((Event e) => _presenter.onEvaluate());
    view.query("button[name='widgets']").onClick.listen((Event e) => _presenter.onShowWidgets());
    view.query("button[name='settings']").onClick.listen((Event e) => _presenter.onShowSettings());
  }
  
  set presenter(ToolbarPresenter p) => _presenter = p;
  
  String get template {
    String html = 
      """<section id="toolbar">
          <nav>
            <ul class='horizontal-list'>
               <li><button name='new'><span>${textRepo.newNotebook}</span></button></li>
               <li><button name='save'><span>${textRepo.saveNotebook}</span></button></li>
            </ul>
          </nav>

          <nav>
            <ul class='horizontal-list'>
               <li><button name='share'><span>${textRepo.share}</span></button></li>
               <li><button name='discover'><span>${textRepo.discover}</span></button></li>
            </ul>
          </nav>

          <nav>
            <ul class='horizontal-list' >
              <li><button name='calculate'><span>${textRepo.calculate}</span></button></li>
              <li><button name='widgets'><span>${textRepo.widgets}</span></button></li>
              <li><button name='settings'><span>${textRepo.settings}</span></button></li>
              <li>
                <input id="searchBox" name="searchBox" type="text"/>
              </li>
            </ul>
          </nav>
        </section>
      """;
    return html;
  }
  
  showSettings(Settings settings) {
    var settingsWidget = new SettingsWidget(settings);
    var settingsHandle = nearestParent(view.query("button[name='settings']"), type:"li");
    settingsWidget.attachBelowOf(settingsHandle);
  }
  
  shareNotebook(String notebookName) {
    var shareWidget = new ShareWidget(notebookName);
    var shareHandle = nearestParent(view.query("button[name='share']"), type:"li");
    shareWidget.attachBelowOf(shareHandle);
  }
  
  ToolbarPresenter _presenter;
}


