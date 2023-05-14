import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:rent_car/Features/authentication/models/repository/repository_auth.dart';
import 'package:rent_car/Features/authentication/presentation/viewModel/appBloc/app_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../main.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SliderDrawer(
            appBar: SliderAppBar(
              appBarColor: Colors.white,
              title: const Text("Rent Me", style: TextStyle(fontSize: 24)),
              trailing: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.settings)),
            ),
            sliderOpenSize: 190,
            slider: _SliderView(
              onItemClick: (title) {
                switch (title) {
                  case "LogOut":
                    context.read<AppBloc>().add(const AppLogoutRequested());
                    break;
                }
              },
            ),
            child: const HomeBody()),
      ),
    );
  }
}

class Menu {
  final IconData iconData;
  final String title;

  Menu(this.iconData, this.title);
}

class _SliderView extends StatelessWidget {
  final Function(String)? onItemClick;

  const _SliderView({Key? key, this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 30),
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          CachedNetworkImage(
            width: 130,
            height: 130,
            placeholder: (context, url) => const CircularProgressIndicator(),
            imageUrl: getIt<AuthenticationRepositoryImplementation>().currentUser.photo!,
              imageBuilder: (context, imageProvider) { // you can access to imageProvider
                return CircleAvatar( // or any widget that use imageProvider like (PhotoView)
                  backgroundImage: imageProvider,
                );
              },
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            getIt<AuthenticationRepositoryImplementation>().currentUser.name!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ...[
            Menu(Icons.edit, 'Edit Profile'),
            Menu(Icons.delete, 'Delete Account'),
            Menu(Icons.arrow_back_ios, 'LogOut')
          ]
              .map((menu) =>
              _SliderMenuItem(
                  title: menu.title,
                  iconData: menu.iconData,
                  onTap: onItemClick))
              .toList(),
        ],
      ),
    );
  }
}

class _SliderMenuItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function(String)? onTap;

  const _SliderMenuItem({Key? key,
    required this.title,
    required this.iconData,
    required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title,
            style: const TextStyle(
                color: Colors.black, fontFamily: 'BalsamiqSans_Regular')),
        leading: Icon(iconData, color: Colors.black),
        onTap: () => onTap?.call(title));
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: DotNavigationBar(
        margin: const EdgeInsets.only(left: 10, right: 10),
        currentIndex: 0,
        dotIndicatorColor: Colors.white,
        unselectedItemColor: Colors.grey[300],
        enableFloatingNavBar: false,
        selectedItemColor: Colors.blueAccent,
        onTap: (index) {},
        items: [
          DotNavigationBarItem(
            icon: const Icon(Icons.home),
          ),
          DotNavigationBarItem(
            icon: const Icon(Icons.search),
          ),
          DotNavigationBarItem(
            icon: const Icon(Icons.chat),
          ),
          DotNavigationBarItem(
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: const Text(""),
    );
  }
}
