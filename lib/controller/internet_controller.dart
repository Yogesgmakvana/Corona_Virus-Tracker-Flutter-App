import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetController extends GetxController {

  var hasInternet = true.obs;

  @override
  void onInit() {
    super.onInit();
    listenInternet();
  }

  void listenInternet() {
    Connectivity().onConnectivityChanged.listen((event) async {
      bool result = await InternetConnection().hasInternetAccess;
      hasInternet.value = result;
    });
  }
}