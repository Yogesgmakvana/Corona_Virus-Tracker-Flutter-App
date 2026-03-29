import 'package:covid_19_tracker/controller/country_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountryListScreen extends StatelessWidget {

  final CountryController controller = Get.put(CountryController());

  CountryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Country COVID Data"),
        centerTitle: true,
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: controller.fetchCountries,
          child: ListView.builder(
            itemCount: controller.countries.length,
            itemBuilder: (context, index) {
              final country = controller.countries[index];

              return ListTile(
                leading: Image.network(
                  country['countryInfo']['flag'],
                  width: 40,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.flag),
                ),
                title: Text(country['country']),
                subtitle: Text("Cases: ${country['cases']}"),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Deaths: ${country['deaths']}"),
                    Text("Recovered: ${country['recovered']}"),
                    Text("Active: ${country['active']}"),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}