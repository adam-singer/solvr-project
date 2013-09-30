// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic;

/**
 * A [NoteEntry] that contains rich text
 */
class RichEntry extends NoteEntry {
  RichEntry()
    : value = "",
      super.guid(new Guid());
  
  bool equals(RichEntry other) => (other.id == id) && (other.value == value);
  
  String value;
}

/**
 * A [NoteEntry] that can be evaluated
 */
class InputEntry extends NoteEntry {
  InputEntry(): this.guid(new Guid()); 
  
  InputEntry.guid(Guid guid)
    : value = "", 
      result = "",
      super.guid(guid);
  
  InputEntry.from(String guid, this.value, this.result): super.from(guid);
  
  bool equals(InputEntry other) => (other.id == id) && (other.value == value) && (other.result == result);
  
  String toString() => "id:[$id] value:[$value]";
  
  String value, result;
  Type entryType;
}

class InputEntryError implements Error {
  const InputEntryError(this.entry, this.error); 
  
  String toString() => "Error: ${error} for entry: ${entry}";
  
  final InputEntry entry;
  final String error;
}

/**
 * A single entry in a [Note]
 */
abstract class NoteEntry  {
  NoteEntry.from(String guid)
    : id = new Guid.fromValue(guid); 
  
  NoteEntry.guid(this.id);
  
  int get hashCode => id.hashCode;
  
  set parent(NoteEntry p) {
    _parent = p;
    _parent.child = this;
  }
  
  NoteEntry get parent => _parent;
  
  operator ==(NoteEntry other) => equals(other);
  
  bool equals(NoteEntry other);
  
  NoteEntry _parent;
  NoteEntry child;
  final Guid id;
}

