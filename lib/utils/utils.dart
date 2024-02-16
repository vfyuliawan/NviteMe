import 'package:logger/logger.dart';

class Utility {
  static final logger = Logger(
    printer: PrettyPrinter(),
  );

  static final loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );

  String extractPathFromUrl(String url) {
    try {
      // Split the path using '/'
      List<String> pathSegments = url.split('/');

      // Find the index where "files" appears
      int filesIndex = pathSegments.indexOf('files');

      // Join the path segments from "files" onwards
      String convertedPath = pathSegments.sublist(filesIndex).join('/');

      return convertedPath;
    } catch (e) {
      print('Error converting URL path: $e');
      return '';
    }
  }
}
