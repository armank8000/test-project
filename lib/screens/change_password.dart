// DART PACKAGES
// FLUTTER PACKAGES
import 'package:erp_student_app/models/api_functions.dart';
import 'package:flutter/material.dart';
// CUSTOM PACKAGES

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmNewPassword = TextEditingController();

  final error = '';
  var _isLoading = false;
  var _isVissible = false;
  var _isVissible2 = false;
  var _isVissible3 = false;

  void _changePassword(String oldPassword, String newPassword) async {
    if (newPassword != confirmNewPassword.text || newPassword == oldPassword) {
      showMessageBox(
        context,
        message: 'Kindly check you password ',
      );
    } else {
      await sendUpdateReq(
        context,
        'changeMyPassword',
        {
          "old_password": oldPassword.toString(),
          'password': newPassword.toString()
        },
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    oldPassword.dispose();
    newPassword.dispose();
    confirmNewPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          child: Form(
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 18),
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(border: Border.all()),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(bottom: 0),
                        child: const Text(
                          'Password Instructions:',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const Divider(),
                      const SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '* Minimum 8 charecters required',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                // fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              '* Must contain at least 1 upper case',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                // fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              '* Must contain at least 1 lowercase',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                // fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              '* Must contain at least 1 number',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                // fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              '* Must contain at least  1 special\n   character from the following\n   ( !  @  #  * _ . )',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                // fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  controller: oldPassword,
                  enableInteractiveSelection: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value != null) {
                      if (value.length > 3) {
                      } else {
                        return 'Enter a Valid Password';
                      }
                    }
                    return null;
                  },
                  obscureText: _isVissible ? false : true,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: _isVissible
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.remove_red_eye),
                        onPressed: () {
                          setState(() {
                            _isVissible = !_isVissible;
                          });
                        },
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 18),
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(
                        Icons.key,
                        color: Color.fromARGB(255, 104, 0, 31),
                      ),
                      label: const Text('Input old password')),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: newPassword,
                  enableInteractiveSelection: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value != null) {
                      if (value.length > 7 &&
                          value.contains(RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#*_.]).{8,}$'))) {
                        return null;
                      }
                      return 'Enter a Valid Password';
                    }
                    return null;
                  },
                  obscureText: _isVissible2 ? false : true,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: _isVissible2
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.remove_red_eye),
                      onPressed: () {
                        setState(() {
                          _isVissible2 = !_isVissible2;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 18),
                    prefixIcon: const Icon(
                      Icons.key,
                      color: Color.fromARGB(255, 104, 0, 31),
                    ),
                    label: const Text('Input new Password'),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  enableInteractiveSelection: false,
                  controller: confirmNewPassword,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value != null) {
                      if (value.length > 5 &&
                          newPassword.text == confirmNewPassword.text) {
                        return null;
                      } else {
                        return 'Enter a Valid Password';
                      }
                    }
                    return null;
                  },
                  obscureText: _isVissible3 ? false : true,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: _isVissible3
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.remove_red_eye),
                      onPressed: () {
                        setState(() {
                          _isVissible3 = !_isVissible3;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 18),
                    prefixIcon: const Icon(
                      Icons.key,
                      color: Color.fromARGB(255, 104, 0, 31),
                    ),
                    label: const Text(
                      'Confirm Password',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 11,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: _isLoading == true
                          ? () {}
                          : () {
                              setState(() {
                                _isLoading = true;
                              });
                              _changePassword(
                                oldPassword.text.toString(),
                                newPassword.text.toString(),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 104, 0, 31),
                        foregroundColor: Colors.white,
                        fixedSize: const Size(double.infinity, 58),
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
                              'Change Password',
                              style: TextStyle(fontSize: 17),
                            )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
