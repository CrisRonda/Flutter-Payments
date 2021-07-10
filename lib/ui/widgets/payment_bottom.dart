import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payments_app/bloc/paymet/payment_bloc.dart';
import 'package:payments_app/helpers/helpers.dart';
import 'package:payments_app/services/stripe_service.dart';
import 'package:stripe_payment/stripe_payment.dart';

class PaymentBotton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        return Container(
          width: size.width,
          height: 100,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, offset: Offset(1, 0), blurRadius: 18)
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
                    "\$ ${state.amount.toStringAsFixed(2)}",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
              _BtnPayment(state.isCardActive),
            ],
          ),
        );
      },
    );
  }
}

class _BtnPayment extends StatelessWidget {
  final paymentWithCard;

  const _BtnPayment(this.paymentWithCard);
  @override
  Widget build(BuildContext context) {
    return paymentWithCard
        ? buildCreditCard(context)
        : buildAppleAndGooglePay(context);
  }

  Widget buildCreditCard(BuildContext context) {
    final paymentState = BlocProvider.of<PaymentBloc>(context).state;
    final card = paymentState.card;
    final exp = card!.expiracyDate.split('/');
    return MaterialButton(
        onPressed: () async {
          showLoading(context);
          final stripeService = new StripeService();
          final resp = await stripeService.payWithCreditCard(
              amount: paymentState.toPay,
              currency: paymentState.currency,
              card: new CreditCard(
                number: paymentState.card?.cardNumber,
                expMonth: int.parse(exp[0]),
                expYear: int.parse(exp[1]),
              ));
          Navigator.pop(context);
          if (!resp.ok) {
            return showAlert(context, "Error", resp.messaje);
          } 
        },
        minWidth: 170,
        height: 45,
        shape: StadiumBorder(),
        elevation: 5,
        color: Colors.amber,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.solidCreditCard,
              color: Colors.white,
              size: 18,
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              "Pay",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
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
            SizedBox(
              width: 16,
            ),
            Text(
              "Pay",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ));
  }
}
