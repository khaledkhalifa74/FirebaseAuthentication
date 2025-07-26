import 'package:firebase_features/features/Authentication/presentation/manager/login_cubit/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  // change password eye icon in login
  IconData loginPasswordVisible = Iconsax.eye_slash;
  bool isLoginPasswordShown = true;

  void changeLoginPasswordVisibility() {
    isLoginPasswordShown = !isLoginPasswordShown;
    loginPasswordVisible =
    isLoginPasswordShown ? Iconsax.eye_slash : Iconsax.eye;
    emit(ChangeLoginPasswordVisibility());
  }
}