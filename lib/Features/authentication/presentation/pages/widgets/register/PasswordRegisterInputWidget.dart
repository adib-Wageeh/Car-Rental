import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rent_car/Features/authentication/presentation/viewModel/signUp_cubit/sign_up_cubit.dart';


class PasswordRegisterInputWidget extends StatelessWidget {
  const PasswordRegisterInputWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
  builder: (context, state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: TextField(
        onChanged: (password) =>
            context.read<SignUpCubit>().passwordChanged(password),
        obscureText: (state.isObscure)?true:false,
        decoration: InputDecoration(
          labelText: 'password',
          suffixIcon: InkWell(
              onTap: (){
                context.read<SignUpCubit>().obscureChange();
              },
              borderRadius: BorderRadius.circular(36),
              child: Icon( (state.isObscure)? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye)),
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
          helperText: '',
          errorText: (state.password.value.isNotEmpty && state.password.isNotValid) ? 'invalid password' : null,
        ),
      ),
    );
  },
);
  }
}