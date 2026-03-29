import 'package:covid_19_tracker/controller/covid_controller.dart';
import 'package:covid_19_tracker/controller/internet_controller.dart';
import 'package:covid_19_tracker/screens/countryList_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';

class CovidPage extends StatelessWidget {

  final CovidController controller = Get.put(CovidController());
  final InternetController internetController = Get.put(InternetController());

  CovidPage({super.key});

  Widget rowData(String title, dynamic value, double fontSize) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: fontSize * 0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: fontSize)),
          Text(
            value.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }

  final List<Color> colorList = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
  ];

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // Responsive scaling
    final baseFont = width * 0.04;
    final chartRadius = width * 0.45;
    final buttonHeight = height * 0.08;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Covid Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),

      body: Obx(() {

        Widget internetBanner = !internetController.hasInternet.value
            ? Container(
                width: double.infinity,
                color: Colors.red,
                padding: EdgeInsets.all(width * 0.03),
                child: Text(
                  "No Internet ❌",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: baseFont,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            : const SizedBox();

        if (controller.isLoading.value) {
          return Column(
            children: [
              internetBanner,
              const Expanded(
                child: Center(child: CircularProgressIndicator()),
              ),
            ],
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {

            // Tablet layout
            bool isTablet = constraints.maxWidth > 600;

            return Column(
              children: [

                internetBanner,

                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: Column(
                        children: [

                          SizedBox(height: height * 0.03),

                          // 📊 Chart
                          PieChart(
                            dataMap: controller.dataMap,
                            chartType: ChartType.ring,
                            colorList: colorList,
                            centerText: "COVID",
                            chartRadius: chartRadius,
                          ),

                          SizedBox(height: height * 0.04),

                          // 📋 Data Section
                          isTablet
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          rowData("Total Cases", controller.covidData["cases"], baseFont),
                                          const Divider(),
                                          rowData("Deaths", controller.covidData["deaths"], baseFont),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          rowData("Recovered", controller.covidData["recovered"], baseFont),
                                          const Divider(),
                                          rowData("Active", controller.covidData["active"], baseFont),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    rowData("Total Cases", controller.covidData["cases"], baseFont),
                                    const Divider(),
                                    rowData("Deaths", controller.covidData["deaths"], baseFont),
                                    const Divider(),
                                    rowData("Recovered", controller.covidData["recovered"], baseFont),
                                    const Divider(),
                                    rowData("Active", controller.covidData["active"], baseFont),
                                  ],
                                ),

                          SizedBox(height: height * 0.04),

                          // 🔘 Button
                          InkWell(
                            onTap: () {
                              Get.to(() => CountryListScreen());
                            },
                            child: Container(
                              height: buttonHeight,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(width: 2),
                              ),
                              child: Center(
                                child: Text(
                                  "Track Country Wise",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: baseFont * 1.2,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: height * 0.03),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}