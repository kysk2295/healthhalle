import 'dart:convert';

import 'package:ex0128/mainPage.dart';
import 'package:ex0128/model/user.dart';
import 'package:ex0128/screen/homeScreen.dart';
import 'package:ex0128/screen/signupScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget{


  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen>{

  final _idTextEditController = TextEditingController();
  final _passwordEditController = TextEditingController();

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {

    var _idTextField = TextField(
      decoration: InputDecoration(
        hintText: 'Email'
      ),
      controller: _idTextEditController,
      style: TextStyle( fontSize: 16),
      onChanged: (text){
        setState(() {

        });
      },
    );

    var _passwordTextField = TextField(
      decoration: InputDecoration(
          hintText: 'Password'
      ),
      obscureText: true,
      controller: _passwordEditController,
      style: TextStyle( fontSize: 16),

      onChanged: (text){
        //위젯 업데이트
        setState(() {

        });
      },
    );

    var _loginButton = SizedBox(
      child: CupertinoButton(
          child: Text("로그인", style: TextStyle( fontSize: 17)),
          color: Color(0xffFF665A),
          borderRadius: BorderRadius.circular(10),
          onPressed: (){

            if(_idTextEditController.text.isNotEmpty && _passwordEditController.text.isNotEmpty)
              {
                loginUser(_idTextEditController.text,_passwordEditController.text);
              }
          }

      ),
    );


    var _signupButton = CupertinoButton(
        child: Text("회원가입", style: TextStyle( fontSize: 16)),
        color: Color(0xffFF665A),
        borderRadius: BorderRadius.circular(10),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
        }

    );

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 80.h,),
          Image.asset('images/logo.png',width: 145.w,height: 145.h, ),
          Center(
            child: Text(
              "운동할래",
              style: TextStyle(
                color: Color(0xffff665a),
                fontSize: 50.sp,
              ),
            ),
          ),
          SizedBox(height: 40.h,),
          Padding(padding: EdgeInsets.symmetric(horizontal: 30.w), child: _idTextField),
          SizedBox(height: 10.h,),
          Padding(padding: EdgeInsets.symmetric(horizontal: 30.w), child: _passwordTextField),
          SizedBox(height: 40.h,),

          Padding(padding: EdgeInsets.symmetric(horizontal: 30.w), child: _loginButton),
          SizedBox(height: 10.h,),
          Padding(padding: EdgeInsets.symmetric(horizontal: 30.w), child: _signupButton),


        ],
      ),
    );

    // return ScreenUtilInit(
    //   //피그마 ui 크기 설정
    //   designSize: Size(375,812),
    //   minTextAdapt: true,
    //   splitScreenMode: true,
    //
    //   builder: () => MaterialApp(
    //       builder: (context,widget){
    //         ScreenUtil.setContext(context);
    //         return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
    //             child: widget!);
    //       },
    //       home:Scaffold(
    //         body: Column(
    //           crossAxisAlignment: CrossAxisAlignment.stretch,
    //           children: [
    //             SizedBox(height: 80.h,),
    //             Image.asset('images/logo.png',width: 145.w,height: 145.h, ),
    //             Center(
    //               child: Text(
    //                 "운동할래",
    //                 style: TextStyle(
    //                   color: Color(0xffff665a),
    //                   fontSize: 50.sp,
    //                 ),
    //               ),
    //             ),
    //             SizedBox(height: 40.h,),
    //             Padding(padding: EdgeInsets.symmetric(horizontal: 30.w), child: _idTextField),
    //             SizedBox(height: 20.h,),
    //             Padding(padding: EdgeInsets.symmetric(horizontal: 30.w), child: _passwordTextField),
    //             SizedBox(height: 40.h,),
    //
    //             Padding(padding: EdgeInsets.symmetric(horizontal: 30.w), child: _loginButton),
    //             SizedBox(height: 10.h,),
    //             Padding(padding: EdgeInsets.symmetric(horizontal: 30.w), child: _signupButton),
    //
    //
    //           ],
    //         ),
    //       )
    //   ),
    // );
  }

  @override
  void dispose() {
    _idTextEditController.dispose();
    _passwordEditController.dispose();
    super.dispose();
  }

  Future loginUser(String id, String password) async{

    var res = await http.post(
      Uri.parse('http://192.168.45.52:3000/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email':id,
        'password':password,
      }),
    );

    if(res.statusCode==302){
      print(res.statusCode);
      print(res.body);
      print("로그인 성공");
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen()));

      // shared preferences 얻기
      final prefs = await SharedPreferences.getInstance();
      var array=[id,password];
      // 값 저장하기
      prefs.setStringList('info',array);

    }

    else {
      print('로그인 실패');
      throw Exception('로그인 실패');

    }
  }
}


