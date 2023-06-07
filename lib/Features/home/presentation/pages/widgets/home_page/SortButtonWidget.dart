import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../application/core/assets.dart';
import '../../../viewModel/cars_bloc/get_cars_bloc.dart';

class SortButtonWidget extends StatelessWidget {
  const SortButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCarsBloc, GetCarsState>(
      builder: (context, state) {
        return TextButton(onPressed: (){
          showDialog(
              context: context,
              useRootNavigator: true,
              barrierDismissible: false,
              builder: (context)
              {
                return const AlertDialogWidget();
              });
        },
          style: TextButton.styleFrom(
              backgroundColor: (context.read<GetCarsBloc>().isDown == true ||
                  context.read<GetCarsBloc>().isUp == true)? Assets.appPrimaryWhiteColor:Colors.grey
          ), child: Text("Sort",style: TextStyle(color: Colors.white,
              fontSize: 12.sp),),
        );
      },
    );
  }
}


class AlertDialogWidget extends StatefulWidget {
  const AlertDialogWidget({Key? key}) : super(key: key);

  @override
  State<AlertDialogWidget> createState() => _AlertDialogWidgetState();
}

class _AlertDialogWidgetState extends State<AlertDialogWidget> {

  @override
  Widget build(BuildContext context) {
    final state = context.read<GetCarsBloc>();
    return AlertDialog(
      title: const Text("Sort"),
      content: Row(
        children: [
          const Text("Price",style: TextStyle(fontSize: 16)),
          const Spacer(),
          IconButton(onPressed: (){
            state.isDown = !state.isDown;
            if(state.isDown)state.isUp= false;
            setState(() {
            });
          }, icon: Icon(FontAwesomeIcons.angleDown,color: (state.isDown)?Assets.appPrimaryWhiteColor:Colors.black,)),
          IconButton(onPressed: (){
            state.isUp = !state.isUp;
            if(state.isUp)state.isDown= false;
            setState(() {
            });
          }, icon: Icon(FontAwesomeIcons.angleUp,color: (state.isUp)?Assets.appPrimaryWhiteColor:Colors.black,))
        ],
      ),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text("Save"),
          onPressed: () {
            if(state.isUp == true){
              context.read<GetCarsBloc>().isUp = true;
              context.read<GetCarsBloc>().add(GetFirstCarsEvent());
              Navigator.of(context).pop();
            }else if(state.isDown){
              context.read<GetCarsBloc>().isDown = true;
              context.read<GetCarsBloc>().add(GetFirstCarsEvent());
              Navigator.of(context).pop();
            }else{
              context.read<GetCarsBloc>().isUp = false;
              context.read<GetCarsBloc>().isDown = false;
              context.read<GetCarsBloc>().add(GetFirstCarsEvent());
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
