import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:rent_car/Features/authentication/presentation/pages/widgets/login/EmailLoginInputWidget.dart';
import 'package:rent_car/Features/authentication/presentation/pages/widgets/login/ForgetYourPasswordWidget.dart';
import 'package:rent_car/Features/authentication/presentation/pages/widgets/login/LoginButtonWidget.dart';
import 'package:rent_car/Features/authentication/presentation/pages/widgets/login/LoginIconsWidgets.dart';
import 'package:rent_car/Features/authentication/presentation/pages/widgets/login/SignUpButtonWidget.dart';
import 'package:rent_car/Features/authentication/presentation/pages/widgets/login/passwordLoginInputWidget.dart';
import 'package:rent_car/main.dart';
import '../../../../application/core/assets.dart';
import '../../../../models/repository/repository_auth.dart';
import '../../../../models/repository/repository_fireStore.dart';
import '../viewModel/login_cubit/login_cubit.dart';

class LoginProvider extends StatelessWidget {
  const LoginProvider({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginProvider());
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(create: (context)=>LoginCubit(getIt<AuthenticationRepositoryImplementation>(),
    getIt<FireStoreRepositoryImplementation>()
    ),
      child: const Scaffold(
          body: LoginScreen()),);
  }
}


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
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
              const EmailLoginInputWidget(),
              const PasswordLoginInputWidget(),
              const SizedBox(height: 8),
              const LoginButtonWidget(),
              const ForgetYourPasswordWidget(),
              const SizedBox(height: 4),
              const SignUpButtonWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuthenticationBottomIcons(image: Assets.loginFacebookIcon,onTab: (){}),
                  const SizedBox(width: 18,),
                  AuthenticationBottomIcons(image: Assets.loginGoogleIcon,onTab: (){
                    context.read<LoginCubit>().logInWithGoogle();
                  }, )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


