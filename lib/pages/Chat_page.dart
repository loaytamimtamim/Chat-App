import 'package:flutter/material.dart';
import 'package:project5/models/messages_model.dart';
import 'package:project5/widget/Chat_Body.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  static String id = 'ChatApp';
  CollectionReference masseg = FirebaseFirestore.instance.collection('masseg');
  TextEditingController controller = TextEditingController();
  final _controller = ScrollController();

  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: masseg.orderBy('craet_time').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // بناء قائمة الرسائل
          List<Massages> massagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            massagesList.add(Massages.fromJson(snapshot.data!.docs[i]));
          }

          // Scroll to bottom when new message is added
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_controller.hasClients) {
              _controller.jumpTo(_controller.position.maxScrollExtent);
            }
          });

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'ChatApp',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: const Color.fromARGB(185, 46, 33, 33),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _controller, // ربط المتحكم بالقائمة
                    itemCount: massagesList.length,
                    itemBuilder: (context, index) {
                      return Chat_Body(
                        massages: massagesList[index],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      if (data.isNotEmpty) {
                        // add values massage to database in firebase
                        masseg.add({
                          'massage': data,
                          'craet_time': DateTime.now(),
                        });

                        // move list to end when a new message is sent
                        controller.clear();
                        _controller.animateTo(
                          _controller.position.maxScrollExtent,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Massage Sent',
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.send,
                          color: const Color.fromARGB(255, 3, 48, 85),
                        ),
                        onPressed: () {
                          if (controller.text.isNotEmpty) {
                            masseg.add({
                              'massage': controller.text,
                              'craet_time': DateTime.now(),
                            });
                            controller.clear();

                            // move list to end when a new message is sent
                            _controller.animateTo(
                              _controller.position.maxScrollExtent,
                              duration: Duration(minutes: 5),
                              curve: Curves.easeOut,
                            );
                          }
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          // في حالة عدم وجود بيانات
          return Scaffold(
            body: Center(child: Text('No messages available')),
          );
        }
      },
    );
  }
}
