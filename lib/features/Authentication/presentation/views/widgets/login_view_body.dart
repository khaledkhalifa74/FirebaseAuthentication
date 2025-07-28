import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_features/core/utils/assets.dart';
import 'package:firebase_features/core/utils/colors.dart';
import 'package:firebase_features/core/utils/functions/success_failure_alert.dart';
import 'package:firebase_features/core/utils/styles.dart';
import 'package:firebase_features/core/widgets/custom_button.dart';
import 'package:firebase_features/core/widgets/custom_loading_indicator.dart';
import 'package:firebase_features/core/widgets/custom_text_form_field_with_title.dart';
import 'package:firebase_features/core/widgets/language_drop_down.dart';
import 'package:firebase_features/features/Authentication/presentation/manager/login_cubit/login_cubit.dart';
import 'package:firebase_features/features/Authentication/presentation/manager/login_cubit/login_states.dart';
import 'package:firebase_features/features/Authentication/presentation/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:firebase_features/core/utils/globals.dart' as globals;
import 'dart:io' show Platform;

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if(state is StartLoadingLoginState){
          isLoading = true;
        }else if (state is StopLoadingLoginState){
          isLoading = false;
        }

        if(state is LoginSuccessState){
          successFailureAlert(
            context,
            isError: false,
            message: AppLocalizations.of(context)!.loginDoneSuccessfully,
          );
        }else if(state is LoginFailureState){
          successFailureAlert(
            context,
            isError: true,
            message: state.errorMessage!,
          );
        }
      },
      builder: (context, state) {
        final loginCubit = LoginCubit.get(context);
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 32,
            ),
            child: Form(
              key: _loginFormKey,
              child: Column(
                children: [
                  Align(
                    alignment: AlignmentDirectional.topStart,
                      child: const LanguageDropDown()),
                  Center(
                    child: SvgPicture.asset(
                      AssetsData.loginImage,
                      width: 220.w,
                      height: 220.h,
                    ),
                  ),
                  CustomTextFormFieldWithTitle(
                      title: AppLocalizations.of(context)!.emailAddress,
                      controller: emailController,
                    placeholder: AppLocalizations.of(context)!.enterEmail,
                    inputType: TextInputType.emailAddress,
                    prefix: Icon(
                        Iconsax.sms,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextFormFieldWithTitle(
                    title: AppLocalizations.of(context)!.password,
                    controller: passwordController,
                    placeholder: AppLocalizations.of(context)!.enterPassword,
                    prefix: Icon(
                      Iconsax.lock,
                    ),
                    obscureText: loginCubit.isLoginPasswordShown,
                    suffix: GestureDetector(
                      onTap: () {
                        loginCubit.changeLoginPasswordVisibility();
                      },
                      child: Icon(
                        loginCubit.loginPasswordVisible,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  isLoading == true
                      ? const Center(
                    child: CustomLoadingIndicator(),
                  )
                      : Column(
                    children: [
                      CustomButton(
                          text: AppLocalizations.of(context)!.login,
                          borderColor: Colors.transparent,
                          itemCallBack: (){
                            if (_loginFormKey.currentState!.validate()){
                              // login here
                              if(loginCubit.isNeedUpdate == true){
                                successFailureAlert(
                                  context,
                                  isError: true,
                                  message: AppLocalizations.of(context)!.appNeedsUpdate,
                                );
                              }else{
                                loginCubit.loginUser(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                              }
                            }
                          },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomButton(
                        text: AppLocalizations.of(context)!.signUpForNewAcc,
                        textColor: kButtonColor,
                        backgroundColor: kWhiteColor,
                        borderColor: kBorderColor,
                        itemCallBack: (){
                          FirebaseCrashlytics.instance.crash();
                          //globals.navigatorKey.currentState!.pushNamed(RegisterView.id);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.or,
                          style: Styles.textStyle16,
                        ),
                      ),
                      CustomButton(
                        text: AppLocalizations.of(context)!.signInWithGmail,
                        textColor: kButtonColor,
                        backgroundColor: kWhiteColor,
                        borderColor: kBorderColor,
                        itemCallBack: (){
                          loginCubit.signInWithGoogle();
                        },
                        previousIcon: SvgPicture.asset(
                          AssetsData.googleIcon,
                          height: 25,
                          width: 25,
                        ),
                      ),
                      Platform.isIOS
                          ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: CustomButton(
                              text: AppLocalizations.of(context)!.signInWithApple,
                              textColor: kButtonColor,
                              backgroundColor: kWhiteColor,
                              borderColor: kBorderColor,
                              itemCallBack: (){
                                loginCubit.signInWithApple();
                              },
                              previousIcon: SvgPicture.asset(
                                AssetsData.appleIcon,
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ),
                        ],
                      )
                          : const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
