// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_web_app;

class ShareWidget extends AcceptWidget {
  factory ShareWidget(String notebookName) {
    var widgetContent = new Element.html(""" 
      <div>
         <h3>${textRepo.share}</h3>
         <p>${textRepo.shareNotebook(notebookName)}<p/>  
      </div>
    """);
    return new ShareWidget._internal(widgetContent);
  }

  ShareWidget._internal(Element widgetContent): super(textRepo.ok, textRepo.cancel, widgetContent) {
    this.onAccept = (MouseEvent event) {
      remove();
    };
    this.onDecline = (MouseEvent event) => remove();
  }
}
