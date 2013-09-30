// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic_api;

class UserSetupCompleted extends ApplicationEvent {
  UserSetupCompleted({this.userId, this.processId});
  
  final Guid userId, processId;
}

