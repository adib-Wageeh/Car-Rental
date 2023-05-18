import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rent_car/Features/authentication/presentation/viewModel/signUp_cubit/sign_up_cubit.dart';
import 'package:rent_car/Features/home/presentation/viewModel/addCar/add_car_cubit.dart';
import 'package:rent_car/Features/home/presentation/viewModel/app_bar/app_bar_cubit.dart';
import 'package:rent_car/Features/home/presentation/viewModel/cars_bloc/get_cars_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../Features/authentication/presentation/pages/splash_screen.dart';
import '../../Features/authentication/presentation/viewModel/appBloc/app_bloc.dart';
import '../../Features/home/presentation/viewModel/car_description/car_description_cubit.dart';
import '../../Features/home/presentation/viewModel/getUserData/get_user_data_cubit.dart';
import '../../main.dart';
import '../../models/repository/image_picker.dart';
import '../../models/repository/repository_auth.dart';
import '../../models/repository/repository_fireStore.dart';
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
          BlocProvider<AppBarCubit>(create: (context)=>AppBarCubit()),
          BlocProvider<AddCarCubit>(create: (context)=>AddCarCubit(
    repositoryImagePicker: getIt<RepositoryImagePicker>()
    ,fireStoreRepositoryImplementation: getIt<FireStoreRepositoryImplementation>())),
          BlocProvider<GetUserDataCubit>(create: (_) => GetUserDataCubit(
              authenticationRepositoryImplementation: getIt<AuthenticationRepositoryImplementation>(),
          )..setState(),),
          BlocProvider<CarDescriptionCubit>(create: (_) => CarDescriptionCubit(
            fireStoreRepositoryImplementation: getIt<FireStoreRepositoryImplementation>()),
          ),
          BlocProvider<GetCarsBloc>(create: (_) => GetCarsBloc()..add(GetFirstCarsEvent()),
          ),
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
  child: Sizer(
    builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {

      return MaterialApp(
        navigatorKey: _navigatorKey,
        builder: EasyLoading.init(),
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
      );
    },
  ),
);
  }
}
