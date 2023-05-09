
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../viewModel/login_cubit/login_cubit.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => (previous.status != current.status || previous.formState != current.formState),
      builder: (context, state) {
        return state.formState == FormzSubmissionStatus.inProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: Colors.blueAccent,
          ),
          onPressed: state.status
              ? () => context.read<LoginCubit>().logInWithCredentials()
              : null,
          child: const Text('LOGIN',style: TextStyle(color: Colors.white)),
        );
      },
    );
  }
}