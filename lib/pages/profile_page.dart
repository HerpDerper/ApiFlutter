import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/url.dart';
import '../models/user.dart';
import '../screens/signIn_screen.dart';
import '../interceptors/custom_interceptor.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  SharedPreferences? sharedPreferences;
  Dio DIO = Dio();

  Future<void> initSharedPreferences() async => sharedPreferences = await SharedPreferences.getInstance();

  void clearSharedPreferences() async => await sharedPreferences!.clear();

  String getTokenSharedPreferences() {
    return sharedPreferences!.getString('token')!;
  }

  Future<void> updateProfile() async {
    String updateStatus = "Успешное обновление";
    try {
      String userName = controllerUsername.text;
      String email = controllerEmail.text;

      await DIO.post(URL.user.value, data: User(userName: userName, email: email));
    } on DioError {
      updateStatus = "Данный логин уже занят";
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(updateStatus, textAlign: TextAlign.center)));
  }

  @override
  void initState() {
    super.initState();
    initSharedPreferences().then((value) async {
      String token = getTokenSharedPreferences();
      DIO.options.headers['Authorization'] = "Bearer $token";
      DIO.interceptors.add(CustomInterceptor());
      Response response = await DIO.get(URL.user.value);
      controllerEmail.text = response.data['data']['email'];
      controllerUsername.text = response.data['data']['userName'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 15, 25, 10),
            child: Center(
              child: Form(
                key: key,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controllerUsername,
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return "Логин не должен быть пустым";
                        }
                        if (value.length < 8 || value.length >= 16) {
                          return "Логин должен быть от 8 до 16 символов";
                        }
                        return null;
                      }),
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: "Логин",
                      ),
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(25, 5, 25, 20)),
                    TextFormField(
                      controller: controllerEmail,
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return "Email не должен быть пустым";
                        }
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return "Email введен неправильно";
                        }
                        return null;
                      }),
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: "Email",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 5, 25, 10),
            child: Center(
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 63, 57, 102),
                    ),
                    onPressed: () async {
                      updateProfile();
                    },
                    child: const Text("Изменить"),
                  ),
                  const Padding(padding: EdgeInsets.fromLTRB(25, 5, 25, 5)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 63, 57, 102),
                    ),
                    onPressed: () {
                      clearSharedPreferences();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
                    },
                    child: const Text("Выйти"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
