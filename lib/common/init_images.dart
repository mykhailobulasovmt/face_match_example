import 'package:flutter/services.dart';

typedef InitiateImages = void Function(
  Uint8List? myDocumentImage,
  Uint8List? anotherDocumentImage,
  Uint8List? anotherDocumentImage2,
  Uint8List? myFaceImage,
);

Future<void> initImages({
  Uint8List? myDocumentImage,
  Uint8List? anotherDocumentImage,
  Uint8List? anotherDocumentImage2,
  Uint8List? myFaceImage,
  required InitiateImages callBack,
}) async {
  final ByteData bytesMyFaceImage = await rootBundle.load('assets/images/my_face.jpeg');
  final ByteData bytesMyDocumentImage = await rootBundle.load('assets/images/my_document_image.bmp');
  final ByteData bytesAnotherDocumentImage = await rootBundle.load('assets/images/another_document_image.png');
  final ByteData bytesAnotherDocumentImage2 = await rootBundle.load('assets/images/another_document_image2.png');

  callBack(
    myDocumentImage = bytesMyDocumentImage.buffer.asUint8List(),
    anotherDocumentImage = bytesAnotherDocumentImage.buffer.asUint8List(),
    anotherDocumentImage2 = bytesAnotherDocumentImage2.buffer.asUint8List(),
    myFaceImage = bytesMyFaceImage.buffer.asUint8List(),
  );
}
