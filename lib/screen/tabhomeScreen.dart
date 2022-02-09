import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabHomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TabHomeScreenState();
  }

}

class _TabHomeScreenState extends State<TabHomeScreen>{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(375, 712),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);

    return Scaffold(


    );
  }

}