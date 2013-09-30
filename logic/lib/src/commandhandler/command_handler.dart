// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic;

abstract class CommandHandler {
  CommandHandler(): messageBus = new MessageBus();
  
  inContext(Message msg, Logger logger, f) {
    String contextName = msg.runtimeType.toString();
    logger.putContext(contextName, contextName);
    try {
      f();
    } finally {
      logger.removeContext(contextName);
    }
  }
  
  final MessageBus messageBus;
}

