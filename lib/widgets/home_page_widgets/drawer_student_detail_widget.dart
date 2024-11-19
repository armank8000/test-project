import 'package:flutter/material.dart';

import '../../models/functions.dart';
import '../../screens/change_password.dart';
import '../../screens/profile_screen.dart';

import '../../screens/login_screen.dart';

class DrawerStudentDetailWidget extends StatelessWidget {
  final String name1;
  final String name2;
  final String name3;
  final String name4;
  final String name5;

  const DrawerStudentDetailWidget({
    super.key,
    required this.name1,
    required this.name2,
    required this.name3,
    required this.name4,
    required this.name5,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 104, 0, 31),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      width: 10,
                      height: double.infinity,
                    ),
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: Image.network(
                        name5,
                        height: 95,
                        width: 90,
                        fit: BoxFit.fitHeight,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.person,
                            color: Colors.black,
                          );
                        },
                      ).image,
                    ),
                    // Image.network(
                    //   name5.isEmpty
                    //       ? 'https://icon-library.com/images/no-profile-picture-icon/no-profile-picture-icon-27.jpg'
                    //       : name5,
                    //   width: 72,
                    // ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name1,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Class: $name2 - $name3',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Roll No: $name4',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const ProfileScreen()));
              },
            ),
            ListTile(
              title: const Text(
                'Change Password',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const ChangePasswordScreen()));
              },
            ),
            const Divider(
              height: 12,
            ),
            ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: Color.fromARGB(255, 11, 11, 11),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () async {
                await SecuredStorage(myKey: 'token').deleteData();
                await SecuredStorage(myKey: 'studentName').deleteData();
                await SecuredStorage(myKey: 'studentClass').deleteData();
                await SecuredStorage(myKey: 'studentSection').deleteData();
                await SecuredStorage(myKey: 'studentRoll').deleteData();
                await SecuredStorage(myKey: 'studentPhoto').deleteData();
                if (!context.mounted) return;
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => const LoginPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
