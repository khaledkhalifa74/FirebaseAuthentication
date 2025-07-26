import 'package:firebase_features/core/utils/assets.dart';
import 'package:firebase_features/core/utils/colors.dart';
import 'package:firebase_features/core/utils/styles.dart';
import 'package:firebase_features/core/widgets/custom_button.dart';
import 'package:firebase_features/core/widgets/custom_text_form_field_with_title.dart';
import 'package:firebase_features/core/widgets/language_drop_down.dart';
import 'package:firebase_features/features/Authentication/presentation/manager/login_cubit/login_cubit.dart';
import 'package:firebase_features/features/Authentication/presentation/manager/login_cubit/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

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
  Widget build(BuildContext context) {
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
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
                    // validator: (data) {
                    //   if (data!.isEmpty) {
                    //     return AppLocalizations.of(context)!.cantBeEmpty;
                    //   } else {
                    //     if (!emailRegex.hasMatch(data)) {
                    //       return AppLocalizations.of(context)!.enterValidEmail;
                    //     }
                    //   }
                    //   return null;
                    // },
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
                  CustomButton(
                      text: AppLocalizations.of(context)!.login,
                      borderColor: Colors.transparent,
                      itemCallBack: (){},
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomButton(
                    text: AppLocalizations.of(context)!.signUpForNewAcc,
                    textColor: kButtonColor,
                    backgroundColor: kWhiteColor,
                    borderColor: kBorderColor,
                    itemCallBack: (){},
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.or,
                      style: Styles.textStyle16,
                    ),
                  ),
                  CustomButton(
                      text: AppLocalizations.of(context)!.loginWithGmail,
                      textColor: kButtonColor,
                      backgroundColor: kWhiteColor,
                      borderColor: kBorderColor,
                      itemCallBack: (){},
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
