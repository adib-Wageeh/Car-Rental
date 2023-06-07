import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_car/Features/authentication/presentation/viewModel/appBloc/app_bloc.dart';
import 'package:rent_car/Features/home/presentation/pages/AppBarHomeView.dart';
import 'package:rent_car/Features/home/presentation/pages/widgets/Bottom_nav_bar_widget.dart';
import 'package:rent_car/Features/home/presentation/pages/widgets/app_drawer_widget.dart';
import 'package:rent_car/Features/home/presentation/viewModel/cars_bloc/get_cars_bloc.dart';
import 'package:rent_car/Features/home/presentation/viewModel/offers_bloc/offers_cubit.dart';
import '../../../../application/core/assets.dart';
import '../../../../application/core/routes.dart';
import '../viewModel/app_bar/app_bar_cubit.dart';
import 'AppBarChatView.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Assets.appPrimaryWhiteColor
          ,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
          ],
          title: const Text("Rent Me",style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        drawer: SliderView(onItemClick: (item) {
          switch (item) {
            case "LogOut":
              context.read<AppBloc>().add(const AppLogoutRequested());
              break;
            case "Edit Profile":
              Navigator.push(context,
                  Routes.routes(const RouteSettings(name: Routes.editAccount)));
              break;
          }
        }),
        body: const HomeBody(),
      ),
    );
  }
}


class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppBarCubit, AppBarState>(
        builder: (context, state) {
          if (state is AppBarInitial) {
            context.read<GetCarsBloc>().add(GetFirstCarsEvent());
            return const AppBarHomeView();
          } else if (state is AppBarOffers) {
            return const AppBarOffersView();
          } else if (state is AppBarNotifications) {
            return const AppBarNotificationsView();
          }
          context.read<OffersCubit>().getOffers();
          return const AppBarChatViewScreen();
        },
      ),
      bottomNavigationBar: BottomNavigationBarWidget(context)
    );
  }
}


class AppBarOffersView extends StatelessWidget {
  const AppBarOffersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class AppBarNotificationsView extends StatelessWidget {
  const AppBarNotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
//
// class AppBarChatsView extends StatelessWidget {
//   const AppBarChatsView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const AppBarChatViewScreen();
//   }
// }
