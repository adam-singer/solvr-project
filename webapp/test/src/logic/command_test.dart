// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic_test;

class CommandTest {
  CommandTest(this._messageBus, this._repository) {
    group('notebook commands -', () {
      var notebookName = "notebook name";
      
      test('initial state', () {
        expect(_repository.starredNotes, hasLength(0));
        expect(_repository.sharedNotes, hasLength(0));
        expect(_repository.notebooks, hasLength(1), reason:'initially one notebook should exists');
        // TODO expect((_repository.activeResource as NotebookViewModel).name, equals('Scrapbook'), reason:'initially scrapbook should be active');
      });
      
      test('create notebook', () {
        var command = new CreateNotebook(notebookName);
        command.broadcastOn(_messageBus).then(expectAsync1((_) {
          expect(_repository.notebooks, hasLength(2), reason:'new notebook should be created');
          // TODO expect((_repository.activeResource as NotebookViewModel).name, equals(notebookName), reason:'new notebook should be active');
        }));
      });
    });
  }
  
  final MessageBus _messageBus;
  final ViewModelRepository _repository;
}