import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_car/Features/authentication/presentation/viewModel/signUp_cubit/sign_up_cubit.dart';

class EmailRegisterInputWidget extends StatelessWidget {
  const EmailRegisterInputWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: TextField(
            onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),borderSide: const BorderSide(color: Colors.black)
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),borderSide: const BorderSide(color: Colors.black)
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),borderSide: const BorderSide(color: Colors.black)
              ),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),borderSide: const BorderSide(color: Colors.red)
              ),
              labelText: 'email',
              helperText: '',
              errorText: (state.email.value.isNotEmpty && !state.email.isValid) ? 'invalid email' : null,
            ),
          ),
        );
      },
    );
  }
}