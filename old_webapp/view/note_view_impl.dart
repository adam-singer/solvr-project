// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_web_app;

class NoteViewImpl extends AbstractView implements NoteView {
  NoteViewImpl(Element container): 
    _entries = new Map<Guid,Element>(),
    _results = new Map<String,String>(),
    _render = new TexRender(),
    super(container)
  {
    _entryList = view.query("#entry-list");
    
    view.query("#note-name").onClick.listen((MouseEvent clickEvent) {
      var renameWidget = new RenameWidget(_noteName);
      renameWidget.attachBelowOf(nearestParent(clickEvent.target, type:"h2"));
      renameWidget.renameHandler = _presenter.renameNote;
      clickEvent.stopPropagation();
    });
    
    _keyboardWidget = new KeyboardWidget();
    view.query("button[name='note-input']").onClick.listen((MouseEvent clickEvent) {
      _keyboardWidget.toggleOn(view.query("#note-content"));
      clickEvent.stopPropagation();
    });
    
    view.query("button[name='note-info']").onClick.listen((MouseEvent clickEvent) {
      var detailsWidget = new NoteDetailsWidget(_presenter.noteDetails);
      detailsWidget.attachLeftOf(nearestParent(clickEvent.target, type:'li'));
      clickEvent.stopPropagation();
    });
  }
    
  set presenter(NotePresenter presenter) => _presenter = presenter; 
  
  String get template {
    String html = 
      """<article id='note' class="widget-tabbed">
            <nav class='widget-tabbed-header'>
              <h2>
                Note: <span id='note-name'></span>
              </h2>
              <ul class="horizontal-list">
                <li>
                    <button name='note-input'></button>
                </li>
                <li>
                    <button name='note-info'></button>
                </li>
              </ul>
            </nav>
            <article id='note-content' class='widget-tabbed-content'>
              <ul id='entry-list' class='vertical-list'></ul>
            </article>
         </article>
      """;
    return html;
  }
  
  void addEntry(InputEntry noteEntry) {
    String entryTemplate = 
      """<li class='entry' data-entry-id='${noteEntry.id}'>
           <ul class='vertical-list'>
             <li><p class='entry-value' contenteditable='true'>${noteEntry.value}</p></li>
             <li><p id='${noteEntry.id}' class='entry-result'></p></li>
           </ul>
         </li>
      """;
    var entryElement = new Element.html(entryTemplate);
    _entries[noteEntry.id] = entryElement;
    
    // TODO also set focus if entry-result is clicked
    // ensure current entry always points to most resently used input field
    entryElement.query('.entry-value').onFocus.listen((Event event) {
      _currentEntry = nearestParent(event.target, type:'li', clazz:'entry');
    });
    entryElement.query('.entry-result').onClick.listen((Event event) {
      _presenter.onEntrySelected(noteEntry.entryType);
    });
    
    // animations
    entryElement.style.transition = 'all 0.1s ease-in';
    entryElement.style.left = "-100px";
    entryElement.style.opacity = "0";
    
    Element resultElement = entryElement.query(".entry-result");
    resultElement.style.transition = 'opacity 0.1s ease-in';
    resultElement.style.opacity = "0";
    
    // attach and render
    _entryList.nodes.add(entryElement);
    _renderEntry(noteEntry);  

    window.setTimeout(() {
      entryElement.style.left = "0px";
      entryElement.style.opacity = "1";
    }, 1);
  }
  
  List<NoteEntry> get content => view.query("#entry-list").nodes.map(_entryFromElement);
  
  NoteEntry get currentEntry => _entryFromElement(_currentEntry);   
  
  updateTextEntry(InputEntry noteEntry, String textResult) {
    Element entryElement = _entries[noteEntry.id];
    if(entryElement.classes.contains("error-message")) {
      entryElement.classes.remove("error-message");
    }
    _renderEntry(noteEntry);
  }
  
  updateMathEntry(InputEntry noteEntry, var exprResult) {
    noteEntry.result = _render.render(exprResult);
    _renderEntry(noteEntry);
  }
  
  _renderEntry(InputEntry noteEntry) {
    if(!isNullOrEmpty(noteEntry.result)) {
      _results[noteEntry.id.value] = noteEntry.result;
      var msg = { "target": noteEntry.id.value, "mathString": noteEntry.result };
      window.postMessage(JSON.stringify(msg), '*');
    } 
  }

  clear() {
    _entryList.innerHtml = "";
    _entries.clear();
  }
  
  entryError(NoteEntry noteEntry, String errorMessage) {
    Element entryElement = _entryList.query("#${noteEntry.id}");
    entryElement.innerHtml = "${errorMessage}\n";
    entryElement.classes.add("error-message");
  }
  
  set name(String noteName) {
    // animate
    var nameHolder = view.query("#note-name");
    nameHolder.style.transition = 'all 0.1s ease-in';
    nameHolder.style.left = "-100px";
    nameHolder.style.opacity = "0";
    
    window.setTimeout(() {
      nameHolder.innerHtml = noteName;
      nameHolder.style.left = "0px";
      nameHolder.style.opacity = "1";
    }, 100);
    
    _noteName = noteName;
  }
  
  NoteEntry _entryFromElement(Element elm) {
    // TODO handle rich entries
    String value = elm.query(".entry-value").innerHtml;
    String id = elm.dataAttributes['entry-id'];
    String result = "";
    if(_results.containsKey(id)) {
      result = _results[id];
    }
    return new InputEntry.from(id, value, result);
  }
  
  showKeyboardFor(Type type) {
    _keyboardWidget.showFor(type);  
  }
  
  final Map<String,String> _results;
  final Map<Guid,Element> _entries;
  final Render _render;
  Element _currentEntry, _entryList;
  NotePresenter _presenter;
  KeyboardWidget _keyboardWidget;
  String _noteName;
}

