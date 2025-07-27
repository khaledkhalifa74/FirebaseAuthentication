import 'package:firebase_features/core/utils/assets.dart';
import 'package:firebase_features/core/widgets/custom_button.dart';
import 'package:firebase_features/core/widgets/custom_text_form_field_with_title.dart';
import 'package:firebase_features/features/Authentication/presentation/manager/register_cubit/register_cubit.dart';
import 'package:firebase_features/features/Authentication/presentation/manager/register_cubit/register_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:firebase_features/core/utils/globals.dart' as globals;

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _registerFormKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final registerCubit = RegisterCubit.get(context);
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 32,
            ),
            child: Form(
              key: _registerFormKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Align(
                      alignment: AlignmentDirectional.topStart,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: (){
                          globals.navigatorKey.currentState!.pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded
                          ),
                        ),
                      ),
                  ),
                  Center(
                    child: SvgPicture.asset(
                      AssetsData.registerImage,
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
                    validator: (data) {
                      if (data!.isEmpty) {
                        return AppLocalizations.of(context)!.cantBeEmpty;
                      } else {
                        if (!emailRegex.hasMatch(data)) {
                          return AppLocalizations.of(context)!.enterValidEmail;
                        }
                      }
                      return null;
                    },
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
                    obscureText: registerCubit.isRegisterPasswordShown,
                    suffix: GestureDetector(
                      onTap: () {
                        registerCubit.changeRegisterPasswordVisibility();
                      },
                      child: Icon(
                        registerCubit.registerPasswordVisible,
                      ),
                    ),
                    validator: (data) {
                      if (data!.isEmpty) {
                        return AppLocalizations.of(context)!
                            .cantBeEmpty;
                      } else if (data !=
                          confirmPasswordController.text) {
                        return AppLocalizations.of(context)!
                            .passwordDoesntMatch;
                      } else if (data.length < 8) {
                        return AppLocalizations.of(context)!
                            .passwordLength;
                      } else if (!RegExp(r'^(?=.*[A-Z])')
                          .hasMatch(data)) {
                        return AppLocalizations.of(context)!
                            .passwordUppercase;
                      } else if (!RegExp(r'^(?=.*[a-z])')
                          .hasMatch(data)) {
                        return AppLocalizations.of(context)!
                            .passwordLowercase;
                      } else if (!RegExp(r'^(?=.*\d)').hasMatch(data)) {
                        return AppLocalizations.of(context)!
                            .passwordNumber;
                      } else if (!RegExp(r'^(?=.*[@#$%&*])')
                          .hasMatch(data)) {
                        return AppLocalizations.of(context)!
                            .passwordCharacter;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextFormFieldWithTitle(
                    title: AppLocalizations.of(context)!.confirmPassword,
                    controller: confirmPasswordController,
                    placeholder: AppLocalizations.of(context)!.enterConfirmPassword,
                    prefix: Icon(
                      Iconsax.lock,
                    ),
                    obscureText: registerCubit.isRegisterConfirmPasswordShown,
                    suffix: GestureDetector(
                      onTap: () {
                        registerCubit.changeRegisterConfirmPasswordVisibility();
                      },
                      child: Icon(
                        registerCubit.registerConfirmPasswordVisible,
                      ),
                    ),
                    validator: (data) {
                      if (data!.isEmpty) {
                        return AppLocalizations.of(context)!
                            .cantBeEmpty;
                      } else if (data != passwordController.text) {
                        return AppLocalizations.of(context)!
                            .passwordDoesntMatch;
                      } else if (data.length < 8) {
                        return AppLocalizations.of(context)!
                            .passwordLength;
                      } else if (!RegExp(r'^(?=.*[A-Z])')
                          .hasMatch(data)) {
                        return AppLocalizations.of(context)!
                            .passwordUppercase;
                      } else if (!RegExp(r'^(?=.*[a-z])')
                          .hasMatch(data)) {
                        return AppLocalizations.of(context)!
                            .passwordLowercase;
                      } else if (!RegExp(r'^(?=.*\d)').hasMatch(data)) {
                        return AppLocalizations.of(context)!
                            .passwordNumber;
                      } else if (!RegExp(r'^(?=.*[@#$%&*])')
                          .hasMatch(data)) {
                        return AppLocalizations.of(context)!
                            .passwordCharacter;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  CustomButton(
                    text: AppLocalizations.of(context)!.signUp,
                    borderColor: Colors.transparent,
                    itemCallBack: (){
                      if (_registerFormKey.currentState!.validate()){
                        // register here
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
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
