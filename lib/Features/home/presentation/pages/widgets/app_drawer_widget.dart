import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_car/Features/home/presentation/viewModel/getUserData/get_user_data_cubit.dart';
import 'package:rent_car/application/core/assets.dart';

class Menu {
  final IconData iconData;
  final String title;

  Menu(this.iconData, this.title);
}

class SliderView extends StatelessWidget {
  final Function(String)? onItemClick;

  const SliderView({Key? key, this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserDataCubit, GetUserDataState>(
  builder: (context, state) {
    return Container(
      color: Colors.white,
      width: 220,
      padding: const EdgeInsets.only(top: 30),
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          CachedNetworkImage(
            width: 170,
            height: 170,
            placeholder: (context, url) => const CircularProgressIndicator(),
            imageUrl: state.imagePath,
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
            state.name,
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
  },
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
        style: ListTileStyle.list,
        title: Text(title,
            style: TextStyle(
                color: Assets.appPrimaryWhiteColor, fontFamily: 'BalsamiqSans_Regular')),
        leading: Icon(iconData, color: Assets.appPrimaryWhiteColor),
        onTap: () => onTap?.call(title));
  }
}