import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_car/Features/authentication/models/repository/repository_auth.dart';
import 'package:rent_car/Features/authentication/models/repository/repository_fireStore.dart';
import 'package:rent_car/Features/authentication/presentation/viewModel/signUp_cubit/sign_up_cubit.dart';
import '../../Features/authentication/models/repository/image_picker.dart';
import '../../Features/authentication/presentation/pages/splash_screen.dart';
import '../../Features/authentication/presentation/viewModel/appBloc/app_bloc.dart';
import '../../main.dart';
import '../core/routes.dart';

class BasicApp extends StatelessWidget {
  const BasicApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
  providers: [
    RepositoryProvider.value(
      value: (context) => getIt<AuthenticationRepositoryImplementation>(),
),
    RepositoryProvider.value(
      value: (context) => getIt<FireStoreRepositoryImplementation>(),
    ),
  ],
  child: MultiBlocProvider(
        providers: [
          BlocProvider<AppBloc>(create: (_) => AppBloc(
        authenticationRepository: getIt<AuthenticationRepositoryImplementation>(),
    ),),
          BlocProvider<SignUpCubit>(create: (_) => SignUpCubit(
            authenticationRepository: getIt<AuthenticationRepositoryImplementation>(),
              imagePickerRepo: getIt<RepositoryImagePicker>()
          ),),
        ],
        child: const BlocListen()
      ),
);
  }
}

final _navigatorKey = GlobalKey<NavigatorState>();
class BlocListen extends StatelessWidget {
  const BlocListen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc,AppState>(
  listener: (context, state) {
    if(context.read<AppBloc>().state.status == AppStatus.firstUnauthenticated){
      _navigatorKey.currentState
          ?.pushNamedAndRemoveUntil(Routes.onBoarding, (r) => false);
    }else if(context.read<AppBloc>().state.status == AppStatus.unauthenticated){
      _navigatorKey.currentState
          ?.pushNamedAndRemoveUntil(Routes.login, (r) => false);
    }else if(context.read<AppBloc>().state.status == AppStatus.authenticated){
      _navigatorKey.currentState
          ?.pushNamedAndRemoveUntil(Routes.home, (r) => false);
    }else if(context.read<AppBloc>().state.status == AppStatus.authenticatedUnVerifiedEmail){
      _navigatorKey.currentState
          ?.pushNamedAndRemoveUntil(Routes.unVerified, (r) => false);
    }
  },
  child: MaterialApp(
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blueAccent,
            brightness: Brightness.light,
            onSecondary: Colors.white
        ),
      ),
      home: const SplashScreen(),
      onGenerateRoute: Routes.routes,
    ),
);
  }
}
