import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
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

    return Scaffold(
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
    );
  }
}
