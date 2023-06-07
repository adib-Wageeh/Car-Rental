import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../application/core/assets.dart';
import '../../../../models/entities/message_entity.dart';
import '../../../../models/entities/offer_entity.dart';
import '../../../../models/repository/MessageRepository.dart';
import '../viewModel/messages_bloc/messages_bloc.dart';

class ChatPage extends StatefulWidget {
  final String senderUid;
  final String recipientUid;
  final OfferEntity offerEntity;
  const ChatPage({required this.offerEntity,required this.recipientUid,required this.senderUid,super.key});

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  late MessagesBloc _messagesBloc;

  @override
  void initState() {
    super.initState();
    _messagesBloc = MessagesBloc(MessagesRepository());
    _messagesBloc.loadMessages(widget.senderUid, widget.recipientUid,widget.offerEntity);
    _messagesBloc.startMessagesStream(widget.senderUid, widget.recipientUid,widget.offerEntity);
  }

  @override
  void dispose() {
    _textController.dispose();
    _messagesBloc.close();
    super.dispose();
  }

  void _sendMessage(){
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      _messagesBloc.addMessage(widget.senderUid,widget.recipientUid,text,Timestamp.now(),widget.offerEntity);
      _textController.clear();
      _messagesBloc.loadMessages(widget.senderUid, widget.recipientUid,widget.offerEntity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${(widget.offerEntity.renterEntity!.id == FirebaseAuth.instance.currentUser!.uid)?
          widget.offerEntity.carEntity!.userEntity!.name:
          widget.offerEntity.renterEntity!.name
          }'),
        ),
        body: Column(
            children: [
              Expanded(
                child: BlocBuilder<MessagesBloc, List<Message>>(
                  bloc: _messagesBloc,
                  builder: (context, messages) {
                    return ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        return MessageWidget(message: message,);
                      },
                    );
                  },
                ),
              ),
              const Divider(height: 1),
              Container(
                  decoration: BoxDecoration(color: Theme
                      .of(context)
                      .cardColor),
                  child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _textController,
                            decoration: const InputDecoration.collapsed(
                                hintText: 'Send a message'),
                          ),
                        ),
                        IconButton(onPressed: (){
                          _sendMessage();
                        }, icon: Icon(Icons.send,color: Assets.appPrimaryWhiteColor,))
                      ]
                  ))
            ])
    );
  }
}

class MessageWidget extends StatelessWidget {
  final Message message;
  const MessageWidget({required this.message,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Align(
            alignment: (message.senderUid == FirebaseAuth.instance.currentUser!.uid)? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                  color: (message.senderUid == FirebaseAuth.instance.currentUser!.uid)? Colors.blue : Colors.grey[300],
                  borderRadius:
              BorderRadius.only(
              topLeft: Radius.circular((message.senderUid == FirebaseAuth.instance.currentUser!.uid)? 16.0 : 0.0),
              topRight: const Radius.circular(16.0),
              bottomLeft: const Radius.circular(16.0),
              bottomRight: Radius.circular((message.senderUid == FirebaseAuth.instance.currentUser!.uid)? 0.0 : 16.0),
            ),
          ),
          child: Text(
          message.text,
          style: TextStyle(color: (message.senderUid == FirebaseAuth.instance.currentUser!.uid)? Colors.white : Colors.black),
          ),
          ),
          ),
        ),
        const SizedBox(height: 4,)
      ],
    );
  }
}
