import 'package:auto_point_mobile/controllers/cartItem_controller.dart';
import 'package:auto_point_mobile/controllers/user_controller.dart';
import 'package:auto_point_mobile/data/entities/order.dart';
import 'package:auto_point_mobile/data/repository/order_repo.dart';
import 'package:get/get.dart';

import '../data/entities/user.dart';

class OrderController extends GetxController implements GetxService{
  final OrderRepo orderRepo;
  late final Response? response;

  OrderController({required this.orderRepo});

  int _paymentIndex = 0;
  int get paymentIndex => _paymentIndex;

  String _deliveryType = "Free";//Free , Fast
  String get deliveryType => _deliveryType;

  late int _currentOrderId;
  int get currentOrderId => _currentOrderId;

  late OrderEntity? _order;
  OrderEntity? get order => _order;

  late String _phoneNumber;
  String get phoneNumber => _phoneNumber;

  late String _city;
  String get city => _city;

  late String _postCode;
  String get postCode => _postCode;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<OrderEntity> _orderList = [];
  List<OrderEntity> get orderList => _orderList;

  List<OrderEntity> _pendingOrderList = [];
  List<OrderEntity> get pendingOrderList => _pendingOrderList;

  Future<void> getOrdersFromAPI() async{
    response = await orderRepo.getOrderList();

    if(response?.statusCode == 200){
      _orderList = [];

      for (var item in response?.body ) {
        _orderList.add(OrderEntity.fromJson(item));
      }

      update();
    }
  }

  Future<void> getOrdersForLoggedUser()async{
    _isLoading = true;

    List<OrderEntity> orders = [];
    List<OrderEntity> pendingOrders = [];

    try{
      for(var value in await orderRepo.getOrdersForUser(Get.find<UserController>().user!.id!)){
        if(value.status == "Pending"){
          pendingOrders.add(value);
        }else{
          orders.add(value);
        }
      }

      _pendingOrderList = pendingOrders;
      _orderList = orders;
    }catch(e){
      print(e);
    }

    _isLoading = false;
    print("The length of orders is ${orders.length} ${pendingOrders.length}");
    update();
  }

  void setPaymentIndex(int index){
    _paymentIndex = index;
    update();
  }

  void setPhoneNumber(String number){
    _phoneNumber = number;
    update();
  }

  void setDeliveryType(String type){
    _deliveryType = type;
  }

  void setCity(String city){
    _city = city;
    update();
  }

  void setPostCode(String postCode){
    _postCode = postCode;
    update();
  }

  void setCurrentOrderId(int id){
    _currentOrderId = id;
  }

  void setAllToDefault(){
    setCurrentOrderId(0);
    setOrder(null);
    setCity("");
    setPhoneNumber("");
    setPostCode("");
  }

  Future<void> placeOrder(bool isPending) async{
    _isLoading = true;

    User user = Get.find<UserController>().user!;

    OrderEntity order = OrderEntity(
        id: 0,
        companyName: "",
        addressTwo: "",
        details: "",
        userId: user.id ?? 0,
        productIds: Get.find<CartItemController>().getCartItemsIds(),
        productQuantities: Get.find<CartItemController>().getCartItemsQuantities(),
        productsCount: Get.find<CartItemController>().getCartItemsIds().split(' ').length,
        fullName: "${user.firstName!} ${user.lastName!}",
        phoneNumber:phoneNumber,
        email: user.email!,
        addressOne: user.address!,
        city: city,
        postcode: postCode,
        paymentMethod: paymentIndex == 0 ? "Free" : "Card",//cash ili card
        deliveryType: deliveryType,
        total: paymentIndex == 0 ? Get.find<CartItemController>().totalAmount : Get.find<CartItemController>().totalAmount + 12,
        deliveryDate: DateTime.now().add(const Duration(days: 7)).toIso8601String(),
        status: isPending? "Pending" : "In Processing");

    Map<String,dynamic> response = await orderRepo.placeOrder(order);

    if(response["id"] != null){
      _isLoading = false;
      setCurrentOrderId(response["id"]);
      setOrder(await orderRepo.getOrder(currentOrderId));
    }
  }

  void setOrder(OrderEntity? order){
    _order = order;
  }

  Future<void> updateOrder() async {
    setStatus("Pending");
    orderRepo.updateOrder(currentOrderId, order!);
  }
  
  void setStatus(String status){
    _order!.status = status;
  }

  Future<void> deleteCurrentOrder() async {
    await orderRepo.deleteOrder(currentOrderId);
    setOrder(null);
  }
}