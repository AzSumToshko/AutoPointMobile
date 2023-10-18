import 'package:auto_point_mobile/data/repository/payment_repo.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController implements GetxService{
  final PaymentRepo paymentRepo;

  PaymentController({required this.paymentRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoadingState(bool bool) {
    _isLoading = bool;
    update();
  }

  void setLoadingStateWithoutUpdate(bool bool) {
    _isLoading = bool;
  }

}