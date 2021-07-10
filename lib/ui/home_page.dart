import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:payments_app/bloc/paymet/payment_bloc.dart';
import 'package:payments_app/domain/models/credit_card.dart';
import 'package:payments_app/helpers/helpers.dart';
import 'package:payments_app/services/credit_card_service.dart';
import 'package:payments_app/ui/card_page.dart';
import 'package:payments_app/ui/widgets/payment_bottom.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final _creditCardService = CreditCartService();
    final size = MediaQuery.of(context).size;
    final paymentBloc = BlocProvider.of<PaymentBloc>(context);
    final textStyle =
        Theme.of(context).textTheme.headline2!.copyWith(color: Colors.white);
    final AnimationController _controller = AnimationController(
      duration: Duration(seconds: 2, milliseconds: 234),
      vsync: this,
    )..forward();
    late final Animation<double> _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    @override
    // ignore: unused_element
    void dispose() {
      _controller.dispose();
      super.dispose();
    }

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
              return Center(child: CircularProgressIndicator());
            }
            final cards = snapshot.data!;
            if (cards.length == 0) {
              return Center(
                child: FittedBox(
                  child: Text(
                    "No fount cards",
                    style: textStyle,
                  ),
                ),
              );
            }

            return FadeTransition(
              opacity: _animation,
              child: Stack(
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
                            paymentBloc.add(OnSelectCard(currentCard));
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
              ),
            );
          },
        ));
  }
}
