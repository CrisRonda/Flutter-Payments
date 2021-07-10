import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:payments_app/bloc/paymet/payment_bloc.dart';
import 'package:payments_app/domain/models/credit_card.dart';
import 'package:payments_app/ui/widgets/payment_bottom.dart';

class CardPage extends StatelessWidget {
  final currentCard = CustomCreditCard(
      cardNumberHidden: '4242',
      cardNumber: '4242424242424242',
      brand: 'visa',
      cvv: '213',
      expiracyDate: '01/25',
      cardHolderName: 'Fernando Herrera');
  @override
  Widget build(BuildContext context) {
    final paymentBloc = BlocProvider.of<PaymentBloc>(context);
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        showCupertinoDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => CupertinoAlertDialog(
                  title: Text(
                    "Warning",
                    style: TextStyle(color: theme.primaryColor),
                  ),
                  content: Text("Are you sure cancel your payment?",
                      style: TextStyle(color: theme.primaryColor)),
                  actions: [
                    MaterialButton(
                        child: Text(
                          "OK",
                          style: TextStyle(color: theme.errorColor),
                        ),
                        onPressed: () {
                          paymentBloc.add(OnDeSelectCard());
                          Navigator.pushNamedAndRemoveUntil(
                              context, "home", (route) => false);
                        }),
                    MaterialButton(
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: theme.toggleableActiveColor),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
                ));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [],
          title: Text(
            "Payment with  ${currentCard.brand.toUpperCase()}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: Stack(
          children: [
            Container(),
            Hero(
              tag: "hero-${currentCard.cardNumberHidden}",
              child: CreditCardWidget(
                animationDuration: Duration(seconds: 1),
                cardBgColor: Colors.grey,
                textStyle: TextStyle(
                    color: Colors.amber.shade50,
                    fontWeight: FontWeight.w400,
                    fontSize: 21),
                cardNumber: currentCard.cardNumber,
                expiryDate: currentCard.expiracyDate,
                cardHolderName: currentCard.cardHolderName,
                cvvCode: currentCard.cvv,
                showBackView: false,
              ),
            ),
            Positioned(
              bottom: 0,
              child: PaymentBotton(),
            ),
          ],
        ),
      ),
    );
  }
}
