import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rent_car/models/entities/offer_entity.dart';
import '../../../../../models/repository/OffersRepository.dart';

part 'offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  OffersCubit(this.offersRepository) : super(OffersInitial());

  StreamController<List<OfferEntity>> offersController = StreamController<List<OfferEntity>>.broadcast();
  List<OfferEntity> offersList=[];
  Stream<List<OfferEntity>> get offersStream => offersController.stream;
  final OffersRepository offersRepository;

  Future<void> getOffers()async{

    emit(OffersLoading());

    offersList = await offersRepository.getOffers();
    offersController.sink.add(offersList);
    emit(OffersLoaded());
  }

  void addOffer(String carUid,String sellerUid){
    offersRepository.addOffer(carUid, sellerUid);
  }

}
