import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';

class PaymentRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  PaymentRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

}