import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:payments_app/domain/models/credit_card.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentState());

  @override
  Stream<PaymentState> mapEventToState(
    PaymentEvent event,
  ) async* {
    if (event is OnSelectCard) {
      yield state.copyWith(isCardActive: true, card: event.card);
    }
    if (event is OnDeSelectCard) {
      yield state.copyWith(isCardActive: false);
    }
  }
}
