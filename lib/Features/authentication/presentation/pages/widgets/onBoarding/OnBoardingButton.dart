
import 'package:flutter/material.dart';

class OnBoardingButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color? textColor;
  const OnBoardingButton({this.textColor,required this.text,Key? key,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.85,
      height: 46,
      child: ElevatedButton(onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.onSecondary),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ), child: Text(text,style: TextStyle(color: textColor??Theme.of(context).colorScheme.primary)),
      ),
    );
  }
}
