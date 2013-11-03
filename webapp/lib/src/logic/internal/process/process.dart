// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_logic_internal;

// TODO perhaps move to harvest/cqrs

abstract class Process {
  Process(): this.fromId(new Guid());
  
  Process.fromId(this.processId);
  
  /** Run the concrete process, can only safely be called once */
  run();
  
  final Guid processId;
}