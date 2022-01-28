import 'dart:io';

String readJson(String name) {
  final current = Directory.current;
  var dir = Uri.directory('${current.path}/movie').path;

  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  return File('$dir/test/$name').readAsStringSync();
}
