// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

/*
class NoteManagementTest {
  group('', () {
    var historyList = new HistoryList();
    var trash = new Trash();
    // create notebook
    var rootNotebook = new Notebook.root(historyList);
    rootNotebook.addNote(new Note('b note'));
    rootNotebook.addNote(new Note('c note'));
    rootNotebook.addNote(new Note('a note'));
    expect(roteNotebook.content, orderdEquals(['a note', 'b note', 'c note']));
    
    // add notebook to notebook
    var anotherNotebook = new Notebook.child('a notebook', anotherNotebook);
    expect(roteNotebook.content, orderdEquals(['a notebook', 'a note', 'b note', 'c note']));
    expect(anotherNotebook.isEmpty, isTrue);
    
    // move notebook
    var noteA = rootNotebook.getNote('a note');
    var noteB = rootNotebook.getNote('b note');
    rootNotebook.move(noteA, anotherNotebook);
    rootNotebook.move(noteB, anotherNotebook);
    expect(roteNotebook.content, orderdEquals(['a notebook', 'c note']));
    expect(anotherNotebook.content, orderdEquals(['a note', 'b note']));
    
    // check history (one history is maintained pr rootNote)
    expect(identical(roteNotebook.history, anotherNotebook.history))
    
    // trash
    expect(trash.content.isEmpty, isTrue);
    noteB.delete();
    expect(trash.content, ['b note'];
    expect(anotherNotebook.content, orderdEquals(['a note']));
    
    // restore from trash
    trash.restore(nBote);
    expect(trash.content.isEmpty, isTrue);
    expect(anotherNotebook.content, orderdEquals(['a note', 'b note']));
    
    // trash note and notebook
    noteA.delete();
    anotherNotebook.delete();
    expect(trash.content, ['a note', 'a notebook'];
    trash.empty(anotherNotebook);
    expect(trash.content, ['a note'];
    
    // restore from trash when old parent is dead
    trash.restore(noteA);
    expect(roteNotebook.content, orderdEquals(['a note', 'c note']));
    
    // fail at deleting rootNotebook
    expect(() => roteNotebook.delete(), throwsException);
  });
}
*/