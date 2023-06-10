import 'package:face_sdk_3divi/face_sdk_3divi.dart';
import 'package:flutter/foundation.dart';

Template? getTemplate(
  Uint8List image,
  FacerecService? facerecService,
  Capturer? capturer,
  Recognizer? recognizer,
) {
  try {
    if (facerecService == null || capturer == null) {
      return null;
    }
    List<RawSample> result = capturer.capture(image);
    if (result.isNotEmpty) {
      for (var i = 0; i < result.length; i += 1) {
        if (result.length == 1) {
          return result.isEmpty ? null : recognizer!.processing(result[i]);
        }
        result[i].dispose();
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('get Template error $e');
    }
    return null;
  }
  return null;
}
