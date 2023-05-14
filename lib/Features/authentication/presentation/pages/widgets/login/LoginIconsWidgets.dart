import 'package:flutter/material.dart';

class AuthenticationBottomIcons extends StatelessWidget {

  final String image;
  final void Function() onTab;
  const AuthenticationBottomIcons({required this.onTab,required this.image,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTab,
        borderRadius: BorderRadius.circular(36),
        child: Container(
          width: 90,
          height: 40,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(36),
            border:Border.all(width: 0.2,color: Colors.black),

          ),
          child: SizedBox(
            height: 40,
            width: 40,
            child: Image.asset(image),
          ),
        ),
      ),
    );
  }
}