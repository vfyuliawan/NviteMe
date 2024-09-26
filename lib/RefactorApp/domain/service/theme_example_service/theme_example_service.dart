import 'package:nvite_me/RefactorApp/domain/model/request/theme_example/model_theme_example_inquiry.dart';
import 'package:nvite_me/RefactorApp/domain/model/response/theme_example/model_get_theme_example.dart';
import 'package:nvite_me/RefactorApp/domain/repository/theme_example/theme_example_repository.dart';

class ThemeExampleService {
  Future<ModelGetThemeExample?> themeInquiry(
      ModelThemeExampleInquiry props) async {
    final result = await ThemeExampleRepository().themeInquiry(props);
    return result;
  }
}
