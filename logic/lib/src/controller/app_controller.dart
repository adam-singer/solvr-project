// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic;

/**
 * Main application controller responsible for coordinating views based on event and commands
 */
abstract class AppController {
  AppController(Injector injector) {
    // command handlers
    var notebookRepo = injector.getInstance(DomainRepositoryBuilder)((Guid id) => new Notebook.fromId(id), "Folder");
    var noteRepo = injector.getInstance(DomainRepositoryBuilder)((Guid id) => new Note.fromId(id), "Notebook");
    var userRepo = injector.getInstance(DomainRepositoryBuilder)((Guid id) => new User.fromId(id), "User");
    
    var notebookCommandHandler = new NotebookCommandHandler(notebookRepo);
    var noteCommandHandler = new NoteCommandHandler(noteRepo);
    var userCommandHandler = new UserCommandHandler(userRepo);
    
    // view model repositories
    var activityRepo = injector.getInstance(ModelRepositoryBuilder)("ActivityList");
    var itemRepo = injector.getInstance(ModelRepositoryBuilder)("ItemList");       
        
    // event handlers    
    var notebookEventHandler = new NotebookEventHandler();
    var noteEventHandler = new NoteEventHandler(activityRepo, itemRepo);
    var userEventHandler = new UserEventHandler();
    _bindHandlers();
  }
  
  _bindHandlers() {
    //messageBus.on[DeadEvent.TYPE].add((DeadEvent e) => _logger.warn("no event handler registered for ${e.deadMessage.type}"));
    // TODO bind history URL handler
    // TODO bind keyboard handler (see https://github.com/chrisbu/Bounce for keyboard handling)
    // TODO consider reactive dart for handling input (and showing type completion) http://phylotic.blogspot.com/2013/02/reactive-dart-series-part-3-of-n.html
  }
  
  go() {
    if(SessionContext.currentUser == null) {
      // TODO raise a application event and ask user for info
      messageBus.fire(new CreateUser("Lars Tackmann", "ltackmann@gmail.com"));
    } else {
      // TODO switch to last used notebook
    }
  }
  
  final MessageBus messageBus = new MessageBus();
  static final _logger = LoggerFactory.getLoggerFor(AppController);
}

typedef DomainRepositoryBuilder(dynamic builder(Guid id), String domainName);
typedef ModelRepositoryBuilder(String modelName);
