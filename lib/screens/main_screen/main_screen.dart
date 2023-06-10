import 'package:face_match_example/common/aliveness_check.dart';
import 'package:face_match_example/common/create_service.dart';
import 'package:face_match_example/common/get_lib_dir.dart';
import 'package:face_match_example/common/init_images.dart';
import 'package:face_match_example/main.dart';
import 'package:face_match_example/screens/main_screen/widgets/document_row_widget.dart';
import 'package:face_sdk_3divi/face_sdk_3divi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const _platform = MethodChannel('samples.flutter.dev/facesdk');

  FacerecService? _facerecService;
  Recognizer? _recognizer;

  bool _isLoading = false;
  String? _libDir;
  Capturer? _capturer;
  double? _score;
  bool? _isAlive;

  Uint8List? _myDocumentImage;
  Uint8List? _anotherDocumentImage;
  Uint8List? _anotherDocumentImage2;
  Uint8List? _myFaceImage;

  @override
  void initState() {
    super.initState();
    initImages(
            myDocumentImage: _myDocumentImage,
            anotherDocumentImage: _anotherDocumentImage,
            anotherDocumentImage2: _anotherDocumentImage2,
            myFaceImage: _myFaceImage,
            callBack: (myDocImage, anotherImage, anotherImage2, myImage) {
              setState(() {
                _myDocumentImage = myDocImage;
                _anotherDocumentImage = anotherImage;
                _anotherDocumentImage2 = anotherImage2;
                _myFaceImage = myImage;
              });
            })
        .then((value) => getLibDir(
            platform: _platform,
            callBack: (result) {
              setState(() {
                _libDir = result;
              });
            }).whenComplete(() => createService(
            capturer: _capturer,
            dataDir: dataDir,
            libDir: _libDir,
            facerecService: _facerecService,
            recognizer: _recognizer,
            callBack: (facerecService, recognizer, capturer) {
              _facerecService = facerecService;
              _recognizer = recognizer;
              _capturer = capturer;
            })))
        .whenComplete(() => _isLoading = true);
  }

  @override
  void dispose() {
    super.dispose();
    if (_capturer != null) {
      _capturer!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 150,
                      child: ElevatedButton(
                        onPressed: () => alivenessCheck(
                            context: context,
                            isAlive: _isAlive,
                            recognizer: _recognizer,
                            facerecService: _facerecService,
                            myFaceImage: _myFaceImage,
                            callBack: (myFaceImage, isAlive) {
                              setState(() {
                                _myFaceImage = myFaceImage;
                                _isAlive = isAlive;
                              });
                            }),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                        ),
                        child: _myFaceImage == null
                            ? const Text('Check aliveness')
                            : Image.memory(
                                _myFaceImage!,
                              ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text('$_score'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text('$_isAlive'),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    DocumentRowWidget(
                      checkImage: _myDocumentImage,
                      myImage: _myFaceImage,
                      facerecService: _facerecService,
                      recognizer: _recognizer,
                      capturer: _capturer,
                      callBack: (result) => setState(() {
                        _score = result;
                      }),
                      buttonText: 'check with me',
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    DocumentRowWidget(
                      checkImage: _anotherDocumentImage,
                      myImage: _myFaceImage,
                      facerecService: _facerecService,
                      recognizer: _recognizer,
                      capturer: _capturer,
                      callBack: (result) => setState(() {
                        _score = result;
                      }),
                      buttonText: 'check with women',
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    DocumentRowWidget(
                      checkImage: _anotherDocumentImage2,
                      myImage: _myFaceImage,
                      facerecService: _facerecService,
                      recognizer: _recognizer,
                      capturer: _capturer,
                      callBack: (result) => setState(() {
                        _score = result;
                      }),
                      buttonText: 'check with men',
                    ),
                  ],
                ),
              ],
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  Text('Loading...'),
                ],
              ),
            ),
    );
  }
}
