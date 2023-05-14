
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:rent_car/Features/authentication/presentation/viewModel/reset_cubit/reset_cubit.dart';

import '../../../viewModel/login_cubit/login_cubit.dart';

class EmailInputButtonWidget extends StatelessWidget {
  const EmailInputButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetCubit, ResetState>(
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
              ? () => context.read<ResetCubit>().sendResetCode()
              : null,
          child: const Text('SEND CODE',style: TextStyle(color: Colors.white)),
        );
      },
    );
  }
}