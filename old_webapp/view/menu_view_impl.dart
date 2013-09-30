// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_web_app;

class MenuViewImpl extends AbstractView implements MenuView {
  MenuPresenter _presenter;
  String _currentItemId;
  Element _items;
  
  MenuViewImpl(Element container): super(container) {
    _items = view.query("#item-list");
    
    view.query("button[name='delete']").onClick.listen((Event e) => _presenter.onDeleteItem(_currentItemId));
    view.query("button[name='grid']").onClick.listen((Event e) => _presenter.onShowGrid());
  }
  
  set presenter(MenuPresenter p) => _presenter = p;
  
  String get template => null'
  
  addFolder(FolderItem folder) {
    throw "TODO add folder";
  }
  
  addNotebook(NotebookItem notebook) {
    final Element item = new Element.html("""
        <li class='notebook-item item' data-item-id=${notebook.id.value}>
          <p>
            <img src='public/icons/document_24.png'/>
            <span class='item-name'>${notebook.name}</span>
          </p>
          <span class='menu-pointer'/>
        </li>
     """);
    _items.nodes.add(item);
    
    item.on.mouseDown.add((MouseEvent event) {
      Element notebookElm = nearestParent(event.target, 'li');
      if(!notebookElm.classes.contains("active")) {
        _presenter.onChangeNotebook(notebook.id.value);
      }
    });
  }
 
  set currentItem(String itemId) {
    view.queryAll(".item").forEach((Element e) {
      if(e.dataAttributes["item-id"] == itemId) {
        // set new active
        e.classes.add("active");
      } else if(e.classes.contains("active")) {
        // remove old active
        e.classes.remove("active");
      }
    });
    _currentItemId = itemId;
  }
  
  updateItemName(Item item) => _getItem(item).query('.item-name').innerHTML = item.name;
  
  removeItem(Item item) => _getItem(item).remove();
  
  showItemGrid(ItemList itemList) {
    var navContent = new Element.html("<ul class='vertical-list'></ul>");
    var gridContent = new Element.html("<ul class='vertical-list'></ul>");
    var widget = new GridWidget(navContent, gridContent);
    
    itemList.forEach((Item item) {
      var itemElement = new Element.html("<li class='notebook-item item'>${item.name}</li>");
      itemElement.on.mouseDown.add((MouseEvent event) {
        widget.remove();
        _presenter.onChangeNotebook(item.id.value);
      });
      gridContent.nodes.add(itemElement);
    });
    
    widget.attachTo(view);
  }
  
  Element _getItem(Item item) => view.query("li[data-item-id='${item.id.value}']");
}

