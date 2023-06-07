import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rent_car/models/entities/offer_entity.dart';
import 'package:rent_car/models/repository/OffersRepository.dart';
import 'package:rxdart/rxdart.dart';
import '../entities/message_entity.dart';


  class MessagesRepository {
    final CollectionReference _messagesCollection = FirebaseFirestore.instance
        .collection('messages');

    OffersRepository offersRepository;

    MessagesRepository() :offersRepository = OffersRepository();

    Future<void> addMessage(String senderUid, String recieverUid, String text,
        Timestamp time, OfferEntity offerEntity) async {
      DocumentSnapshot offerSnapShot = await offersRepository.getOfferById(
          offerEntity.id);
      Message message = Message(offerRef: offerSnapShot.reference,
          text: text,
          senderUid: senderUid,
          recipientUid: recieverUid,
          timestamp: time);
      final docRef = _messagesCollection.doc();
      await docRef.set(message.toFireStore());
    }

    Future<List<Message>> getMessages(String senderUid, String recipientUid,
        OfferEntity offerEntity) async {
      DocumentSnapshot offerSnapShot = await offersRepository.getOfferById(
          offerEntity.id);
      final snapshot = await _messagesCollection
          .where('senderUid', isEqualTo: recipientUid)
          .where('recipientUid', isEqualTo: senderUid)
          .where('offerRef', isEqualTo: offerSnapShot.reference)
          .orderBy('timestamp', descending: false)
          .get();
      final snapshot2 = await _messagesCollection
          .where('senderUid', isEqualTo: senderUid)
          .where('recipientUid', isEqualTo: recipientUid)
          .where('offerRef', isEqualTo: offerSnapShot.reference)
          .orderBy('timestamp', descending: false)
          .get();

      List<QuerySnapshot> queries = [snapshot, snapshot2];
      List<QueryDocumentSnapshot> documents = [];
      for (QuerySnapshot snapshot in queries) {
        documents.addAll(snapshot.docs);
      }

      documents.sort((a, b) =>
          (b.data() as Map<String, dynamic>)['timestamp'].compareTo(
              (a.data() as Map<String, dynamic>)['timestamp']));

      List<Message> messages = documents
          .map((snapshot) => Message.fromFireStore(snapshot))
          .toList();

      return messages;
    }

    Future<Stream<List<Message>>> messagesStream(String senderUid,
        String recipientUid, OfferEntity offerEntity) async {
      DocumentSnapshot snapshot = await offersRepository.getOfferById(
          offerEntity.id);

      Stream<List<Message>> snapshot1 = _messagesCollection
          .where('senderUid', isEqualTo: recipientUid)
          .where('recipientUid', isEqualTo: senderUid)
          .where('offerRef', isEqualTo: snapshot.reference)
          .orderBy('timestamp', descending: false)
          .snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => Message.fromFireStore(doc)).toList());
      Stream<List<Message>> snapshot2 = _messagesCollection
          .where('senderUid', isEqualTo: senderUid)
          .where('recipientUid', isEqualTo: recipientUid)
          .where('offerRef', isEqualTo: snapshot.reference)
          .orderBy('timestamp', descending: false)
          .snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => Message.fromFireStore(doc)).toList());

      Stream<List<Message>> mergedStream = Rx.merge([snapshot1, snapshot2]);

      Stream<List<Message>> sortedMessagesStream = mergedStream.map((
          messagesList) {
        messagesList.sort((a, b) => b.timestamp.compareTo(a.timestamp));
        return messagesList;
      });

      return sortedMessagesStream;
    }
  }