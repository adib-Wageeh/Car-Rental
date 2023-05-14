import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:rent_car/Features/authentication/presentation/pages/widgets/register/EmailRegisterInputWidget.dart';
import 'package:rent_car/Features/authentication/presentation/pages/widgets/register/NameRegisterInputWidget.dart';
import 'package:rent_car/Features/authentication/presentation/pages/widgets/register/PasswordRegisterInputWidget.dart';
import 'package:rent_car/Features/authentication/presentation/pages/widgets/register/ProfilePictureWidget.dart';
import 'package:rent_car/Features/authentication/presentation/pages/widgets/register/RePasswordInputWidget.dart';
import 'package:rent_car/Features/authentication/presentation/pages/widgets/register/RegisterButtonWidget.dart';
import 'package:rent_car/Features/authentication/presentation/pages/widgets/register/SignInButtonWidget.dart';

import '../viewModel/signUp_cubit/sign_up_cubit.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state.formState.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Authentication Failure'),
                ),
              );
          }
        },
        child: Align(
          alignment: const Alignment(0, -1 / 5),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                ProfilePictureWidget(),
                SizedBox(height: 32),
                NameRegisterInputWidget(),
                EmailRegisterInputWidget(),
                PasswordRegisterInputWidget(),
                RePasswordRegisterInputWidget(),
                SizedBox(height: 8),
                RegisterButtonWidget(),
                SizedBox(height: 4),
                SignInButtonWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}