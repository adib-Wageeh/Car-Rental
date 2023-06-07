
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rent_car/models/entities/offer_entity.dart';

class Message{
  String? id;
final String text;
final String senderUid;
final String recipientUid;
final Timestamp timestamp;
final DocumentReference offerRef;
OfferEntity? offerEntity;

    Message({
      this.offerEntity,
      required this.offerRef,
      this.id,
      required this.text,
      required this.senderUid,
      required this.recipientUid,
      required this.timestamp,
    });

    factory Message.fromFireStore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Message(
      offerRef: data['offerRef'],
    id: doc.id,
    text: data['text'],
    senderUid: data['senderUid'],
    recipientUid: data['recipientUid'],
    timestamp: data['timestamp'],
    );
    }

    Map<String, dynamic> toFireStore() {
    return {
    'text': text,
    'senderUid': senderUid,
    'recipientUid': recipientUid,
    'timestamp': timestamp,
     'offerRef':offerRef
    };
    }
}