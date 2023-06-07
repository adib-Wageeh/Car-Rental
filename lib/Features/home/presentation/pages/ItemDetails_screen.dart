import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rent_car/Features/home/presentation/pages/widgets/ItemDetailsPage/CurrentImageIndexWidget.dart';
import 'package:rent_car/Features/home/presentation/pages/widgets/ItemDetailsPage/FullScreenImagePage.dart';
import 'package:rent_car/Features/home/presentation/pages/widgets/ItemDetailsPage/ItemDetailsWidget.dart';
import 'package:rent_car/Features/home/presentation/pages/widgets/ItemDetailsPage/SellerDescriptionWidget.dart';
import 'package:rent_car/Features/home/presentation/pages/widgets/SplitterWidget.dart';
import 'package:rent_car/application/core/assets.dart';
import 'package:rent_car/models/entities/car_entity.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ListItemDetailsScreen extends StatefulWidget {
  const ListItemDetailsScreen({required this.carEntity,Key? key}) : super(key: key);
  final CarEntity carEntity;

  @override
  State<ListItemDetailsScreen> createState() => _ListItemDetailsScreenState();
}

class _ListItemDetailsScreenState extends State<ListItemDetailsScreen> {

  int currIndex=0;
  @override
  Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Assets.appPrimaryWhiteColor,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 12,),
                Hero(
                  tag: widget.carEntity.id,
                  child: CarouselSlider.builder(
                    itemCount: widget.carEntity.images!.length,
                    itemBuilder: (context,index,index2){
                    return InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          opaque: false,
                          barrierColor: Colors.black,
                          pageBuilder: (BuildContext context, _, __) {
                            return FullScreenImagePage(
                              dark: true,
                              child: Image.network(widget.carEntity.images![index]),
                            );
                          },
                        ),
                      );
                    }
                    ,child: CachedNetworkImage(
                        fit: BoxFit.fitWidth,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        imageUrl: widget.carEntity.images![index],
                      ),
                    );
                    }, options: CarouselOptions(enableInfiniteScroll: false,autoPlay: true,onPageChanged: (index,reason){
                    setState(() {
                      currIndex = index;
                    });
                  }),
                  ),
        ),
                CurrentImageIndexWidget(carEntity: widget.carEntity,selectedIndex: currIndex,),
                ItemDetailsWidget(icon: FontAwesomeIcons.car,title: "Car Name",text: widget.carEntity.carName!),
                const SplitterWidget(),
                ItemDetailsWidget(text: widget.carEntity.description!,title: "Description",icon: FontAwesomeIcons.fileContract),
                const SplitterWidget(),
                ItemDetailsWidget(title: "Location",text: widget.carEntity.location,icon: FontAwesomeIcons.locationDot,),
                const SplitterWidget(),
                ItemDetailsWidget(title: "Price",text: "${widget.carEntity.pricePerDay!}\$/day",icon: FontAwesomeIcons.coins,)
                ,const SplitterWidget(),
                SellerDescriptionWidget(userEntity: widget.carEntity.userEntity!,carEntity: widget.carEntity),
              ],
            ),
          )),
      );
  }
}





