import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '/product_display.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final uName = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.10,
                right: 30,
                left: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: uName,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    hintText: 'ROHAN',
                    labelText: 'USERNAME',
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ), //For Spacing
                TextField(
                  controller: password,
                  obscureText: true,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                        borderSide: BorderSide(color: Colors.red)),
                    labelText: 'PASSWORD',
                    hintText: '*****',
                    prefixIcon: Icon(
                      Icons.key,
                      color: Colors.black,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    readJson(uName.text, password.text);
                    //Get.to(() => const ProductDisplay());
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red.shade50)),
                  child: const Text(
                    'SIGN IN',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




Future<dynamic> readJson(uName, password) async {
  List users = [];
  final String response = await rootBundle.loadString('assets/cred.json');
  final data = await json.decode(response);
  users = data["users"];
  if (uName == users[0]["uname"] && password == users[0]["pass"]) {
   Get.to(const ProductDisplay());
  } else {
   print("Wrong pass");
  }
}