class ModelLoginForm {
  final String username;
  final String password;
  final bool isPasswordVisible;
  final bool isDisableButton;

  ModelLoginForm(
      {required this.username,
      required this.password,
      required this.isPasswordVisible,
      required this.isDisableButton});

  ModelLoginForm.initial()
      : username = '',
        password = '',
        isPasswordVisible = true,
        isDisableButton = false;

  ModelLoginForm copyWith({
    String? username,
    String? password,
    bool? isPasswordVisible,
    bool? isDisableButton,
  }) {
    return ModelLoginForm(
        username: username ?? this.username,
        password: password ?? this.password,
        isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
        isDisableButton: isDisableButton ?? this.isDisableButton);
  }
}
