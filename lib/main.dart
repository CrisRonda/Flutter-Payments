import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payments_app/bloc/paymet/payment_bloc.dart';

import 'package:payments_app/ui/card_page.dart';
import 'package:payments_app/ui/home_page.dart';
import 'package:payments_app/ui/success_pay_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PaymentBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Stripe App',
        initialRoute: "home",
        routes: {
          'home': (_) => HomePage(),
          'success_pay': (_) => SuccessPaymentPage(),
          'card': (_) => CardPage(),
        },
        theme: ThemeData.light().copyWith(
            primaryColor: Color(0xff284879),
            scaffoldBackgroundColor: Color(0xff21232a)),
      ),
    );
  }
}
