import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../application/core/assets.dart';
import '../../../viewModel/searchCars/search_cars_bloc.dart';

TextEditingController _controller = TextEditingController();
class SearchBarPageWidget extends StatelessWidget {
  const SearchBarPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _controller.clear();
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8),
      child: Container(
          width: double.infinity,
          height: 7.h,
          decoration: BoxDecoration(
              color: Assets.searchBarColor,
              borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            children: [
              SizedBox(width: 1.5.w,),
              Expanded(
                child: TextField(
                  controller: _controller,
                  onChanged: (text){
                    context.read<SearchCarsBloc>().add(EditSearchCarsEvent(text: text));
                  },
                  autofocus: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass,color: Colors.black,size: 16.sp),
                      hintText: " Search",
                      hintStyle: TextStyle(fontSize: 16.sp,color: Colors.black54)
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}