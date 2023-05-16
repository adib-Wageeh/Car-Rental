import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:rent_car/Features/authentication/presentation/pages/widgets/reset_password/EmailInputButtonWidget.dart';
import 'package:rent_car/Features/authentication/presentation/pages/widgets/reset_password/EmailResetInputWidget.dart';
import '../../../../main.dart';
import '../../../../models/repository/repository_auth.dart';
import '../viewModel/reset_cubit/reset_cubit.dart';

class ResetPasswordProvider extends StatelessWidget {
  const ResetPasswordProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResetCubit>(create: (context) =>
        ResetCubit(authenticationRepository: getIt<
            AuthenticationRepositoryImplementation>(),),
      child: const ResetPasswordScreen(),
    );
  }
}


class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<ResetCubit, ResetState>(
        listener: (context, state) {
          if (state.formState.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                ),
              );
          }
          if(state.formState.isSuccess){
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text("Reset password has been sent to your email successfully"),
                ),
              );
            Navigator.pop(context);
          }
        },
        child: Align(
          alignment: const Alignment(0, -1 / 3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              EmailResetInputWidget(),
              EmailInputButtonWidget()
            ],
          ),
        ),
      ),
    );
  }
}

