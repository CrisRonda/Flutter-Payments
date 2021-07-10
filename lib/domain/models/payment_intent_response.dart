import 'dart:convert';

PaymentIntentResponse paymentIntentResponseFromJson(String str) =>
    PaymentIntentResponse.fromJson(json.decode(str));

String paymentIntentResponseToJson(PaymentIntentResponse data) =>
    json.encode(data.toJson());

class PaymentIntentResponse {
  PaymentIntentResponse({
    this.id,
    this.object,
    this.amount,
    this.amountCapturable,
    this.amountReceived,
    this.captureMethod,
    this.clientSecret,
    this.confirmationMethod,
    this.created,
    this.currency,
    this.livemode,
    this.paymentMethodTypes,
    this.status,
  });

  String? id;
  String? object;
  int? amount;
  int? amountCapturable;
  int? amountReceived;
  String? captureMethod;
  String? clientSecret;
  String? confirmationMethod;
  int? created;
  String? currency;
  bool? livemode;
  List<String>? paymentMethodTypes;
  String? status;

  factory PaymentIntentResponse.fromJson(Map<String, dynamic> json) =>
      PaymentIntentResponse(
        id: json["id"],
        object: json["object"],
        amount: json["amount"],
        amountCapturable: json["amount_capturable"],
        amountReceived: json["amount_received"],
       
        captureMethod: json["capture_method"],
        clientSecret: json["client_secret"],
        confirmationMethod: json["confirmation_method"],
        created: json["created"],
        currency: json["currency"],
        livemode: json["livemode"],
        paymentMethodTypes:
            List<String>.from(json["payment_method_types"].map((x) => x)),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "amount": amount,
        "amount_capturable": amountCapturable,
        "amount_received": amountReceived,
        "capture_method": captureMethod,
        "client_secret": clientSecret,
        "confirmation_method": confirmationMethod,
        "created": created,
        "currency": currency,
        "livemode": livemode,
        "status": status,
      };
}
