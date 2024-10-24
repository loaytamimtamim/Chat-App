import 'package:flutter/material.dart';
import 'package:project5/models/messages_model.dart';

class Chat_Body extends StatelessWidget {
  const Chat_Body({
    super.key,
    required this.massages,
  });
  final Massages massages;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 86, 245, 72),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            )),
        child: Text(
          massages.message, // عرض الرسالة الفعلية
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
