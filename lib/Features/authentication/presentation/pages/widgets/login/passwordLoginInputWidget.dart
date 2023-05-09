import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rent_car/Features/authentication/presentation/viewModel/login_cubit/login_cubit.dart';


class PasswordLoginInputWidget extends StatelessWidget {
  const PasswordLoginInputWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
  builder: (context, state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: TextField(
        onChanged: (password) =>
            context.read<LoginCubit>().passwordChanged(password),
        obscureText: (state.isObscure)?true:false,
        decoration: InputDecoration(
          labelText: 'password',
          suffixIcon: InkWell(
              onTap: (){
                context.read<LoginCubit>().obscureChange();
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