import 'package:payments_app/domain/models/credit_card.dart';

class CreditCartService {
  Future<List<CustomCreditCard>> getCreditCards() async {
    final data = await Future.delayed(Duration(milliseconds: 789))
        .then((value) => fakeCards);
    return data;
  }
}

final List<CustomCreditCard> fakeCards = <CustomCreditCard>[
  CustomCreditCard(
      cardNumberHidden: '4242',
      cardNumber: '4242424242424242',
      brand: 'visa',
      cvv: '213',
      expiracyDate: '01/25',
      cardHolderName: 'Fernando Herrera'),
  CustomCreditCard(
      cardNumberHidden: '5555',
      cardNumber: '5555555555554444',
      brand: 'mastercard',
      cvv: '213',
      expiracyDate: '01/25',
      cardHolderName: 'Melissa Flores'),
  CustomCreditCard(
      cardNumberHidden: '3782',
      cardNumber: '378282246310005',
      brand: 'american express',
      cvv: '2134',
      expiracyDate: '01/25',
      cardHolderName: 'Eduardo Rios'),
];
