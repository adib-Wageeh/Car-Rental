import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_car/Features/authentication/presentation/viewModel/appBloc/app_bloc.dart';
import 'package:rent_car/Features/home/presentation/pages/widgets/AppBarHomeView.dart';
import 'package:rent_car/Features/home/presentation/pages/widgets/app_drawer_widget.dart';
import '../../../../application/core/assets.dart';
import '../../../../application/core/routes.dart';
import '../viewModel/app_bar/app_bar_cubit.dart';
import '../viewModel/cars_bloc/cars_bloc.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Assets.appPrimaryWhiteColor,
          foregroundColor: Colors.white
          ,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
          ],
          title: const Text("Rent Me"),
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
          if (state is AppBarHome || state is AppBarInitial) {
            BlocProvider.of<CarsBloc>(context).add(GetData());
            return const AppBarHomeView();
          } else if (state is AppBarOffers) {
            // BlocProvider.of<GetReportCubit>(context).switchTransactionState(true);
            return const AppBarOffersView();
          } else if (state is AppBarNotifications) {
            return const AppBarNotificationsView();
          }
          // BlocProvider.of<GetTransactionsPerDayCubit>(context).getTransactionsPerDay(BlocProvider.of<GetTransactionsPerDayCubit>(context).selectedDay);
          return const AppBarChatsView();
        },
      ),
      bottomNavigationBar: BlocBuilder<AppBarCubit, AppBarState>(
        builder: (context, state) {
          return DotNavigationBar(
            margin: const EdgeInsets.only(left: 16, right: 16),
            currentIndex: context
                .read<AppBarCubit>()
                .currIndex,
            dotIndicatorColor: Colors.transparent,
            unselectedItemColor: Colors.grey[300],
            enableFloatingNavBar: false,
            enablePaddingAnimation: false,
            selectedItemColor: Assets.appPrimaryWhiteColor,
            onTap: (int i) {
              if(i == BlocProvider.of<AppBarCubit>(context).currIndex)return;
              final cubit = BlocProvider.of<AppBarCubit>(context);
              switch (i) {
                case 0:
                  cubit.setHomeView();
                  break;
                case 1:
                  cubit.setNotificationsView();
                  break;
                case 2:
                  cubit.setChatsView();
                  break;
                case 3:
                  cubit.setOffersView();
                  break;
              }
            },
            items: [
              DotNavigationBarItem(
                icon: const Icon(Icons.home, size: 32),
              ),
              DotNavigationBarItem(
                icon: const Icon(Icons.notifications_active, size: 32),
              ),
              DotNavigationBarItem(
                icon: const Icon(Icons.chat, size: 32),
              ),
              DotNavigationBarItem(
                icon: const Icon(Icons.local_offer_rounded, size: 32),
              ),
            ],
          );
        },
      ),
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

class AppBarChatsView extends StatelessWidget {
  const AppBarChatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
