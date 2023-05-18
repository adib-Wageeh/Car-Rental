import 'package:flutter/material.dart';
import 'package:rent_car/Features/home/presentation/pages/widgets/placeHolders.dart';
import 'package:shimmer/shimmer.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children:
              List.generate(15, (index) {
                return const ContentPlaceholder(
                  lineType: ContentLineType.threeLines,
                );
              })

          ),
        ));
  }
}