

import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import '../models/pet_model.dart';

class ProviderClass extends ChangeNotifier {
  String? token;
  String? userEmail;
  var postRegisterResponse;
  var postLoginResponse;
  var getResponse;
  bool availablePets = false;
  var putResponse;
  var putOrderResponse;
  var postNewPetResponse;


  File? file;
  String? urlDownload;
  bool isLoading = false;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    isLoading = true;
    final path = result.files.single.path!;
    file = File(path);
    notifyListeners();
  }

  Future<void>sharedPreferences() async {
    final storage = await SharedPreferences.getInstance();
    token = await storage.getString('token');
    userEmail = await storage.getString('email');
    notifyListeners();
  }

  Future<void> postRegister(Map<String, dynamic> payload) async {
    var url = Uri.parse('https://biggievet.herokuapp.com/api/user/register');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
    };
    try {
       postRegisterResponse = await http.post(url, headers: requestHeaders, body: jsonEncode(payload));
      print('Response status: ${postRegisterResponse.statusCode}');
      print('Response body: ${postRegisterResponse.body}');
      notifyListeners();
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> postLogin(Map<String, dynamic> payload, String email) async {
    var url = Uri.parse('https://biggievet.herokuapp.com/api/user/login');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
    };
    try {
      postLoginResponse = await http.post(url, headers: requestHeaders, body: jsonEncode(payload));
      print('Response status: ${postLoginResponse.statusCode}');
      print('Response body: ${postLoginResponse.body}');
      notifyListeners();
      var responseData = jsonDecode(postLoginResponse.body);

      final storage =  await SharedPreferences.getInstance();
      storage.setString('token', responseData['access_token']);
      storage.setString('email', email);

      print(responseData);
     notifyListeners();
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  //run shared preference before any app that needs token
  Future<pet_model> get() async {
    final storage = await SharedPreferences.getInstance();
    token = await storage.getString('token');
    notifyListeners();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $token'
    };
    var url =Uri.parse('https://biggievet.herokuapp.com/api/user/pets');
    getResponse = await http.get(url, headers: requestHeaders);
    print('Response status: ${getResponse.statusCode}');
    print(jsonDecode(getResponse.body));

    var responsedata = getCLassModelFromJson(getResponse.body);
    print(responsedata.data!);
    notifyListeners();
    return responsedata;

  }

  Future<void> delete(String str) async {
    final storage = await SharedPreferences.getInstance();
    token = await storage.getString('token');
    notifyListeners();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $token'
    };
    var url = Uri.parse('https://biggievet.herokuapp.com/api/pet/delete/' + str );
    var response = await http.delete(url, headers: requestHeaders);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

  }

  Future<void> putUpdate(Map<String, dynamic> payload, String str) async {
    final storage = await SharedPreferences.getInstance();
    token = await storage.getString('token');
    notifyListeners();

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var url = Uri.parse('https://biggievet.herokuapp.com/api/pet/update/' + str);

    try {
      putResponse = await http.put(url, headers: requestHeaders, body: json.encode(payload));
      print(url);
      print('Response status: ${putResponse.statusCode}');
       notifyListeners();

    }catch(e,s)
    {
      print(e);
      print(s);
    }
  }

  Future<void> putMakeOrder(String str) async {
    final storage = await SharedPreferences.getInstance();
    token = await storage.getString('token');
    notifyListeners();

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $token'
    };

    var url = Uri.parse('https://biggievet.herokuapp.com/api/user/order/' + str);

    try {
      putOrderResponse = await http.put(url, headers: requestHeaders,);
      print(url);
      print('Response status: ${putOrderResponse.statusCode}');
      notifyListeners();
    }catch(e,s)
    {
      print(e);
      print(s);
    }


  }

  Future<void> postNewPet(Map<String, dynamic> payload,) async {
    var url = Uri.parse('https://biggievet.herokuapp.com/api/pet/create');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $token'
    };
    try {
      postNewPetResponse = await http.post(url, headers: requestHeaders, body: jsonEncode(payload));
      print('Response status: ${postNewPetResponse.statusCode}');
      print('Response body: ${postNewPetResponse.body}');
      notifyListeners();
      var responseData = jsonDecode(postNewPetResponse.body);

      print(responseData);
      notifyListeners();
    } catch (e, s) {
      print(e);
      print(s);
    }
  }
}