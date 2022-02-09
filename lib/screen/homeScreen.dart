import 'dart:convert';

import 'package:ex0128/screen/calendarScreen.dart';
import 'package:ex0128/screen/loginScreen.dart';
import 'package:ex0128/screen/searchScreen.dart';
import 'package:ex0128/screen/tabhomeScreen.dart';
import 'package:ex0128/screen/thirdTabScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeScreenState();
  }

}

class _HomeScreenState extends State<HomeScreen>{

  int _selectedIndex=0;
  List pages=[
    TabHomeScreen(),
    CalendarScreen(),
    ThirdTabScreen(),
    SearchScreen()
  ];

  //FutureBuilder을 쓸때 build함수 내에서 쓰면 여러번 호출 된다.
  //이 경우에 한번만 호출하고 싶으면 build함수 밖에서 future를 처리해줘야 한다.
  //그래서 변수를 만들어주고 inistate함수에서 이를 초기화시켜준다.
  late Future<String> data;

  List<BottomNavigationBarItem> bottomItems=[
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
    BottomNavigationBarItem(icon: Icon(Icons.calendar_today_rounded), label: 'calendar'),
    BottomNavigationBarItem(icon: Icon(Icons.message), label: 'third'),
    BottomNavigationBarItem(icon: Icon(Icons.search),label: 'search'),

  ];


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: FutureBuilder(
          future: data,
          builder: (context,snapshot) {

            //print(snapshot.hasData.toString());
            if (snapshot.data.toString()!='success') {
              print(snapshot.data.toString()+"asdfasdf");
              return LoginScreen();
            }

            return Scaffold(
              body: pages[_selectedIndex],
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
//        backgroundColor: Colors.white,
                selectedItemColor: Colors.black,
                unselectedItemColor: Color(0xffCCCCCC),
                currentIndex: _selectedIndex,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                onTap: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                items: bottomItems,
              ),
            );
          }
      )
    );
  }

  @override
  void initState() {
    data=_autoLogin();
  }
}

Future<String> _autoLogin() async{

  var flag='fail';

  final prefs = await SharedPreferences.getInstance();
  if(prefs.getStringList('info')!.isNotEmpty){
    var res = await http.post(
      Uri.parse('http://192.168.45.52:3000/login'),
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
      print('로그인 성공2');
      flag='success';
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