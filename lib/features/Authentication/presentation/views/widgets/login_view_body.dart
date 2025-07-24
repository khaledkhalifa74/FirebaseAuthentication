import 'package:firebase_features/features/Authentication/presentation/manager/login_cubit/login_cubit.dart';
import 'package:firebase_features/features/Authentication/presentation/manager/login_cubit/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [

          ],
        );
      },
    );
  }
}
