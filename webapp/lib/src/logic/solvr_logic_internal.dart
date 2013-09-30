// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

/// internal business logic that should not be exposed
library solvr_logic_internal;

import 'dart:async';

import 'package:dice/dice.dart';
import 'package:log4dart/log4dart.dart';
import 'package:meta/meta.dart';

import 'solvr_logic_api.dart';

part 'internal/commandhandler/note_command_handler.dart';
part 'internal/commandhandler/user_command_handler.dart';

part 'internal/domain/note.dart';
part 'internal/domain/user.dart';

part 'internal/process/user_setup_process.dart';

part 'internal/event_handlers.dart';
part 'internal/process_manager.dart';
part 'internal/repository_impl.dart';
part 'internal/viewmodel_impl.dart';


