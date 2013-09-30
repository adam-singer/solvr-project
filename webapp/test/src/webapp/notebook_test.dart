// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_webapp_test;

class NotebookTest extends PresenterTest {
  
  NotebookTest() {
    var firstNotebookId, firstNotebookName;
    
    group('initial notebook:', () {
      test('initially one notebook should exits', () {  
        // TODO replace with tests that uses read models
        expect(1, equals(notebookViewMock.content.length));
        expect(1, equals(menuViewMock.items.length));
      });
      
      // TODO check last used

      test('notebook should have a default entry', () {
        assertEntry("Write expression here", "", 0);
      });
      
      test('notebook should have a default name', () {
        expect(notebookViewMock.name, equals("Untitled 1"));
      });
      
      test('calculate in notebook first time should add a new entry', () {
        assertCalculateEntry("2+0", "2", 0, 2);
      });
      
      test('using first entry a second time should not add a new one', () {
        assertCalculateEntry("2+1", "3", 0, 2);
      });
      
      test('using last input entry should add a new one', () {
        assertCalculateEntry("2+2", "4", 1, 3);
      });
      
      test('the last entry added should be empty', () {
        assertEntry("", "", 2);
      });
    });
    

    
    group('second notebook:', () {
      test('adding a new notebook should update screen', () {
        firstNotebookId = SessionContext.currentNotebook.id;
        
        controller.toolbarPresenter.onNewNotebook();

        expect(menuViewMock.items.length, equals(2));
      });
      
      test('notebook activity stream should be updated', () {
        assertLastActivity("NotebookCreated", SessionContext.currentNotebook.id, 2);
      });
      
      test('new notebook should have a default entry', () {
        assertEntry("Write expression here", "", 0);
      });
      
      test('add new entry to notebook', () {
        assertCalculateEntry("2+3", "5", 0, 2);
      });
    });
      
    group('switching notebooks:', () {
      test('switching notebook should update widgets', () {
        trace(() {
        controller.menuPresenter.onChangeNotebook(firstNotebookId.value);
        
        expect(SessionContext.currentNotebook.id, equals(firstNotebookId));
        });
      });
      
      test('switching notebook should update content correctly', () {
        expect(notebookViewMock.content.length, equals(3));
        assertEntry("2+1", "3", 0); 
        assertEntry("2+2", "4", 1); 
        assertEntry("", "", 2);  
      });
    });
    
    group('rename notebook', () {
      test('new name cannot be empty', () {
        expect(controller.notebookPresenter.renameNotebook(""), throwsError);
      });
      
      test('notebook name should be changed', () {
        controller.notebookPresenter.renameNotebook("new name");
        expect(notebookViewMock.name, equals("new name"));
      });
      
      test('menu list should be updated', () {
        expect(menuViewMock.curItem.name, equals("new name"));
      });
      
      test('activity stream should be updated', () {
        assertLastActivity("NotebookRenamed", SessionContext.currentNotebook.id, 3);
      });
    });
    
    group('deleting first notebook', () {
      test('should remove item from menu list ', () {
        trace(() {
        controller.menuPresenter.onDeleteItem(SessionContext.currentNotebook.id.value);
        expect(menuViewMock.items.length, equals(1));
        });
      });
      
      test('activity stream should be updated', () {
        assertLastActivity("NotebookDeleted", firstNotebookId, 4);
      });
      
      test('current notebook should switched', () {
        expect(menuViewMock.curItem, isNotNull);
        expect(firstNotebookId, notEquals(menuViewMock.curItem.id));        
      });
      
      test('trash should be updated', () {
        expect(false, isTrue, reason:"TODO write a failing test");
      });
      
      test('deleting last notebooks should cause messages to be shown ', () {
        expect(false, isTrue, reason:"TODO write a failing test");
      });
    });
   
    group('restoring first notebook', () {
      test('notebook should be restored ', () {
        expect(false, isTrue, reason:"TODO write a failing test");
      });
      
      test('trash should be updated', () {
        expect(false, isTrue, reason:"TODO write a failing test");
      });
      
      test('activity stream should be updated', () {
        expect(false, isTrue, reason:"TODO write a failing test");
      });
    });
    
    // TODO test that reloading application cuases notebooks with correct names, entries and ordering in notebook list to pop up
    // - TODO test that "resent" widget is correctly updated (store a recent, view, model)
    // - TODO test that most recent used notebook is set as current 
    // TODO test error messages are displayed on view
  }
}
