import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';

/// prepare the media file to network portable file
class MultipartConverter {
  /// convert a image file to multipart file
  Future<http.MultipartFile> imageToMultipartConverter(
      File file, String attribute) async {
    var stream = http.ByteStream(file.openRead());
    stream.cast();
    var length = await file.length();

    final multipartFile = http.MultipartFile(
      attribute,
      stream,
      length,
      filename: basename(file.path),
    );

    return multipartFile;
  }
}
