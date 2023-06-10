import 'package:face_match_example/common/image_to_uint8_list.dart';
import 'package:face_match_example/main.dart';
import 'package:face_match_example/screens/main_screen/widgets/video.dart';
import 'package:face_sdk_3divi/face_sdk_3divi.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef CheckAliveness = void Function(Uint8List? myFaceImage, bool isAlive);

bool _isDone = false;

Future<dynamic> alivenessCheck({
  required Recognizer? recognizer,
  required BuildContext context,
  required FacerecService? facerecService,
  required Uint8List? myFaceImage,
  required bool? isAlive,
  required CheckAliveness callBack,
}) async {
  _isDone = false;
  if (cameras != null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoProcessing(
          cameras!,
          facerecService!,
          recognizer!,
          (liveness, template, img, mirror) async {
            callBack(
              myFaceImage = await imageToUint8List(img!),
              isAlive = liveness,
            );
            if (_isDone == false) {
              _isDone = true;
              Navigator.of(context).pop();
            }
          },
          () {
            Future.delayed(const Duration(seconds: 1)).then(
              (value) {
                Navigator.of(context).pop();
              },
            );
          },
        ),
      ),
    );
  } else {
    debugPrint('not Init');
    if (cameras == null) {
      if (kDebugMode) {
        print('error: cameras == null');
      }
    }
    if (recognizer == null) {
      if (kDebugMode) {
        print('error: _recognizer == null');
      }
    }
  }
}
