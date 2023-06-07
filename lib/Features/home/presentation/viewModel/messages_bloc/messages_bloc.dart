import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_car/models/entities/offer_entity.dart';

import '../../../../../models/entities/message_entity.dart';
import '../../../../../models/repository/MessageRepository.dart';


class MessagesBloc extends Cubit<List<Message>> {
  final MessagesRepository _messagesRepository;
  StreamSubscription? _messagesSubscription;

  MessagesBloc(this._messagesRepository) : super([]);

  void loadMessages(String senderUid, String recipientUid,OfferEntity offerEntity) async {
    emit(await _messagesRepository.getMessages(senderUid, recipientUid,offerEntity));
  }

  void startMessagesStream(String senderUid, String recipientUid,OfferEntity offerEntity) async{
    _messagesSubscription?.cancel();
    Stream<List<Message>> messages = await _messagesRepository.messagesStream(senderUid, recipientUid,offerEntity);
    _messagesSubscription = messages.listen((messages) {
      emit(messages);
    });

  }

  void addMessage(String senderUid,String recieverUid,String text,Timestamp time,OfferEntity offerEntity) {
    _messagesRepository.addMessage(senderUid,recieverUid,text,time,offerEntity);
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}