import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../models/cuacamodel.dart';
import '../../../models/nextday.dart';
import '../../../services/weather_service.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final tempData = GetStorage();
  RxBool isCelsius = true.obs;
  RxBool isLoad = true.obs;
  RxBool isMph = false.obs;
  final RxDouble _lat = 0.0.obs;
  final RxDouble _long = 0.0.obs;

  var lokasi = Rxn<Cuacamodel>();
  var current=Rxn<Current>();
  var location=Rxn<Location>();
  var nextday=Rxn<Nextday>();

  TextEditingController namakota = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    getLocation();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void togglerCelsius() {
    isCelsius.value = !isCelsius.value;
  }

  void togglerMph() {
    isMph.value = !isMph.value;
  }

  void getWeather() async {
    try {
      var req = await WeatherService.getDataWeather("${_lat.value},${_long.value}");
      var res = cuacamodelFromJson(req);
      lokasi.value = res;
      location.value = lokasi.value!.location;
      current.value = lokasi.value!.current;
      final nex=nextdayFromJson(req);
      nextday.value = nex;
      tempData.write("tempLocation", location.value);
      tempData.write("tempCurrent", current.value);
      tempData.write("tempNextday", nextday.value);
      isLoad.value = false;
    }catch(e){
      location.value=tempData.read("tempLocation");
      current.value=tempData.read("tempCurrent");
      nextday.value=tempData.read("tempNextday");
    } finally {
      isLoad.value = false;
    }
  }
  void getWeatherSearch() async {
    try {
      var req = await WeatherService.getDataWeather(namakota.text);
      var res = cuacamodelFromJson(req);
      lokasi.value = res;
      location.value = lokasi.value!.location;
      current.value = lokasi.value!.current;
      final nex=nextdayFromJson(req);
      nextday.value = nex;
    }catch(e){

    } finally {
      isLoad.value = false;
    }
  }


  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return Future.error("Location not enabled");
    }
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permission are denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location permission is denied");
      }
    }
    return await Geolocator.getCurrentPosition(
            locationSettings: LocationSettings(accuracy: LocationAccuracy.high))
        .then((value) {
      _lat.value = value.latitude;
      _long.value = value.longitude;
      getWeather();
    });
  }
}
