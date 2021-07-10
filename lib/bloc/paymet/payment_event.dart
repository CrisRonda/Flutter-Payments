part of 'payment_bloc.dart';

@immutable
abstract class PaymentEvent {}

class OnSelectCard extends PaymentEvent {
  final CustomCreditCard card;

  OnSelectCard(this.card); 
}
class OnDeSelectCard extends PaymentEvent {}
