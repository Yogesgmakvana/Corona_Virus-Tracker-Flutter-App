import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CountryController extends GetxController {

  var countries = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchCountries();
    super.onInit();
  }

  Future<void> fetchCountries() async {
    try {
      isLoading(true);

      final response = await http.get(
        Uri.parse('https://disease.sh/v3/covid-19/countries'),
      );

      if (response.statusCode == 200) {
        countries.value = jsonDecode(response.body);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}