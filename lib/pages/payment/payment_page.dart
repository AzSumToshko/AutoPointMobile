import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../controllers/order_controller.dart';
import '../../controllers/payment_controller.dart';
import '../../utils/paypal_services.dart';

class PaypalPayment extends StatefulWidget {
  final Function onFinish;
  final List items;
  final String totalAmount;
  final String subTotalAmount;
  String shippingCost = '0';
  int shippingDiscountCost = 0;
  final String userFirstName;
  final String userLastName;
  final String addressCity;
  final String addressStreet;
  final String addressZipCode;
  final String addressCountry;
  final String addressState;
  final String addressPhoneNumber;

  PaypalPayment({
    required this.onFinish,
    required this.items,
    required this.totalAmount,
    required this.subTotalAmount,
    required this.userFirstName,
    required this.userLastName,
    required this.addressCity,
    required this.addressStreet,
    required this.addressState,
    required this.addressCountry,
    required this.addressZipCode,
    required this.addressPhoneNumber,
  });

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentState();
  }
}

class PaypalPaymentState extends State<PaypalPayment> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late String? checkoutUrl = null;
  late String? executeUrl;
  late String accessToken;
  PaypalServices services = PaypalServices();

  // you can change default currency according to your need
  Map<dynamic,dynamic> defaultCurrency = {"symbol": "EUR ", "decimalDigits": 2, "symbolBeforeTheNumber": true, "currency": "EUR"};

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL= 'cancel.example.com';


  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      try {
        accessToken = (await services.getAccessToken())!;

        final transactions = getOrderParams();
        final res =
        await services.createPaypalPayment(transactions, accessToken);
        if (res != null) {
          setState(() {
            checkoutUrl = res["approvalUrl"]!;
            executeUrl = res["executeUrl"]!;
          });
        }
      } catch (e) {
        print('exception: '+e.toString());
        final snackBar = SnackBar(
          content: Text(e.toString()),
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        snackBar;
      }
    });
  }

  Map<String, dynamic> getOrderParams() {
    List items = widget.items;


    // checkout invoice details
    String totalAmount = widget.totalAmount;
    String subTotalAmount = widget.subTotalAmount;
    String shippingCost = widget.shippingCost;
    int shippingDiscountCost = widget.shippingDiscountCost;
    String userFirstName = widget.userFirstName;
    String userLastName = widget.userLastName;
    String addressCity = widget.addressCity;
    String addressStreet = widget.addressStreet;
    String addressZipCode = widget.addressZipCode;
    String addressCountry = widget.addressCountry;
    String addressState = widget.addressState;
    String addressPhoneNumber = widget.addressPhoneNumber;

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalAmount,
            "currency": defaultCurrency["currency"],
            "details": {
              "subtotal": subTotalAmount,
              "shipping": shippingCost,
              "shipping_discount":
              ((-1.0) * shippingDiscountCost).toString()
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": items,
            if (isEnableShipping &&
                isEnableAddress)
              "shipping_address": {
                "recipient_name": "$userFirstName $userLastName",
                "line1": addressStreet,
                "line2": "",
                "city": addressCity,
                "country_code": addressCountry,
                "postal_code": addressZipCode,
                "phone": addressPhoneNumber,
                "state": addressState
              },
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {
        "return_url": returnURL,
        "cancel_url": cancelURL
      }
    };
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    if (checkoutUrl != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () {
              Navigator.pop(context);
              Get.find<OrderController>().deleteCurrentOrder();
              Get.find<PaymentController>().setLoadingState(false);
            },
          ),
        ),
        body: WebView(
          initialUrl: checkoutUrl,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains(returnURL)) {
              final uri = Uri.parse(request.url);
              final payerID = uri.queryParameters['PayerID'];
              if (payerID != null) {
                services
                    .executePayment(executeUrl, payerID, accessToken)
                    .then((id) {

                  widget.onFinish();
                });
              } else {
                Navigator.of(context).pop();
                Get.find<OrderController>().deleteCurrentOrder();
                Get.find<PaymentController>().setLoadingState(false);
              }
              Navigator.of(context).pop();
            }else{
              Get.find<OrderController>().deleteCurrentOrder();
              Get.find<PaymentController>().setLoadingState(false);
            }
            if (request.url.contains(cancelURL)) {
              Navigator.of(context).pop();
              Get.find<OrderController>().deleteCurrentOrder();
              Get.find<PaymentController>().setLoadingState(false);
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
                Get.find<OrderController>().deleteCurrentOrder();
                Get.find<PaymentController>().setLoadingState(false);
              }),
          backgroundColor: Colors.black12,
          elevation: 0.0,
        ),
        body: Center(child: Container(child: CircularProgressIndicator())),
      );
    }
  }
}