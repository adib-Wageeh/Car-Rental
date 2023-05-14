import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../viewModel/signUp_cubit/sign_up_cubit.dart';

class RegisterButtonWidget extends StatelessWidget {
  const RegisterButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => (
          previous.status != current.status || previous.formState != current.formState),
      builder: (context, state) {
        return state.formState.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: Colors.blueAccent,
          ),
          onPressed: state.status
              ? () {
            context.read<SignUpCubit>().signUpWithCredentials();
          }
              : null,
          child: const Text('SIGN UP',style: TextStyle(color: Colors.white)),
        );
      },
    );
  }
}