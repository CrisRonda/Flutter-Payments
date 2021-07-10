import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:payments_app/domain/models/credit_card.dart';
import 'package:payments_app/helpers/helpers.dart';
import 'package:payments_app/services/credit_card_service.dart';
import 'package:payments_app/ui/card_page.dart';
import 'package:payments_app/ui/widgets/payment_bottom.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _creditCardService = CreditCartService();
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Payments"),
          actions: [
            IconButton(
                onPressed: () async {
                  showAlert(context, "Error", "Nada nada mijin");
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: FutureBuilder(
          future: _creditCardService.getCreditCards(),
          builder: (BuildContext context,
              AsyncSnapshot<List<CustomCreditCard>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text("No data"),
              );
            }
            final cards = snapshot.data!;
            return Stack(
              children: [
                Positioned(
                  width: size.width,
                  height: size.height,
                  top: 156,
                  child: PageView.builder(
                    controller: PageController(viewportFraction: 0.9),
                    itemCount: cards.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (_, i) {
                      final currentCard = cards[i];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context, navigationFadeIn(context, CardPage()));
                        },
                        child: Hero(
                          flightShuttleBuilder: flightShuttleBuilder,
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
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: PaymentBotton(),
                ),
              ],
            );
          },
        ));
  }
}
