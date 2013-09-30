// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_webapp_test;

class PresenterTest {
  PresenterTest() {
    toolbarViewMock = new ToolbarViewMock();
    menuViewMock = new MenuViewMock();
    notebookViewMock = new NotebookViewMock();
    widgetsViewMock = new WidgetsViewMock();
    
    var module = new MockModule(menuViewMock, toolbarViewMock, notebookViewMock, widgetsViewMock);
    var controller = new MockAppController(module);
    controller.go();
  }
  
  assertLastActivity(String activity, Guid notebookId, int length) {
    final int entryNr = 0;
    expect(activity, equals(widgetsViewMock.activities[entryNr].type));
    expect(notebookId, equals(widgetsViewMock.activities[entryNr].notebookId));
    expect(length, equals(widgetsViewMock.activities.length));
  }
  
  assertCalculateEntry(String value, String result, int entryNr, int length) {
    notebookViewMock.content[entryNr].value = value;
    notebookViewMock.currentEntry = notebookViewMock.content[entryNr];
    controller.toolbarPresenter.onEvaluate();
    
    assertEntry(value, result, entryNr);
    expect(length, equals(notebookViewMock.content.length));
  }
  
  assertEntry(String value, String result, int entryNr) {
    expect(value, equals(notebookViewMock.content[entryNr].value));
    expect(result, equals(notebookViewMock.content[entryNr].result));
  }
  
  ToolbarViewMock toolbarViewMock;
  MenuViewMock menuViewMock;
  NotebookViewMock notebookViewMock;
  WidgetsViewMock widgetsViewMock;
}
