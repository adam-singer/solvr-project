// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_web_app;

class SettingsWidget extends CalloutWidget {
  factory SettingsWidget(Settings settings) {
    var widgetContent = new Element.html(""" 
      <div class='widget-settings'>
        <table>
          <tbody>
            <tr>
              <td>Enable automatic simplification </td>
              <td>${settings.automaticSimplify}</td>
            </tr> 
            <tr>
              <td>Show tool tips</td>
              <td>${settings.showToolTips}</td>
            </tr> 
            <tr>
              <td>Output format</td>
              <td>${settings.outputFormat}</td>
            </tr>    
          <tbody>
        <table>
      </div>
    """);
    
    return new SettingsWidget._internal(widgetContent);
  }
  
  SettingsWidget._internal(Element widgetContent): super(widgetContent);
}


