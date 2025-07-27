import 'package:firebase_features/features/Authentication/presentation/manager/register_cubit/register_cubit.dart';
import 'package:firebase_features/features/Authentication/presentation/views/widgets/register_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});
  static String id = "RegisterView";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: const Scaffold(
        body: RegisterViewBody(),
      ),
    );
  }
}
