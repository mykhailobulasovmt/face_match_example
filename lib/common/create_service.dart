import 'package:face_sdk_3divi/face_sdk_3divi.dart';

typedef Create = void Function(FacerecService? facerecService, Recognizer? recognizer, Capturer? capturer);

void createService(
    {String? dataDir,
    String? libDir,
    FacerecService? facerecService,
    Capturer? capturer,
    Recognizer? recognizer,
    required Create callBack}) {
  if (dataDir == '' || libDir == '') {
    return;
  }
  callBack(
    facerecService = FaceSdkPlugin.createFacerecService(
      "${dataDir!}/conf/facerec",
      "$dataDir/license",
      "${libDir!}/${FaceSdkPlugin.nativeLibName}",
    ),
    recognizer = facerecService.createRecognizer("method10v30_recognizer.xml"),
    capturer = facerecService.createCapturer(
      Config("common_capturer4_fda_singleface.xml").overrideParameter("score_threshold", 0.4),
    ),
  );
}
