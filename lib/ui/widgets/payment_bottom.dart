import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentBotton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 100,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(1, 0), blurRadius: 18)
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "\$ 250",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
          _BtnPayment(),
        ],
      ),
    );
  }
}

class _BtnPayment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return true ? buildCreditCard(context) : buildAppleAndGooglePay(context);
  }

  Widget buildCreditCard(BuildContext context) {
    return MaterialButton(
        onPressed: () {},
        minWidth: 170,
        height: 45,
        shape: StadiumBorder(),
        elevation: 5,
        color: Colors.amber,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(FontAwesomeIcons.solidCreditCard,
              color: Colors.white,
              size: 18,
            ),
            SizedBox(width: 16,),
            Text(
              "Pay",
              style: TextStyle(fontSize: 18, color: Colors.white,),
            ),
          ],
        ));
  }

  Widget buildAppleAndGooglePay(BuildContext context) {
    return MaterialButton(
        onPressed: () {},
        minWidth: 150,
        height: 45,
        shape: StadiumBorder(),
        elevation: 5,
        color: Colors.amber,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Platform.isAndroid
                  ? FontAwesomeIcons.google
                  : FontAwesomeIcons.apple,
              color: Colors.white,
              size: 18,
            ),
            SizedBox(width: 16,),
            Text(
              "Pay",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ));
  }
}
