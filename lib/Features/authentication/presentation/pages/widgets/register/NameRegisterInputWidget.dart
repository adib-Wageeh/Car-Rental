import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../viewModel/signUp_cubit/sign_up_cubit.dart';

class NameRegisterInputWidget extends StatelessWidget {
  const NameRegisterInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: TextField(
            onChanged: (name) => context.read<SignUpCubit>().nameChanged(name),
            keyboardType: TextInputType.text,
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
              labelText: 'name',
              helperText: '',
              errorText: (state.name.value.isNotEmpty && !state.name.isValid) ? 'invalid name' : null,
            ),
          ),
        );
      },
    );  }
}