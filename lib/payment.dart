// import 'package:flutter/material.dart';
// import 'package:square_in_app_payments/in_app_payments.dart';
// import 'package:square_in_app_payments/models.dart';
// import 'package:square_in_app_payments/google_pay_constants.dart' as google_pay_constants;



// class PaymentPage extends StatefulWidget {
//   @override
//   _PaymentPageState createState() => _PaymentPageState();
// }

// class _PaymentPageState extends State<PaymentPage> {
//   @override
//   void initState() {
//     super.initState();
//     // Initialize Square Payment SDK with your application ID
//     InAppPayments.setSquareApplicationId('sandbox-sq0idb-6as7_ehfzRHQ1xISb9uW_Q');
//   }

//   // Handle card payment
//   void _onPayButtonPressed() async {
//     try {
//       // Start the card entry flow
//       await InAppPayments.startCardEntryFlow(
//         onCardNonceRequestSuccess: _onCardNonceRequestSuccess,
//         onCardEntryCancel: _onCardEntryCancel,
//       );
//     } catch (e) {
//       print("Error: $e");
//     }
//   }

//   // This function will be called when card details are successfully entered
//   void _onCardNonceRequestSuccess(CardDetails result) {
//     // Here you would typically send the card details to your backend to process the payment.
//     // For this example, we'll just print the card nonce.
//     print("Card nonce: ${result.nonce}");
    
//     // Complete the card entry flow
//     InAppPayments.completeCardEntry(
//       onCardEntryComplete: _onCardEntryComplete,
//     );
//   }

//   void _onCardEntryComplete() {
//     // Payment completed, handle success
//     print("Payment Successful!");
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Payment Successful!')),
//     );
//   }

//   void _onCardEntryCancel() {
//     // Handle the card entry being canceled by the user
//     print("Card entry canceled");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Square Payment Gateway'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _onPayButtonPressed,
//           child: Text('Pay with Square'),
//         ),
//       ),
//     );
//   }
// }