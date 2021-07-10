part of 'payment_bloc.dart';

@immutable
class PaymentState {
  final double amount;
  final String currency;
  final bool isCardActive;
  final CustomCreditCard? card;

  PaymentState(
      {this.amount = 0,
      this.currency = '',
      this.isCardActive = false,
      this.card});

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
