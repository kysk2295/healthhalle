import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getXController.dart';

class CalendarScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CalendarScreenState();
  }

}

class _CalendarScreenState extends State<CalendarScreen>{

  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final controller = Get.put(BuilderController());
    return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('On Update'), 
                GetBuilder<BuilderController>(
                //init: BuilderController(),
                builder: (_) {
                return Text('count : ${_.count}');
                }
                ), 
                TextButton(onPressed: (){
                  //Get.find<BuilderController>().increment();
                  controller.increment();
                }, child: Text('Count 업!'))
              ],
            ),
          ),
    );
  }

}