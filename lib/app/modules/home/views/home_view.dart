import 'package:asap/app/models/nextday.dart';
import 'package:asap/app/modules/home/views/days_cont.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/home_controller.dart';
import 'setting_page_view.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final ctrlH = Get.find<HomeController>();

  String hariIni() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    return DateFormat('EEEE, dd MMMM yyyy').format(today);
  }

  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          if (ctrlH.isLoad.value == false) {
            return Text(
              // "Hahahah",
              ctrlH.location.value!.name,
              style: const TextStyle(fontSize: 30, color: Colors.black),
            );
          } else {
            return Text("Loading...");
          }
        }),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          onPressed: () {
            openDialog();
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(SettingPageView());
              },
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ))
        ],
      ),
      body: SafeArea(
        child: Container(
            width: Get.width,
            child: ListView(children: [
              Obx(() {
                if (ctrlH.isLoad.value == false) {
                  return Column(
                    children: [
                      Text("${hariIni()}", style: TextStyle(fontSize: 15)),
                      Image.network(
                          "https:${ctrlH.current.value!.condition.icon}",
                          scale: .5),
                      Text(ctrlH.current.value!.condition.text,
                          style: TextStyle(fontSize: 20)),
                      Text(
                          ((ctrlH.isCelsius == true)
                              ? "${ctrlH.current.value!.tempC}°C"
                              : "${ctrlH.current.value!.tempF}°F"),
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold)),
                      Text("Humidity: ${ctrlH.current.value!.humidity}%",
                          style: TextStyle(fontSize: 15)),
                      Text(
                          "Wind Speed ${(ctrlH.isMph == true) ? "${ctrlH.current.value!.windMph} Mp/h" : "${ctrlH.current.value!.windKph} Km/h"}",
                          style: TextStyle(fontSize: 15)),
                      Text("Wind Direction ${ctrlH.current.value!.windDir}",
                          style: TextStyle(fontSize: 15)),
                      const SizedBox(height: 30),
                      ...List.generate(
                          ctrlH.nextday.value!.forecast.forecastday.length,
                          (index) {
                        return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            color: Color(0xFFe6f4fa),
                            height: 180,
                            width: Get.width * .95,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                    DateFormat('dd-MM-yyyy').format(ctrlH
                                        .nextday
                                        .value!
                                        .forecast
                                        .forecastday[index]
                                        .date),
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                                DaysContainer(ctrlH.nextday.value!.forecast
                                    .forecastday[index].hour)
                              ],
                            ));
                      }),
                    ],
                  );
                } else {
                  return Center(child: Text("Loading..."));
                }
              }),
            ])),
      ),
    );
  }

  Future openDialog() => showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: Text("Search"),
          content: TextFormField(
            controller: ctrlH.namakota,
            decoration: InputDecoration(hintText: "Search City"),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  ctrlH.isLoad.value = true;
                  ctrlH.getWeatherSearch();
                  Get.back();
                },
                child: Text("Search")),
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Cancel"))
          ],
        );
      });
}
