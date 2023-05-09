import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../viewModel/login_cubit/login_cubit.dart';

class EmailLoginInputWidget extends StatelessWidget {
  const EmailLoginInputWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
  builder: (context, state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: TextField(
        onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
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