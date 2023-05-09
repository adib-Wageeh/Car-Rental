import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rent_car/Features/authentication/presentation/viewModel/logOut_cubit/log_out_cubit.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            context.read<LogOutCubit>().logOut();
          }, icon: const Icon(FontAwesomeIcons.signOut))
        ],
      ),
      body: const Center(
        child: Text("Welcome"),
      ),
    );
  }
}
