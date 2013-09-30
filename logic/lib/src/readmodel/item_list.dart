// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic;

abstract class ItemList extends IdModel {
  Item getLastUsedItem();
  
  bool isEmpty();
  
  Item getItem(Guid itemId);
  
  forEach(f(Item));
  
  ItemListener onItemAdded;
  
  ItemListener onItemUpdated;
  
  ItemListener onItemRemoved;
  
  ItemListener onItemChanged;
}


