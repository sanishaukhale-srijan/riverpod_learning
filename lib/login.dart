import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '/product_display.dart';
import '/providers.dart';

class MyLogin extends ConsumerWidget {
  MyLogin({Key? key}) : super(key: key);
  final uName = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var loginStatusWatch = ref.watch(loginStatus);
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
                loginStatusWatch == LoginState.loading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          ref.read(loginStatus.notifier).state =
                              LoginState.loading;
                          Future.delayed(const Duration(seconds: 1), () async {
                            ref.read(loginStatus.notifier).state =
                                await readJson(uName.text, password.text);
                            ref.watch(loginStatus) == LoginState.loginSuccessful
                                ? Get.to(() => const ProductDisplay())
                                : null;
                          });
                        },
                        child: const Text("LOGIN")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum LoginState { loginInit, loginSuccessful, loginFailed, loading }

Future<LoginState> readJson(uName, password) async {
  List user = [];
  final String response = await rootBundle.loadString('assets/cred.json');
  final data = jsonDecode(response);
  user = data['users'];
  if (user[0]['uname'] == uName && user[0]['pass'] == password) {
    return LoginState.loginSuccessful;
  } else if (user[0]['uname'] != uName || user[0]['pass'] != password) {
    return LoginState.loginFailed;
  } else {
    return LoginState.loginFailed;
  }
}
