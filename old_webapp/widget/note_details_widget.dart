// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_web_app;

class NoteDetailsWidget extends CalloutWidget {
  factory NoteDetailsWidget(NoteDetails details) {
    var widgetContent = new Element.html(""" 
      <div class='widget-note-details'>
        <table>
          <tbody>
            <tr>
              <td>Title</td>
              <td>${details.title}</td>
            </tr> 
            <tr>
              <td>Author</td>
              <td>${details.author}</td>
            </tr> 
             <tr>
              <td>Created </td>
              <td>${details.created}</td>
            </tr>
             <tr>
              <td>Updated</td>
              <td>${details.updated}</td>
            </tr> 
            <tr>
              <td>Shared </td>
              <td>${details.shareStatus}</td>
            </tr> 
            <tr>
              <td>Syncronized</td>
              <td>${details.syncStatus}</td>
            </tr> 
            <tr>
              <td>History</td>
              <td><a href="">Snapshot information is not available</a></td>
            </tr>      
          <tbody>
        <table>
      </div>
    """);
    
    return new NoteDetailsWidget._internal(widgetContent);
  }
  
  NoteDetailsWidget._internal(Element widgetContent): super(widgetContent);
}


