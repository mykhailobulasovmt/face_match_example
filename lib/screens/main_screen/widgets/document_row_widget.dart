import 'package:face_match_example/common/get_score.dart';
import 'package:face_sdk_3divi/face_sdk_3divi.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef Score = void Function(double score);

class DocumentRowWidget extends StatefulWidget {
  const DocumentRowWidget({
    super.key,
    required this.checkImage,
    required this.myImage,
    required this.recognizer,
    required this.facerecService,
    required this.capturer,
    required this.callBack,
    required this.buttonText,
  });

  final Uint8List? checkImage;
  final Uint8List? myImage;
  final Recognizer? recognizer;
  final FacerecService? facerecService;
  final Capturer? capturer;
  final Score callBack;
  final String buttonText;

  @override
  State<DocumentRowWidget> createState() => _DocumentRowWidgetState();
}

class _DocumentRowWidgetState extends State<DocumentRowWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            height: 150,
            child: Image.memory(widget.checkImage!),
          ),
          const SizedBox(
            width: 5,
          ),
          TextButton(
            onPressed: () {
              widget.callBack(
                double.parse(getScore(
                        widget.myImage!, widget.checkImage!, widget.recognizer, widget.facerecService, widget.capturer)!
                    .toStringAsFixed(3)),
              );
            },
            child: Text(widget.buttonText),
          ),
        ],
      ),
    );
  }
}
