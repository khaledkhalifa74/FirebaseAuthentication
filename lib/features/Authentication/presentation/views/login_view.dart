import 'package:firebase_features/features/Authentication/presentation/manager/login_cubit/login_cubit.dart';
import 'package:firebase_features/features/Authentication/presentation/views/widgets/login_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static String id = "LoginView";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit()..checkIsNeedUpdate(),
      child: const Scaffold(
        body: LoginViewBody(),
      ),
    );
  }
}
