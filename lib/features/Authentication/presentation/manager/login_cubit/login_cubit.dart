import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_features/features/Authentication/presentation/manager/login_cubit/login_states.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_features/core/utils/globals.dart' as globals;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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

  // firebase login with google
  Future<void> signInWithGoogle() async {
    emit(StartLoadingLoginState());

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        emit(LoginFailureState(
          errorMessage: AppLocalizations.of(globals.navigatorKey.currentContext!)!
              .signInCancelled,
        ));
        emit(StopLoadingLoginState());
        return;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      emit(StopLoadingLoginState());
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      String message = AppLocalizations.of(globals.navigatorKey.currentContext!)!.errorMsg;

      if (e.code == 'account-exists-with-different-credential') {
        message = AppLocalizations.of(globals.navigatorKey.currentContext!)!
            .accountExistsWithDifferentCredential;
      } else if (e.code == 'invalid-credential') {
        message = AppLocalizations.of(globals.navigatorKey.currentContext!)!
            .invalidEmailOrPassword;
      } else if (e.code == 'user-disabled') {
        message = AppLocalizations.of(globals.navigatorKey.currentContext!)!
            .userDisabled;
      }
      emit(LoginFailureState(errorMessage: message));
      emit(StopLoadingLoginState());
    } catch (e) {
      emit(LoginFailureState(
        errorMessage: AppLocalizations.of(globals.navigatorKey.currentContext!)!
            .errorMsg,
      ));
      emit(StopLoadingLoginState());
    }
  }

  // firebase login with apple
  Future<void> signInWithApple() async {
    emit(StartLoadingLoginState());

    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      emit(StopLoadingLoginState());
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      String message = AppLocalizations.of(globals.navigatorKey.currentContext!)!.errorMsg;

      if (e.code == 'account-exists-with-different-credential') {
        message = AppLocalizations.of(globals.navigatorKey.currentContext!)!
            .accountExistsWithDifferentCredential;
      } else if (e.code == 'invalid-credential') {
        message = AppLocalizations.of(globals.navigatorKey.currentContext!)!
            .invalidEmailOrPassword;
      } else if (e.code == 'user-disabled') {
        message = AppLocalizations.of(globals.navigatorKey.currentContext!)!
            .userDisabled;
      }

      emit(LoginFailureState(errorMessage: message));
      emit(StopLoadingLoginState());
    } catch (e) {
      emit(LoginFailureState(
        errorMessage: AppLocalizations.of(globals.navigatorKey.currentContext!)!
            .errorMsg,
      ));
      emit(StopLoadingLoginState());
    }
  }

  // check isNeedUpdate
  bool? isNeedUpdate;
  Future<void> checkIsNeedUpdate() async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 0),
      ),
    );
    try {
      await remoteConfig.fetchAndActivate();

      isNeedUpdate = remoteConfig.getBool('isNeedUpdate');
      if (kDebugMode) {
        print('the bool is $isNeedUpdate');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to fetch remote config: $e');
      }
      isNeedUpdate = null;
    }
  }

}