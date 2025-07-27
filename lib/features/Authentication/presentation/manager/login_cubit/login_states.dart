abstract class LoginStates {}

class LoginInitial extends LoginStates {}

// change password visibility
class ChangeLoginPasswordVisibility extends LoginStates {}

// login
class StartLoadingLoginState extends LoginStates {}
class StopLoadingLoginState extends LoginStates {}
class LoginSuccessState extends LoginStates {}
class LoginFailureState extends LoginStates {
  String? errorMessage;
  LoginFailureState({this.errorMessage});
}
