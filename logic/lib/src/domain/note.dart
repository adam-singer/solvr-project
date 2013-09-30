// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic;

/** A note in a [Notebook] */
class Note extends AggregateRoot {
  factory Note(String noteName) { 
    var note = new Note._internal();
    note.applyChange(new NoteCreated(new Guid(), noteName, _currentUser.id, _currentUser.name, _utcTimeNow));
    return note;
  }
  
  factory Note.fromId(Guid notebookId) { 
    var note = new Note._internal();
    note.id = notebookId;
    return note;
  }
  
  Note._internal() {
    if(_handlers.isEmpty) {
      _registerHandlers();  
    }
  }
  
  static _registerHandlers() {
    _handlers[(e) => e is NoteCreated] = (NoteCreated event, Note note) {
      note._name = event.noteName;
      note._author = event.username;
      note._createdAt = _localTimeFromUtc(event.createdAtUtc);
      if(note.id == null) {
        note.id = event.noteId;
      } else {
        assertEquals(note.id, event.noteId);
      }
    };
    _handlers[(e) => e is NoteUpdated] = (NoteUpdated event, Note note) {
      note._updatedAt = _localTimeFromUtc(event.updatedAtUtc);
    };
    _handlers[(e) => e is NoteRenamed] = (NoteRenamed event, Note note) {
      note._name = event.newName;
    };
    _handlers[(e) => e is InputEntryAdded] = (InputEntryAdded event, Note note) {
      var entry = new InputEntry.guid(event.entryId);
      entry.value = event.value;
      if(note._contentRoot == null) {
        note._contentRoot = entry;
      } else {
        var parent = note._contentRoot;
        while(parent.child != null) {
          parent = parent.child;
        }
        entry.parent = parent;
      }
    };
    _handlers[(e) => e is InputEntryDeleted] = (InputEntryDeleted event, Note note) {
      var entryToDelete = note.getEntry(event.entryId);
      if(entryToDelete == note._contentRoot) {
        note._contentRoot = entryToDelete.child; 
      } else {
        entryToDelete.parent.child = entryToDelete.child;
      }
    };
    _handlers[(e) => e is InputEntryUpdated] = (InputEntryUpdated event, Note note) {
      InputEntry entryToUpdate = note.getEntry(event.entryId);
      entryToUpdate.value = event.value;
      entryToUpdate.result = event.result;
      entryToUpdate.entryType = event.entryType;
    };
  }
  
  apply(var event) {
    _handlers.forEach((EventTypeMatcher matcher, EventTypeHandler handle) {
      if(matcher(event)) {
        handle(event, this);
      }
    });
  }
  
  InputEntry addInputEntry([String value = ""]) {
    var entryId = new Guid();
    applyChange(new InputEntryAdded(id, entryId, value, _utcTimeNow));
    return getEntry(entryId);
  }
  
  deleteEntry(Guid entryId) {
    applyChange(new InputEntryDeleted(id, entryId, _utcTimeNow));
  }
  
  NoteEntry getEntry(Guid entryId) {
    var entry = _contentRoot;
    while(entry.child != null && entry.id != entryId) {
      entry = entry.child;
    }
    assertEquals(entryId, entry.id, error:"unable to find $entryId");
    return entry;
  }
  
  List<NoteEntry> get content {
    var res = new List<NoteEntry>();
    var entry = _contentRoot;
    while(entry != null) {
      res.add(entry);
      entry = entry.child;
    }
    return res;
  }
  
  set content(List<NoteEntry> entries) {
    entries.forEach((var entry) {
      var orig = getEntry(entry.id);
      if(entry != orig) {
        applyChange(new InputEntryUpdated(id, entry.id, entry.value, entry.result, entry.area, _utcTimeNow));
      }
    });
  }
  
  Future<InputEntry> evaluateEntry(InputEntry entry) {
    _logger.debug("evaluate entry: $entry");
    var completer = new Completer<InputEntry>();
    try {
      // TODO execute in heavy isolate 
      // TODO move evaluation code to eventhandler and add notebook view model
      
      // Evaluate
      var expr;
      if(_currentUser.settings.automaticSimplify) {
        expr = _kernel.evaluate(entry.value);
      } else {
        expr = _kernel.parse(entry.value);
      }
      var type = expr.type;
      var result = expr.toString();
      
      // Update
      applyChange(new InputEntryUpdated(id, entry.id, entry.value, result, type, _utcTimeNow));
      completer.complete(getEntry(entry.id));
    } catch(e) {
      completer.completeError(e);
    }
    
    return completer.future; 
  }

  bool get isEmpty => content.length == 0;
  
  String get author => _author;
  
  String get name => _name;
  
  set name(String newName) {
    notNullOrEmpty(newName);
    if(newName != name) {
      applyChange(new NoteRenamed(id, name, newName, _currentUser.id, _currentUser.name, _utcTimeNow));
    }
  }
  
  delete() => applyChange(new NoteDeleted(id, name, _currentUser.id, _currentUser.name, _utcTimeNow));
  
  DateTime get createdAt => _createdAt;
  
  DateTime get updatedAt => _updatedAt;
  
  NoteEntry _contentRoot;
  DateTime _createdAt, _updatedAt;
  Language _language;
  String _author, _name;
  final Kernel _kernel = new Kernel();
  static final _logger = LoggerFactory.getLogger(Note);
  static final _handlers = new Map<Type, EventTypeHandler>();
}

typedef void EventTypeHandler(DomainEvent event, AggregateRoot domain);


