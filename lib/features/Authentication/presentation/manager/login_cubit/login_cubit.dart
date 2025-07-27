import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_features/features/Authentication/presentation/manager/login_cubit/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_features/core/utils/globals.dart' as globals;

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

  // firebase login user
  Future<void> loginUser({required String email, required String password}) async {
    emit(StartLoadingLoginState());
    try {
      UserCredential _ = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(StopLoadingLoginState());
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailureState(errorMessage: AppLocalizations.of(globals.navigatorKey.currentContext!)!.userNotFound));
        emit(StopLoadingLoginState());
      } else if (e.code == 'wrong-password') {
        emit(LoginFailureState(errorMessage: AppLocalizations.of(globals.navigatorKey.currentContext!)!.wrongPassword));
        emit(StopLoadingLoginState());
      }else if(e.code == 'invalid-credential'){
        emit(LoginFailureState(errorMessage: AppLocalizations.of(globals.navigatorKey.currentContext!)!.invalidEmailOrPassword));
        emit(StopLoadingLoginState());
      }
    }
    on Exception {
      emit(LoginFailureState(errorMessage: AppLocalizations.of(globals.navigatorKey.currentContext!)!.errorMsg));
      emit(StopLoadingLoginState());
    }
  }
}