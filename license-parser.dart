import 'dart:io';

class XMLParser {
  String fileData = "";

  void printLicense() async {
    File file = File("license.xml");
    fileData = await file.readAsString();

    removeAllSpaces();

    // Showing the data inside license tag.
    try {
      String licenseData = fileData.substring(
          fileData.indexOf('<license'), fileData.indexOf('</license>'));
      print("\n\n\n\n\n\n\n\n\n\n----------START OF LICENSE----------");
      print("\n=======================================================");
      printLicenseAttributes();
      print("=======================================================\n");
      parseFileData(licenseData);
      print("-----------END OF LICENSE-----------");
    } catch (e) {
      print(
          "\n\n\n\n\nSomething went wrong! Kindly check the license file we received.. ");
      print("---------CONTENT BEGINNING----------");
      print(fileData);
      print("-----------CONTENT ENDING-----------");
      print("\n\n-------------ERROR LOG--------------");
      print(e);
      print(
          "\n\n\n\n\nIf this problem persists, consider typing in correct SPDX-Identifier or from \nhttps://github.com/spdx/license-list-XML/tree/master/src\n\n\n\n\n");
    }
  }

  void removeAllSpaces() {
    int startPos = 0;
    fileData += '\n\n';
    String refactordString = "";
    while (startPos != -1 && startPos < fileData.length) {
      int lineBreak = fileData.indexOf('\n', startPos);
      String line = fileData.substring(startPos, lineBreak);
      refactordString += line.trim();
      startPos = lineBreak + 1;
    }
    fileData = refactordString.replaceAll('<p>', '');
    fileData = fileData.replaceAll('</p>', '\n');
    fileData = fileData.replaceAll('<bullet>', '*');
    fileData = fileData.replaceAll('</bullet>', ' ');
  }

  printLicenseAttributes() {
    String tag_open = "<license";

    int start_index = fileData.indexOf(tag_open);

    // Get options relating to the tag
    int start_of_options = fileData.indexOf(' ', start_index + 1);
    start_index = fileData.indexOf('>', start_index + 1) + 1;
    if (start_of_options < start_index) {
      String text = fileData.substring(start_of_options + 1, start_index - 1);
      text = text.trim();
      String licenseTags = "";
      Map<String, String> options = {};
      int start_pos = 0;
      while (start_pos != -1 && start_pos < text.length) {
        int pos_equal = text.indexOf('=', start_pos);
        String key = text.substring(start_pos, pos_equal);

        int pos_value_start = pos_equal + 2;
        int pos_value_end = text.indexOf('"', pos_equal + 2);
        String value = text.substring(pos_value_start, pos_value_end);

        options[key] = value;
        licenseTags += "$key:$value | ";

        start_pos = pos_value_end + 2;
      }

      print(licenseTags.substring(0, licenseTags.length - 2));
    }
  }

  void parseFileData(String data) {
    int endIndex = data.length;
    // Change opening tags to headings and closing tags to horizontal rule
    while (true) {
      if (data.startsWith('</')) {
        print("-------------------------------------------------------\n");
        endIndex = data.indexOf('>') + 1;
        while (data.startsWith('</')) {
          endIndex = data.indexOf('>') + 1;
          data = data.substring(endIndex);
        }
        endIndex = 0;
      } else if (data.startsWith('<')) {
        endIndex = data.indexOf('>') + 1;
      } else {
        endIndex = data.indexOf('<');
        endIndex = (endIndex < 0) ? data.length : endIndex;
        print(data.substring(0, endIndex));
        endIndex;
      }
      if (endIndex >= data.length) break;
      data = data.substring(endIndex);
    }
  }
}
