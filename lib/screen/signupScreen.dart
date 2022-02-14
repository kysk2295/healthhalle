import 'dart:convert';

import 'package:ex0128/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignupScreenState();
  }
}

class _SignupScreenState extends State<SignupScreen>{

  final _nameEditController = TextEditingController();
  final _idTextEditController = TextEditingController();
  final _passwordEditController = TextEditingController();
  final _rePasswordTextEditController = TextEditingController();
  var _flag=false;

  @override
  Widget build(BuildContext context) {

    setState(() {
      if(_nameEditController.text.isNotEmpty && _idTextEditController.text.isNotEmpty && _passwordEditController.text.isNotEmpty && _rePasswordTextEditController.text.isNotEmpty){
        if(_idTextEditController.text.toString().trim().length>=6 && _passwordEditController.text.toString().trim() == _rePasswordTextEditController.text.toString().trim() ) {
          _flag=true;
        }
        else {
          _flag=false;
        }
      }
      else {
        _flag=false;
      }
    });

    var _nameTextField = TextField(
      decoration: InputDecoration(
          hintText: 'Nick Name'
      ),
      controller: _nameEditController,
      style: TextStyle( fontSize: 16),
      onChanged: (text){
        setState(() {

        });
      },
    );

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

    var _rePasswordTextField = TextField(
      decoration: InputDecoration(
          hintText: 'Re Password'
      ),
      obscureText: true,
      controller: _rePasswordTextEditController,
      style: TextStyle( fontSize: 16),
      onChanged: (text){
        //위젯 업데이트
        setState(() {

        });
      },
    );

    var _signupButton = CupertinoButton(
        child: Text("회원가입", style: TextStyle( fontSize: 16)),
        color: _flag?Color(0xffFF665A):Color(0xffcccccc),
        borderRadius: BorderRadius.circular(10),
        onPressed: _flag ? (){
          setState(() {
            if(_nameEditController.text.isNotEmpty && _idTextEditController.text.isNotEmpty && _passwordEditController.text.isNotEmpty && _rePasswordTextEditController.text.isNotEmpty){
              if(_idTextEditController.text.toString().trim().length>=6 && _passwordEditController.text.toString().trim() == _rePasswordTextEditController.text.toString().trim() ){
                User user = User(name:_nameEditController.text.toString().trim(),email:
                    _idTextEditController.text.toString().trim(),password: _passwordEditController.text.toString().trim());

                createUser(user);
                //뒤로 가기
                Get.back();
                //Navigator.pop(context);
                print("hi");
              }
            }
          });
        }:null

    );
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
          Padding(padding: EdgeInsets.symmetric(horizontal: 30.w), child: _nameTextField),
          SizedBox(height: 10.h,),
          Padding(padding: EdgeInsets.symmetric(horizontal: 30.w), child: _idTextField),
          SizedBox(height: 10.h,),
          Padding(padding: EdgeInsets.symmetric(horizontal: 30.w), child: _passwordTextField),
          SizedBox(height: 10.h,),
          Padding(padding: EdgeInsets.symmetric(horizontal: 30.w), child: _rePasswordTextField),
          SizedBox(height: 40.h,),
          Padding(padding: EdgeInsets.symmetric(horizontal: 30.w), child: _signupButton),


        ],
      ),
    );

  }

  @override
  void dispose() {
    _nameEditController.dispose();
    _passwordEditController.dispose();
    _idTextEditController.dispose();
    _rePasswordTextEditController.dispose();
  }
}

Future createUser(User _user) async {
  var res = await http.post(
    Uri.parse('http://192.168.45.52:3000/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': _user.name,
      'email':_user.email,
      'password':_user.password,
    }),
  );

  if(res.statusCode !=201) {
    print("fail to connect server");
  }

  else {
    print("회원가입 success");
    Get.snackbar('회원가입', '회원가입이 성공적으로 완료되었습니다!');
  }


  print(res.body);
}



