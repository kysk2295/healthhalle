import 'dart:convert';

import 'package:ex0128/screen/loginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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

        body:
      Center(
        child: ElevatedButton(
          child: Text('로그아웃'),
          onPressed: (){
            _logout();
            //Get.off(LoginScreen());
          },
        ),
      ),
    );
  }

}

Future<String> _logout() async{

  var flag='fail';
  final prefs = await SharedPreferences.getInstance();
  print(prefs.getStringList('info')![0]);
  if(prefs.getStringList('info')!.isNotEmpty){
    var res = await http.post(
      Uri.parse('http://192.168.45.52:3000/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email':prefs.getStringList('info')![0],
        'password':prefs.getStringList('info')![1],
      }),
    ).catchError((error){
      print(error);
      flag='fail';
    });

    if(res.statusCode==302){
      print('로그아웃 성공');
      flag='success';
      //sharedpreference 지워주기
      prefs.remove('info');
      Get.off(LoginScreen());
    }
    else {
      print('로그인 실패');
      flag='fail';

    }
  }
  else {
    print('로그인 실패2');
    flag='fail';
  }

  return flag;
}