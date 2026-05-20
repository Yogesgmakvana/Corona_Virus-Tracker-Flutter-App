import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class CountryScreen extends StatefulWidget {
  CountryScreen({
    super.key,
    required this.cases,
    required this.deaths,
    required this.recovered,
    required this.active,
    required this.country_name,
  });
  int cases;
  int deaths;
  int recovered;
  int active;
  String country_name;

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  
  

  late Map<String, double> names;
  
  late int deathss;

  final List<Color> colorList = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
  ];

  @override
  void initState() {
    names = {
      "Total Cases": widget.cases.toDouble(),
      "Deaths": widget.deaths.toDouble(),
      "Recovered": widget.recovered.toDouble(),
      "Active": widget.active.toDouble(),
    };

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.country_name),
        backgroundColor: Color(0xffFECEE9),
      ),
      // backgroundColor: Color(0xffFECEE9),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PieChart(
                legendOptions: const LegendOptions(
                  legendPosition: LegendPosition.bottom,
                ),

                chartValuesOptions: const ChartValuesOptions(
                  showChartValuesInPercentage: true,
                ),
                dataMap: names,
                chartType: ChartType.ring,
                colorList: colorList,
                centerText: "COVID",
                chartRadius: 250,
              ),
            ),
            //show data
            Card(
              elevation: 5,
              child: Container(
                height: height * 0.210,
                width: width * 0.780,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 79, 131, 174),
                ),
                child: Column(
                  children: [
                    Text("Tottal Cases: ${widget.cases.toString()}",style: TextStyle(
                      color: Colors.white,
                      fontSize: height / 45,
                    ),),
                     Divider(),
                    Text("Tottal Active: ${widget.active.toString()}",style: TextStyle(
                      color: Colors.white,
                      fontSize: height / 45,
                    ),),
                     Divider(),
                    Text("Deaths: ${widget.deaths.toString()}",style: TextStyle(
                      color: Colors.white,
                      fontSize: height / 45,
                    ),),
                    Divider(),
                    Text("Recovered: ${widget.recovered.toString()}",style: TextStyle(
                      color: Colors.white,
                      fontSize: height / 45,
                    ),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
