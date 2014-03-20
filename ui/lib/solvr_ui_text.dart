// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

// TODO http://api.dartlang.org/intl/IntlMessage.html

library solvr_text;

part "src/text/i18n/danish_repository.dart";
part "src/text/text_repository.dart";

// TODO load based on user preferences
TextRepository get textRepo {
  return new TextRepository();
}
