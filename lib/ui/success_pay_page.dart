import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SuccessPaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Success"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.solidSmileBeam,
            size: 156,
            color: Colors.amber,
          ),
          FittedBox(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Text(
                "Payment success, verify your account!",
                style: TextStyle(color: Colors.green, fontSize: 25),
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
            ),
          )
        ],
      ),
    );
  }
}
