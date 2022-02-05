import 'dart:io';

String readJson(String name) {
  var current = Directory.current.path;

  if (current.endsWith('/test')) {
    current = current.replaceAll('/test', '');
  }

  if (current.endsWith('tv_series')) {
    return File('$current/test/$name').readAsStringSync();
  }
  return File('$current/tv_series/test/$name').readAsStringSync();
}
