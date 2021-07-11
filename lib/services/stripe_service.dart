import 'package:dio/dio.dart';
import 'package:payments_app/domain/models/payment_intent_response.dart';
import 'package:payments_app/domain/models/stripe_custom_response.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeService {
  StripeService._privateConstructor();

  static final StripeService _instance = StripeService._privateConstructor();
  factory StripeService() => _instance;

  String _url = "https://api.stripe.com/v1/payment_intents";
  static String _secretKey =
      "sk_test_51JBnnWKhmbJdSzm6d7pCPtlkhLfT9j3GpMap54GfVVhqk0p1qckUCh12dGtsAu3g0Brr6PPb7JQ6yvORqFW4coCr00dOAD5ELO";

  String _publishableKey =
      "pk_test_51JBnnWKhmbJdSzm6Usg5XakKG8QSU8YGEbYndyhBIUZjMgoCHkpKQIWUITAiaDfAHDQs1UiTp1gKf75ciVRNs19c00qjrj0TYx";

  final headersOptions = new Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {"Authorization": "Bearer ${StripeService._secretKey}"});

  init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey: _publishableKey,
        androidPayMode: "test",
        merchantId: "test"));
  }

  Future payWithCreditCard(
      {required String amount,
      required String currency,
      required CreditCard card}) async {
    try {
      // Aqui creo el metodo no lo pido desde el telefono
      final paymentMethod = await StripePayment.createPaymentMethod(
          PaymentMethodRequest(card: card));
      final resp = await this._makePayment(
          amount: amount, currency: currency, pmethod: paymentMethod);
      return resp;
    } catch (e) {
      return StripeCustomResponse(ok: false, messaje: e.toString());
    }
  }

  Future<StripeCustomResponse> payWithNewCreditCard({
    required String amount,
    required String currency,
  }) async {
    try {
      final paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      final resp = await this._makePayment(
          amount: amount, currency: currency, pmethod: paymentMethod);
      return resp;
    } catch (e) {
      return StripeCustomResponse(ok: false, messaje: e.toString());
    }
  }

  Future<StripeCustomResponse> payWithAppleAndroidService({
    required String amount,
    required String currency,
  }) async {
    try {
      final fixAmount = (double.parse(amount) / 100).toStringAsFixed(2);
      final token = await StripePayment.paymentRequestWithNativePay(
          androidPayOptions: AndroidPayPaymentRequest(
              currencyCode: currency, totalPrice: amount),
          applePayOptions: ApplePayPaymentOptions(
              countryCode: "us",
              currencyCode: currency,
              items: [
                ApplePayItem(label: "Ejemplo de articulo", amount: fixAmount)
              ]));
      final paymentMethod = await StripePayment.createPaymentMethod(
          PaymentMethodRequest(card: CreditCard(token: token.tokenId)));

      final resp = await this._makePayment(
          amount: amount, currency: currency, pmethod: paymentMethod);
      await StripePayment.completeNativePayRequest();

      return resp;
    } catch (e) {
      return StripeCustomResponse(ok: false, messaje: e.toString());
    }
  }

  Future _makePayment({
    required String amount,
    required String currency,
    required PaymentMethod pmethod,
  }) async {
    try {
      final resp =
          await this._createPaymentIntents(amount: amount, currency: currency);

      final confirmPayment = await StripePayment.confirmPaymentIntent(
          PaymentIntent(
              clientSecret: resp.clientSecret, paymentMethodId: pmethod.id));

      if (confirmPayment.status == 'succeeded') {
        return StripeCustomResponse(ok: true);
      }
      return StripeCustomResponse(
        ok: false,
        messaje: "Error ${confirmPayment.status}",
      );
    } catch (e) {
      return StripeCustomResponse(ok: false, messaje: e.toString());
    }
  }

  Future<PaymentIntentResponse> _createPaymentIntents({
    required String amount,
    required String currency,
  }) async {
    try {
      final dio = new Dio();
      final params = {'amount': amount, "currency": currency};
      final resp = await dio.post(
        _url,
        data: params,
        options: headersOptions,
      );
      return PaymentIntentResponse.fromJson(resp.data);
    } catch (e) {
      return PaymentIntentResponse(status: '400');
    }
  }
}
