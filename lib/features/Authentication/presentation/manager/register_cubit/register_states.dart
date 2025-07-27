abstract class RegisterStates {}

class RegisterInitial extends RegisterStates {}

// change password visibility
class ChangeRegisterPasswordVisibility extends RegisterStates {}
class ChangeRegisterConfirmPasswordVisibility extends RegisterStates {}

// register
class StartLoadingRegisterState extends RegisterStates {}
class StopLoadingRegisterState extends RegisterStates {}
class RegisterSuccessState extends RegisterStates {}
class RegisterFailureState extends RegisterStates {
  String? errorMessage;
  RegisterFailureState({this.errorMessage});
}