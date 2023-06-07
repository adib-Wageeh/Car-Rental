import 'package:flutter/material.dart';
import 'package:rent_car/Features/home/presentation/pages/widgets/SearchPage/SearchBarPageWidget.dart';
import 'package:rent_car/Features/home/presentation/pages/widgets/SearchPage/SearchResultListView.dart';


class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: const [
          SearchBarPageWidget(),
          SearchResultListView(),
        ],
      ),
    );
  }
}


