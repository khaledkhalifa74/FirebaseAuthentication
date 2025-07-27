import 'package:firebase_features/features/Authentication/presentation/manager/register_cubit/register_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  // change password eye icon in register
  IconData registerPasswordVisible = Iconsax.eye_slash;
  bool isRegisterPasswordShown = true;

  void changeRegisterPasswordVisibility() {
    isRegisterPasswordShown = !isRegisterPasswordShown;
    registerPasswordVisible =
    isRegisterPasswordShown ? Iconsax.eye_slash : Iconsax.eye;
    emit(ChangeRegisterPasswordVisibility());
  }

  // change confirm password eye icon in register
  IconData registerConfirmPasswordVisible = Iconsax.eye_slash;
  bool isRegisterConfirmPasswordShown = true;

  void changeRegisterConfirmPasswordVisibility() {
    isRegisterConfirmPasswordShown = !isRegisterConfirmPasswordShown;
    registerConfirmPasswordVisible =
    isRegisterConfirmPasswordShown ? Iconsax.eye_slash : Iconsax.eye;
    emit(ChangeRegisterPasswordVisibility());
  }
}