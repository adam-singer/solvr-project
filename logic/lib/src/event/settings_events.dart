// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic;

class AutomaticSimplifyChanged extends DomainEvent {
  AutomaticSimplifyChanged(this.automaticSimplify);
  
  final bool automaticSimplify;
}

class ShowToolTipsChanged extends DomainEvent {
  ShowToolTipsChanged(this.showToolTips);
  
  final bool showToolTips;
}

class OutputFormatChanged extends DomainEvent {
  OutputFormatChanged(this.formatType);
  
  final String formatType;
}

