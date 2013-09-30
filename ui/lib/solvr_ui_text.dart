// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

// TODO http://api.dartlang.org/intl/IntlMessage.html

library solvr_text;

part "text/i18n/danish_repository.dart";
part "text/text_repository.dart";

// TODO load based on user preferences
TextRepository get textRepo {
  return new TextRepository();
}
