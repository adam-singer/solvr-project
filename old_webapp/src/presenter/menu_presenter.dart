// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_web;

class MenuPresenter extends Presenter {
  MenuPresenter(this._view, this._itemList): _logger = LoggerFactory.getLogger(MenuPresenter) {
    _view.presenter = this;
    _itemList.onItemAdded = _onItemAdded;
    _itemList.onItemUpdated = _onItemUpdated;
    _itemList.onItemRemoved = _onItemRemoved;
    _itemList.onItemChanged = _onItemChanged;
  }
  
  _onItemAdded(Item item) {
    if(item is NotebookItem) {
      _view.addNotebook(item);
    } 
    _view.addNote(item);
  }
  
  _onItemUpdated(Item item) => _view.updateItemName(item);
  
  _onItemRemoved(Item item) {
    _view.removeItem(item);
    // TODO if item list is empty then show special text
  }
  
  _onItemChanged(Item item) {
    _view.currentItem = item.id.value;
  }
  
  onChangeNote(String noteId) {
    messageBus.fire(new ChangeCurrentNote(_asGuid(noteId)));
  }
  
  onDeleteItem(String itemId) {
    Item item = _itemList.getItem(_asGuid(itemId));
    if(item is NoteItem) {
      messageBus.fire(new DeleteNote(item.id)); 
    } else {
      messageBus.fire(new DeleteNotebook(item.id));
    }
  }
  
  onShowGrid() => _view.showItemGrid(_itemList);
  
  Guid _asGuid(String id) => new Guid.fromValue(id);
  
  final ItemList _itemList;
  final Logger _logger;
  final MenuView _view;
}

abstract class MenuView extends View {
  addNotebook(NotebookItem Notebook);
  
  addNote(NoteItem Note);
  
  set currentItem(String itemId);
  
  updateItemName(Item item);
  
  removeItem(Item item);
  
  showItemGrid(ItemList itemList);
}

