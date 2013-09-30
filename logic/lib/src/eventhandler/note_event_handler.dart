// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic;

class NoteEventHandler extends EventHandler {
  NoteEventHandler(this._activityRepo, this._itemRepo) {
    messageBus.sink(NoteCreated).add(_onNoteCreated);
    messageBus.sink(NoteDeleted).add(_onNoteDeleted);
    messageBus.sink(NoteRenamed).add(_onNoteRenamed);
    // TODO Entry ADDED/UPDATED/DELETED for search index

    _activityList = _activityRepo.getOrNew(() => new _ActivityList());
    _itemList = _itemRepo.getOrNew(() => new _ItemList());
  }
  
  _onNoteCreated(NoteCreated event) {
    _addActivity(event.noteId, NoteCreated, event.userId, "${event.username} created <a href='#'>${event.noteName}</a>");
    _itemList.addItem(new _NoteItem(event.noteId, event.noteName));
    _itemRepo.save(_itemList);
    
    messageBus.fire(new ChangeCurrentNote(event.noteId));
  }
  
  _onNoteDeleted(NoteDeleted event) {
    _addActivity(event.notebookId, NoteDeleted, event.userId, "${event.username} deleted <b>${event.notebookName}</b>");
    _itemList.removeItem(event.notebookId);
    _itemRepo.save(_itemList);
    
    _switchToLastUsed();
  }
  
  _onNoteRenamed(NoteRenamed event) {
    _addActivity(event.noteId, NoteRenamed, event.userId, "${event.username} renamed ${event.oldName} to <a href='#'>${event.newName}</a>");
    _itemList.updateItemName(event.noteId, event.newName);
    _itemRepo.save(_itemList);
  }
  
  _addActivity(Guid notebookId, Type activityType, Guid userId, String description) {
    var activity = new NoteActivity(notebookId, activityType.toString(), userId, description);
    _activityList.addActivity(activity);
    _activityRepo.save(_activityList);
  }
  
  _switchToLastUsed() {
    Item lastUsed = _itemList.getLastUsedItem();
    if(lastUsed != null) {
      if(lastUsed is NoteItem) {
        messageBus.fire(new ChangeCurrentNote(lastUsed.id));
      } else {
        throw "TODO support folders";
      }
    } else {
      throw "TODO handle case when no items exists";
      // TODO show special text when no notebooks/folders exists
    }
  }
  
  _ActivityList _activityList;
  _ItemList _itemList;
  final ModelRepository<ActivityList> _activityRepo; 
  final ModelRepository<ItemList> _itemRepo;
  static final _logger = LoggerFactory.getLogger(NoteEventHandler); 
}
