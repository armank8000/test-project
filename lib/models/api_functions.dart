import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../screens/home_page_screen.dart';
import '../screens/login_screen.dart';
import 'functions.dart';

Future<bool> checkInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('erp.rvsir.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true; // Device is connected to the internet
    } else {
      return false;
    }
  } on SocketException catch (_) {
    return false; // Device is not connected to the internet
  }
}

showMessageBox(
  BuildContext ctx, {
  String message = 'An unknown error occured while processing your request',
  String messageType = 'error',
  int statusCode = 0,
  int popCount = 1,
  String redirectPage = '',
}) {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      (messageType == 'success') ? 'Success!' : 'Error!',
      style: TextStyle(
        color: (messageType == 'success')
            ? const Color.fromARGB(255, 0, 72, 68)
            : const Color.fromARGB(255, 125, 12, 4),
      ),
    ),
    content: Text(
      message.toString(),
      style: TextStyle(
        color: (messageType == 'success') ? Colors.green : Colors.red,
      ),
    ),
    actions: [
      TextButton(
        child: const Text("OK"),
        onPressed: () {
          if (redirectPage == 'login') {
            SecuredStorage(myKey: 'token').deleteData();
            SecuredStorage(myKey: 'studentName').deleteData();
            SecuredStorage(myKey: 'studentClass').deleteData();
            SecuredStorage(myKey: 'studentSection').deleteData();
            SecuredStorage(myKey: 'studentRoll').deleteData();
            SecuredStorage(myKey: 'studentPhoto').deleteData();
            Navigator.of(ctx).pushReplacement(
                MaterialPageRoute(builder: (ctx) => const LoginPage()));
          } else if (redirectPage == 'home') {
            Navigator.of(ctx).pushReplacement(
                MaterialPageRoute(builder: (ctx) => const HomeMenu()));
          } else {
            for (var i = 0; i < popCount; i++) {
              Navigator.of(ctx).pop();
            }
          }
        },
      ),
    ],
  );

  // show the dialog
  showDialog(
    context: ctx,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

sendFetchReq(BuildContext context, String name, Map data) async {
  bool connectionStatus = await checkInternetConnection();

  if (!connectionStatus) {
    if (!context.mounted) return;
    showMessageBox(
      context,
      messageType: 'error',
      message: "No internet connection",
    );
    return null;
  } else {
    final authtoken = await SecuredStorage(myKey: 'token').getData();

    if (authtoken != null) {
      var apiServer = 'https://erp.rvsir.com/api/students/';
      try {
        var response = await http.post(
          Uri.parse(apiServer),
          headers: {
            "Content-Type": "application/json; charset=utf-8",
            "Authorization": "Bearer $authtoken"
          },
          body: jsonEncode({"name": name, "param": data}),
        );
        final serverData = jsonDecode(response.body);
        if (serverData['statusCode'] == 300 ||
            serverData['statusCode'] == 301 ||
            serverData['statusCode'] == 302) {
          if (!context.mounted) return;
          showMessageBox(
            context,
            message: 'Your session has expired please login again.',
            redirectPage: 'login',
          );
          return null;
        } else if (serverData['statusCode'] == 200) {
          return serverData['data'];
        } else {
          if (!context.mounted) return;
          showMessageBox(context, message: serverData['data'], popCount: 2);
          return null;
        }
      } catch (error) {
        if (!context.mounted) return;
        showMessageBox(context, redirectPage: 'home');
        return null;
      }
    } else {
      if (context.mounted) {
        showMessageBox(
          context,
          message: 'Invalid login! Please login to continue!',
          redirectPage: 'login',
        );
      }
      return null;
    }
  }
}

sendUpdateReq(BuildContext context, String name, Map data) async {
  bool connectionStatus = await checkInternetConnection();

  if (!connectionStatus) {
    if (!context.mounted) return;
    showMessageBox(context,
        messageType: 'error',
        message: "No internet connection",
        popCount: 1,
        redirectPage: 'home');
    return null;
  } else {
    final authtoken = await SecuredStorage(myKey: 'token').getData();

    if (authtoken != null) {
      var apiServer = 'https://erp.rvsir.com/api/students/';
      try {
        var response = await http.post(
          Uri.parse(apiServer),
          headers: {
            "Content-Type": "application/json; charset=utf-8",
            "Authorization": "Bearer $authtoken"
          },
          body: jsonEncode({"name": name, "param": data}),
        );
        final serverData = jsonDecode(response.body);
        if (serverData['statusCode'] == 300 ||
            serverData['statusCode'] == 301 ||
            serverData['statusCode'] == 302) {
          if (!context.mounted) return;
          showMessageBox(
            context,
            message: 'Your session has expired please login again.',
            redirectPage: 'login',
          );
          return null;
        } else if (serverData['statusCode'] == 200) {
          if (!context.mounted) return;
          showMessageBox(context,
              message: 'your request has been submitted sucessfully',
              messageType: "success");
          return serverData['data'];
        } else if (serverData['statusCode'] == 700) {
          if (!context.mounted) return;
          showMessageBox(
            context,
            message: 'Your old password is incorrect',
          );
          return serverData['data'];
        } else {
          if (!context.mounted) return;
          showMessageBox(context, message: serverData['data'], popCount: 2);
          return null;
        }
      } catch (error) {
        if (!context.mounted) return;
        showMessageBox(context, redirectPage: 'home');
        return null;
      }
    } else {
      if (context.mounted) {
        showMessageBox(
          context,
          message: 'Invalid login! Please login to continue!',
          redirectPage: 'login',
        );
      }
      return null;
    }
  }
}
