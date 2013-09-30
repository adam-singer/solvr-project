// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_web_app;

class WidgetsViewImpl extends AbstractView implements WidgetsView {
  WidgetsViewImpl(Element container): super(container) {
    _visible = true;
    
    view.query("button[name='activity-widget']").onClick.listen((MouseEvent clickEvent) => _presenter.onShowActivity());
    view.query("button[name='help-widget']").onClick.listen((MouseEvent clickEvent) => _presenter.onShowHelp());
  }
  
  String get template {
    // TODO make a actual tabbed widget that has a setContent/setTitle and share it with notebook view
    String html = 
      """<aside id='widgets'>
            <section class='widget-tabbed' >
              <nav class='widget-tabbed-header'>
                <h2>
                  <span id='widget-tabbed-name'></span>
                </h2>
                <ul class='horizontal-list'>
                  <li>
                    <button name='help-widget'></button>
                  </li>
                  <li>
                    <button name='activity-widget'></button>
                  </li>
                </ul>
              </nav>
      
              <article class='widget-tabbed-content'></article>
            </section>

            <section class='hidden'></section>
         </aside>
      """;
    return html;
  }
  
  showActivities(List<NotebookActivity> activities) {
    ActivityWidget activityWidget = new ActivityWidget();
    activities.forEach((NotebookActivity activity) {
      activityWidget.addActivity(activity);
    });
    _showWidget(activityWidget, textRepo.activity);
  }
  
  showHelp(List<AreaType> areas) {
    HelpWidget helpWidget = new HelpWidget(areas, null);
    _showWidget(helpWidget, textRepo.help);
  }
  
  _showWidget(var widget, String title) {
    Element content = view.query('.widget-tabbed-content');
    content.nodes.clear();
    widget.attachTo(content);
    
    view.query('#widget-tabbed-name').innerHtml = title;
  }
  
  set presenter(WidgetsPresenter presenter) => _presenter = presenter; 
  
  toogle() {
    if(_visible) {
      view.style.visibility = "hidden";
      _visible = false;    
    } else {
      view.style.visibility = "visible";
      _visible = true;   
    }
  }
  
  showHelpForType(Type type) {
    // TODO make a show help for function
    //helpWidget.innerHTML = text; 
  }
  
  WidgetsPresenter _presenter;
  bool _visible;
}
