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
      List<String> pathSegments = url.split('/');

      int filesIndex = pathSegments.indexOf('files');

      String convertedPath = pathSegments.sublist(filesIndex).join('/');

      return convertedPath;
    } catch (e) {
      print('Error converting URL path: $e');
      return '';
    }
  }

  String removeSpaces(String phoneNumber) {
    String cleanedPhoneNumber =
        phoneNumber.replaceAll(' ', '').replaceAll('-', '');
    if (cleanedPhoneNumber.startsWith('0')) {
      return '+62${cleanedPhoneNumber.substring(1)}';
    } else {
      return cleanedPhoneNumber;
    }
  }
}
