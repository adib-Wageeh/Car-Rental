import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:rent_car/Features/authentication/models/repository/repository_impl.dart';
import 'package:rent_car/Features/authentication/presentation/pages/widgets/register/EmailRegisterInputWidget.dart';
import 'package:rent_car/Features/authentication/presentation/pages/widgets/register/PasswordRegisterInputWidget.dart';
import 'package:rent_car/Features/authentication/presentation/pages/widgets/register/RePasswordInputWidget.dart';
import 'package:rent_car/Features/authentication/presentation/pages/widgets/register/RegisterButtonWidget.dart';
import 'package:rent_car/Features/authentication/presentation/pages/widgets/register/SignInButtonWidget.dart';
import 'package:rent_car/main.dart';
import '../../../../application/core/assets.dart';
import '../viewModel/signUp_cubit/sign_up_cubit.dart';


class SignUpProvider extends StatelessWidget {
  const SignUpProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(create: (context)=>SignUpCubit(authenticationRepository: getIt<AuthenticationRepositoryImplementation>()),
      child: const Scaffold(
          body: SignUpScreen()),);
  }
}


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
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
            children: [
              Image.asset(
                Assets.onBoardingAppLogo,
                height: 120,
              ),
              const SizedBox(height: 32),
              const EmailRegisterInputWidget(),
              const PasswordRegisterInputWidget(),
              const SizedBox(height: 8),
              const RePasswordRegisterInputWidget(),
              const SizedBox(height: 8),
              const RegisterButtonWidget(),
              const SizedBox(height: 4),
              const SignInButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}