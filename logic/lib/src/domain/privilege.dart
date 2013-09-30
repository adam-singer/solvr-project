// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited. 

part of solvr_logic;

/**
 * Access rights on a [Note]
 */
class Privilege {
  /// When true the [Note] is publicly accessible
  bool publicReadable;
  /// When true the [Note] is publicly forkable (people can it and edit the clone)
  bool publicForkable;
  /// List of [Guid]'s of [User]'s who can read this note
  List<Guid> redableBy;
  /// List of [Guid]'s of [User]'s who can fork this note
  List<Guid> forkableBy;
}
