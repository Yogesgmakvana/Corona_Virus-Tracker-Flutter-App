import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CovidController extends GetxController {

  var covidData = {}.obs;
  var isLoading = true.obs;

  var dataMap = <String, double>{}.obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    try {
      isLoading(true);

      var response = await http.get(
        Uri.parse("https://disease.sh/v3/covid-19/all"),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        covidData.value = data;

        dataMap.value = {
          "Total Cases": (data["cases"] as num).toDouble(),
          "Deaths": (data["deaths"] as num).toDouble(),
          "Recovered": (data["recovered"] as num).toDouble(),
          "Active": (data["active"] as num).toDouble(),
        };
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}