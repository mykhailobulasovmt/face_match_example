import 'package:face_match_example/common/get_template.dart';
import 'package:face_sdk_3divi/face_sdk_3divi.dart';
import 'package:flutter/foundation.dart';

double? getScore(
  Uint8List photo1,
  Uint8List photo2,
  Recognizer? recognizer,
  FacerecService? facerecService,
  Capturer? capturer,
) {
  Template? firstTemp = getTemplate(
    photo1,
    facerecService,
    capturer,
    recognizer,
  );
  Template? secondTemp = getTemplate(
    photo2,
    facerecService,
    capturer,
    recognizer,
  );

  if (firstTemp != null && secondTemp != null) {
    final match = recognizer?.verifyMatch(firstTemp, secondTemp);
    if (kDebugMode) {
      print('${match?.score}');
    }
    return match?.score;
  }
  return null;
}
