// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_common;

/// Collection helpers 

dynamic foldRight(List list, var val, func) {
  if(list.isEmpty) return val;
  return func(list.first, foldRight(tail(list), val, func));
}

List mapI(List list, func) {
  List result = [];
  for(int i=0; i<list.length; i++) {
    result.add(func(list[i],i));
  }
  return result;
}

/**
 * Get the tail of [list] 
 * 
 *     tail([1,2,3]) = [2,3]
 */
List tail(List list) {
  if(list.isEmpty) throw new RangeError('no tail of empty list'); 
  return list.length == 1 ? [] : new List.from(list.getRange(1, list.length));
}

/**
 * Get the head set of [list] 
 * 
 *     headSet([1,2,3]) = [1,2]
 */
List headSet(List list) {
  if(list.isEmpty) throw new RangeError('cannot get head of empty list');
  return new List.from(list.getRange(0, list.length - 1));
}

List addFirst(List list, var elm) => list..insert(0, elm);

List reverseList(List list) {
  List result = [];
  for(int i=(list.length - 1); i>=0; i--) {
    result.add(list[i]);
  } 
  return result;
}

/**
 * Returns the first element in [iterable] that matches [comparator]. Returns
 * [null] if no match is found
 */
dynamic firstWhere(Iterable iterable, var comparator) => iterable.firstWhere(comparator, orElse:() => null);

/** True if all the elements in [l1] are also in [l2] */
bool hasSameElements(List l1, List l2) {
  for(var e1 in l1) {
    bool found = false;
    for(var e2 in l2) {
      if(e1 == e2) {
        found = true;
        break;
      }
    }
    if(!found) {
      return false;
    }
  } 
  return true;
} 

//////////////////////
/// String helpers ///
//////////////////////

/**
 * True if [str] only contains repetitions of [match]
 */
bool containsOnly(String str, String match) {
  if((str.length < match.length) || (str.length % match.length != 0)) {
    return false;
  } else if(str.length == match.length) {
    return str == match;
  } else {
    var regexStr = "($match)" r"\1+";
    var regex = new RegExp(regexStr);
    return regex.hasMatch(str);
  }
}

String reverse(String str) {
  String result = "";
  for(int i=(str.length - 1); i>=0; i--) {
    result += str[i];
  } 
  return result;
}

notNullOrEmpty(String s) {
  if(isNullOrEmpty(s)) {
    throw new ArgumentError("string cannot be empty or null");
  }
}

bool isNullOrEmpty(String s) => s == null || s.isEmpty;

////////////////////
/// Misc helpers ///
////////////////////

smallest(num x, num y) => x < y ? x : y;

largest(num x, num y) => x > y ? x : y;

/** Trace the function call of f.*/
trace(f) {
  try {
    f();
  } catch(ex, stack) {
    print(stack);
    throw ex;
  }
}

