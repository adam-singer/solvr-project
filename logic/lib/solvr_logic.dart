// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

library solvr_logic;

import 'dart:async';

import 'package:harvest/harvest_cqrs.dart';
import 'package:solvr_common/solvr_common.dart';
import 'package:solvr_kernel/solvr_kernel.dart';

// command
part 'src/command/note_commands.dart';
part 'src/command/notebook_commands.dart';
part 'src/command/user_commands.dart';

// command handler
part 'src/commandhandler/command_handler.dart';
part 'src/commandhandler/note_command_handler.dart';
part 'src/commandhandler/notebook_command_handler.dart';
part 'src/commandhandler/user_command_handler.dart';

// controller
part 'src/controller/app_controller.dart';

// domain
part 'src/domain/info.dart';
part 'src/domain/language.dart';
part 'src/domain/note.dart';
part 'src/domain/note_entry.dart';
part 'src/domain/notebook.dart';
part 'src/domain/output_format.dart';
part 'src/domain/privilege.dart';
part 'src/domain/session_context.dart';
part 'src/domain/settings.dart';
part 'src/domain/user.dart';

// event
part 'src/event/note_events.dart';
part 'src/event/notebook_events.dart';
part 'src/event/settings_events.dart';
part 'src/event/user_events.dart';

// event handler
part 'src/eventhandler/event_handler.dart';
part 'src/eventhandler/notebook_event_handler.dart';
part 'src/eventhandler/note_event_handler.dart';
part 'src/eventhandler/user_event_handler.dart';

// read model
part 'src/readmodel/activity_list.dart';
part 'src/readmodel/item.dart';
part 'src/readmodel/item_list.dart';
part 'src/readmodel/notebook_details.dart';
part 'src/readmodel/trash.dart';

// TODO implement via currentUser.settings.utcOffset
DateTime get _utcTimeNow => (new DateTime.now());

User get _currentUser => SessionContext.currentUser;

// TODO implement via currentUser.settings.utcOffset
DateTime _localTimeFromUtc(DateTime utcTime) => utcTime;  

assertEquals(var x, var y, {String error: null}) {
  if(x != y) {
    if(error == null) {
      error = '$x does not equal $y';
    }
    throw new ArgumentError(error);
  }
}
