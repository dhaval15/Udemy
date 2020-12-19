import 'dart:io';
import 'package:image/image.dart';

import 'package:prompter/prompter.dart';

void main() {
  final prompter = Prompter();
  final entity = prompter.askMultiple('Choose Image :', buildFileOptions());
  convert(entity);
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

void convert(FileSystemEntity entity) {
  final rawImage =
      File(entity.path).readAsBytesSync().map((i) => i + 10).toList();
  final image = decodeImage(rawImage);
  final newImage = encodeJpg(image);
  File(newPath(entity.path)).writeAsBytesSync(newImage);
}

String newPath(String path) {
  return '$path.raw';
}
