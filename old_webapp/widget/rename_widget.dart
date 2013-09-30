// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_web_app;

class RenameWidget extends AcceptWidget {
  factory RenameWidget(String currentName) {
    var widgetContent = new Element.html(""" 
      <div>
         <h3>${textRepo.renameNotebook}</h3>
         <p>${textRepo.renameNotebookTip}</p>
         <input type='text' value='${currentName}'/>  
      </div>
    """);
    return new RenameWidget._internal(widgetContent);
  }

  RenameWidget._internal(Element widgetContent): super(textRepo.ok, textRepo.cancel, widgetContent) {
    this.onAccept = (MouseEvent event) {
      try {
        InputElement nameInput = widgetContent.query('input');
        renameHandler(nameInput.value);
        remove();
      } on ArgumentError catch(error) {
        this.errorMessage = error.toString();
      }
    };
    this.onDecline = (MouseEvent event) => remove();
  }
  
  var renameHandler;
}
