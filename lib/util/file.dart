import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileUtils {

  FileUtils._();

  static Future<File> save(String filename, File file) async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$filename')
        .writeAsBytes(file.readAsBytesSync());
  }


  static Future<void> delete(String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$filename');
    if (file.existsSync()) {
      await File('${directory.path}/$filename').delete();
    }
  }


  static Future<File?> get(String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$filename');
    if (!(file.existsSync())) {
      return null;
    }
    return File('${directory.path}/$filename');
  }


  static Future<void> clearCache() async {
    final directory = await getTemporaryDirectory();
    for (var file in directory.listSync()) {
      try {
        file.delete();
      } catch(_) {}
    }
  }

}
