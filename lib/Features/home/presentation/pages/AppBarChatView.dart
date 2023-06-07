import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_car/Features/home/presentation/pages/widgets/loading_view.dart';
import 'package:rent_car/Features/home/presentation/viewModel/offers_bloc/offers_cubit.dart';
import 'package:rent_car/models/entities/offer_entity.dart';

import '../../../../application/core/routes.dart';

class AppBarChatViewScreen extends StatelessWidget {
  const AppBarChatViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        builder: (BuildContext context,
            AsyncSnapshot<List<OfferEntity>> snapshot) {
          return BlocConsumer<OffersCubit,OffersState>(
              listener: (context,state){
              },
              builder: (context,state){
            if(state is OffersLoaded){
              if(snapshot.hasData) {
                if(snapshot.data!.isNotEmpty) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<OffersCubit>().getOffers();
                    }
                    , child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ChatItemWidget(
                        offerEntity: snapshot.data![index],);
                    }, itemCount: snapshot.data!.length,),
                  );
                }else{
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<OffersCubit>().getOffers();
                    }
                    , child: ListView(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height-160,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(Icons.chat_bubble_outline,size: 40),
                                Text("No messages yet",style: TextStyle(fontSize: 20),)
                              ],
                            ),
                          ),
                        )

                      ],
                    )
                  );
                }

              }else{
                return const Center(
                  child: Text("data"),
                );
              }
            }else{
              return const LoadingView();
            }
          });
        },
        stream: context.read<OffersCubit>().offersStream,
      ),
    );
  }
}

class ChatItemWidget extends StatelessWidget {

  final OfferEntity offerEntity;
  const ChatItemWidget({Key? key,required this.offerEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, Routes.routes(RouteSettings(name: Routes.chatPage,arguments: [
          (FirebaseAuth.instance.currentUser!.uid == offerEntity.renterEntity!.id)?
          offerEntity.carEntity!.userEntity!.id:offerEntity.renterEntity!.id
              ,FirebaseAuth.instance.currentUser!.uid,offerEntity
        ])));
      },
      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 80,
        width: double.infinity,
        child: Row(
          children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
            width: 80,
            height: 80,
            decoration:  BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(offerEntity.carEntity!.images![0]),
              ),
            ),
        ),
          ),
            const SizedBox(width: 8,),
            Text((FirebaseAuth.instance.currentUser!.uid == offerEntity.renterEntity!.id)
                ? offerEntity.carEntity!.userEntity!.name!
                : offerEntity.renterEntity!.name!)
          ],
        ),
      ),
      ),
    );
  }
}
