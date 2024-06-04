import 'package:flutter/material.dart';
import 'package:mypayments/models/contact.dart';
import 'package:mypayments/utils/text_data.dart';

class ContactListItem extends StatelessWidget {
  final Function() onTapRecharge;
  final Contact contact;
  const ContactListItem(
      {super.key, required this.contact, required this.onTapRecharge});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              contact.name,
              style: TextStyle(
                  color: Colors.blue.shade800, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                contact.number,
                style: const TextStyle(color: Colors.black54),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 96, 118, 190),
                  shadowColor: Colors.transparent),
              onPressed: onTapRecharge,
              child: const Text(
                TextData.rechargeNow,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
            )
          ],
        ),
      ),
    );
  }
}
