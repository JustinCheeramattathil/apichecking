// ignore_for_file: unused_element

import 'dart:convert';

import 'package:apichecking/core/api_base_url.dart';
import 'package:apichecking/core/api_endpoint.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
///creating the instance of dio package for pass http request
  final dio = Dio();
///creating a string  for storing the token(response of api function) to pass to the ui
  String wholeData = '';

  @override
  void initState() {
    super.initState();

///This is the special kind of call back method to show showdialog when the page is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Fetch API'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  postdata('eve.holt@reqres.in', 'pistol');
                  Navigator.of(context).pop();
                },
                child: const Text('Fetch'),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('API Response Demo'),
        ),
        body: Center(
///update the response that we got from API calling function
          child: Text(wholeData),
        ));
  }


///This function causes the API call with provided credentials like  email and password
   Future<void> postdata(String email, String password) async {
///postData is passed in the format of Map
    final Map<String, dynamic> postData = {
      'email': email,
      'password': password,
    };
///calls the apibase url and api endurl from appropriate classes
    final String apiUrl = ApiBaseUrl().baseUrl + ApiEndUrl().apiEndpoint;
    try {
      Response response = await dio.post(apiUrl, data: postData);
      if (response.statusCode == 200) {
///update the response after calling the api before passing to ui
        setState(() {
          wholeData = jsonEncode(response.data); 
        });
      }
    } catch (e) {
      rethrow;
    }
  }
}
