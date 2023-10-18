import 'package:geocoding/geocoding.dart';
import 'package:rxdart/rxdart.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../data/repository/location_repo.dart';

class LocationController extends GetxController implements GetxService {
  final LocationRepo locationRepo;
  LocationController({required this.locationRepo});

  late PublishSubject<void> debounceSubject;

  late String _selectedAddress;
  String get selectedAddress => _selectedAddress;

  bool setSelectedAddress = false;

  late Map<String, dynamic> _getAddress;
  Map<String, dynamic> get getAddress => _getAddress;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _address;

  String? getAddressName() {
    return _address;
  }

  @override
  void onInit() {
    super.onInit();

    setAddress(42.1234443, 24.6886565);

    _selectedAddress = '';

    debounceSubject = PublishSubject<void>();
    debounceSubject.debounceTime(Duration(seconds: 1)).listen((_) {
      updateAddress(LatLng.fromJson(getAddress));
    });
  }

  LatLng getAddressToLatLng() {
    return LatLng.fromJson(getAddress);
  }

  void setAddress(double lat, double lng) {
    _getAddress = LatLng(lat, lng).toJson();
    update();
  }

  void setFinalAddress(){
    if(_address != null){
      _selectedAddress = _address!;
      setSelectedAddress = true;
    }
  }

  void clean(){
    _selectedAddress = '';
    _address = null;
    _getAddress = {};
  }

  void updateAddress(LatLng initialPosition) async {
    try {

      List<Placemark> placemarks = await placemarkFromCoordinates(
          initialPosition.latitude, initialPosition.longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        _address =
        '${placemark.street ?? ''}, ${placemark.subLocality ?? ''}, ${placemark.locality ?? ''}, ${placemark.administrativeArea ?? ''}, ${placemark.country ?? ''}';
        update();
      }

      _isLoading = false;
    } catch (e) {
      print('Error getting address: $e');
    }
  }

  void setLoading(bool bool) {
    _isLoading = bool;
  }
}