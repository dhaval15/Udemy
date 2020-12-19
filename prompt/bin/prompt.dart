import 'dart:io';
import 'package:image/image.dart';

import 'package:prompter/prompter.dart';

void main() {
  final prompter = Prompter();
  final choice = prompter.askBinary('Are you here for image conversion?');
  if (!choice) exit(0);
  final imageType = prompter.askMultiple('Convert to :',
      [Option('PNG', 'png'), Option('JPEG', 'jpg'), Option('RAW Text', 'txt')]);
  final entity = prompter.askMultiple('Choose Image :', buildFileOptions());
  convert(entity, imageType);
  prompter.clear();
}

List<Option> buildFileOptions() {
  return Directory.current.listSync().where((entity) {
    return FileSystemEntity.isFileSync(entity.path) &&
        entity.path.contains(RegExp(r'\.(jpg|png|jpeg)'));
  }).map((entity) {
    final label = entity.path.split(Platform.pathSeparator).last;
    return Option(label, entity);
  }).toList();
}

void convert(FileSystemEntity entity, String extension) {
  final rawImage = File(entity.path).readAsBytesSync();
  if (extension == 'txt') {
    File(newPath(entity.path, extension)).writeAsString(rawImage.toString());
    return;
  }
  final image = decodeImage(rawImage);
  List<int> newImage;
  if (extension == 'jpg') {
    newImage = encodeJpg(image);
  } else if (extension == 'png') {
    newImage = encodePng(image);
  } else {
    print('Unsupported type');
  }
  File(newPath(entity.path, extension)).writeAsBytesSync(newImage);
}

String newPath(String path, String newExtension) {
  return path.replaceAll(RegExp(r'\.(png|jpeg|jpg)'), '.$newExtension');
}
