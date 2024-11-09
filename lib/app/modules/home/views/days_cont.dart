import 'package:asap/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/nextday.dart';

class DaysContainer extends StatelessWidget {
  final List<Hour> hour;

  const DaysContainer(this.hour);

  @override
  Widget build(BuildContext context) {
    final ctrlH = Get.find<HomeController>();
    return Container(
      color: Colors.blue[50],
      height: 130,
      width: Get.width * .9,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: hour.length,
              itemBuilder: (context, index) {
                return Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.1),
                            blurRadius: 10,
                            offset: const Offset(0, 10),
                          )
                        ]),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: 100,
                    // height: 170,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              DateFormat("HH:mm")
                                  .format(DateTime.parse(hour[index].time)),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Image.network("https:${hour[index].condition.icon}",
                              scale: 1.5),
                          Obx(() => Text(
                              ((ctrlH.isCelsius == true)
                                  ? "${hour[index].tempC}°C"
                                  : "${hour[index].tempF}°F"),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                        ]));
              }),
        )
      ]),
    );
  }
}
