import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewModel/appBloc/app_bloc.dart';
import '../viewModel/signUp_cubit/sign_up_cubit.dart';


class AuthenticateEmailScreen extends StatelessWidget {
  const AuthenticateEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(actions: [
        TextButton(onPressed: (){
          context.read<AppBloc>().add(const AppLogoutRequested());
        }, child: Row(
          children: const [
            Text("SignOut",style: TextStyle(fontSize: 18)),
            SizedBox(width: 8,),
            Icon(Icons.logout,size: 24,)
          ],
        ),)
      ]),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: Column(
              children: [
                const Text("Almost there!",style: TextStyle(fontSize: 22)),
                const Text("A verification link was send to",style: TextStyle(fontSize: 18)),
                const SizedBox(height: 16,),
                Text(FirebaseAuth.instance.currentUser!.email!,style: const TextStyle(color: Colors.blueAccent),),
                const SizedBox(height: 24,),
                const Text("Enter the link to verify your email",style: TextStyle(fontSize: 16)),
                const SizedBox(height: 12,),
                const Text("Have You Pressed the Link?",style: TextStyle(fontSize: 16)),
                TextButton(onPressed: (){
                  context.read<AppBloc>().add(const AppLogoutRequested());
                }, child: const Text("Login")),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextButton(onPressed: ()async{
                    await context.read<SignUpCubit>().sendVerificationCode();
                  }, child: const Text("Resend email verification")),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
