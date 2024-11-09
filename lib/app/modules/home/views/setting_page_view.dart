import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class SettingPageView extends GetView {
  final ctrlH = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          centerTitle: false,
        ),
        body: SafeArea(
            child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Show Measure Units in Celcius'),
              Obx(() => Switch(
                  value: ctrlH.isCelsius.value,
                  activeColor: Colors.blue,
                  onChanged: (bool value) {
                    ctrlH.togglerCelsius();
                  }))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Show Wind Speed in Miles per Hour'),
              Obx(() => Switch(
                  activeColor: Colors.blue,
                  value: ctrlH.isMph.value,
                  onChanged: (bool value) {
                    ctrlH.togglerMph();
                  }))
            ])
          ]),
        )));
  }
}
