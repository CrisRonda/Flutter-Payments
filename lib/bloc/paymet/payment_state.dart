part of 'payment_bloc.dart';

@immutable
class PaymentState {
  final double amount;
  final String currency;
  final bool isCardActive;
  final CustomCreditCard? card;

  PaymentState(
      {this.amount = 230,
      this.currency = 'usd',
      this.isCardActive = false,
      this.card});

  String get toPay => "${(this.amount * 100).floor()}";

  PaymentState copyWith({
    double? amount,
    String? currency,
    bool? isCardActive,
    CustomCreditCard? card,
  }) =>
      new PaymentState(
          amount: amount ?? this.amount,
          card: card ?? this.card,
          isCardActive: isCardActive ?? this.isCardActive,
          currency: currency ?? this.currency);
}
