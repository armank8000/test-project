import 'dart:convert';
import '../services/notification_services.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/api_functions.dart';
import '../models/functions.dart';
import 'home_page_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final studentIdController = TextEditingController();
  final passwordController = TextEditingController();
  final error = '';
  var _isLoading = false;

  var logoImage = '';
  bool connectionStatus = false;

  @override
  void initState() {
    internetConnectionStatus();
    super.initState();
  }

  internetConnectionStatus() async {
    final response = await checkInternetConnection();
    setState(() {
      connectionStatus = response;
    });
  }

  void login(String studentId, String password) async {
    String? deviceToken = await NotificationServices().getDeviceToken();
    setState(() {
      _isLoading = true;
    });

    try {
      final url = Uri.parse('https://erp.rvsir.com/api/students/');
      final response = await http.post(
        url,
        body: json.encode({
          'name': 'studentlogin',
          "android_ver": "v1.0",
          'param': {
            'userId': studentIdController.text.toString(),
            'password': passwordController.text.toString(),
            'deviceToken': deviceToken.toString(),
          }
        }),
        headers: {"Content-Type": "application/json"},
      );

      final serverData = json.decode(response.body);
      if (serverData['statusCode'] != 200) {
        setState(() {
          _isLoading = false;
        });
        if (mounted) {
          showMessageBox(context, message: {serverData['data']}.toString());
        }
      } else {
        await SecuredStorage(
                myKey: 'token', myValue: serverData['data']['token'])
            .saveData();
        await SecuredStorage(
                myKey: 'studentName',
                myValue: (serverData['data']['name']).toString())
            .saveData();
        await SecuredStorage(
                myKey: 'studentClass',
                myValue: (serverData['data']['class']).toString())
            .saveData();
        await SecuredStorage(
                myKey: 'studentSection',
                myValue: (serverData['data']['section']).toString())
            .saveData();
        await SecuredStorage(
                myKey: 'studentRoll',
                myValue: (serverData['data']['enrolment']).toString())
            .saveData();
        await SecuredStorage(
                myKey: 'studentPhoto',
                myValue: (serverData['data']['photo']).toString())
            .saveData();
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => const HomeMenu(),
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text(
              'Some unknown error occured. Please try again later',
              style: TextStyle(fontSize: 15),
            ),
            actions: [
              TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Text('okay'))
            ],
          ),
        );
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    studentIdController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(
                  height: 18,
                ),
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 6 / 19,
                  child: connectionStatus
                      ? FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image:
                              'https://navjyotimodelschool.com/webcontent/directors_message/rv202403191720391710849039490665f97c0f77cb5.png',
                        )
                      : Container(),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  width: MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5),
                    color: const Color.fromARGB(255, 104, 0, 31),
                  ),
                  child: Text(
                    'Nav Jyoti Model School',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 1 / 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'Student Login',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: studentIdController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value != null) {
                      if (value.length > 3 && value.length < 9) {
                      } else {
                        return 'Enter a Valid Student Id';
                      }
                    }
                    return null;
                  },
                  onTapOutside: (event) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      border: OutlineInputBorder(),
                      icon: Icon(
                        Icons.school,
                        color: Color.fromARGB(255, 104, 0, 31),
                      ),
                      label: Text('Student Id')),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onTapOutside: (event) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  controller: passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value != null) {
                      if (value.length > 5) {
                        return null;
                      }
                      return 'Enter a Valid Password';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12),
                    icon: Icon(
                      Icons.key,
                      color: Color.fromARGB(255, 104, 0, 31),
                    ),
                    label: Text('Password'),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                    onPressed: _isLoading == true
                        ? () {}
                        : () {
                            if (passwordController.text.length > 5 &&
                                studentIdController.text.length > 3 &&
                                studentIdController.text.length < 9) {
                              login(
                                studentIdController.text.toString(),
                                passwordController.text.toString(),
                              );
                            } else {
                              showMessageBox(context,
                                  message: 'Please enter valid details');
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 104, 0, 31),
                      foregroundColor: Colors.white,
                      fixedSize: const Size(120, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(),
                          )
                        : const Text(
                            'Login',
                            style: TextStyle(fontSize: 17),
                          )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
