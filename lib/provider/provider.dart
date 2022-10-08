

import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import '../models/pet_model.dart';

class ProviderClass extends ChangeNotifier {

  final TextEditingController _fullnameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _phoneNumberTextController = TextEditingController();
  final TextEditingController _confirmPasswordTextController = TextEditingController();
  final TextEditingController _ageTextController = TextEditingController();
  final TextEditingController _costTextController = TextEditingController();
  final TextEditingController _isAvailableTextController = TextEditingController();
  final TextEditingController _breedTextController = TextEditingController();

  final _formkey = GlobalKey<FormState>();


  TextEditingController get fullnameTextController => _fullnameTextController;
  TextEditingController get passwordTextController => _passwordTextController;
  TextEditingController get emailTextController => _emailTextController;
  TextEditingController get phoneNumberTextController => _phoneNumberTextController;
  TextEditingController get confirmPasswordTextController => _confirmPasswordTextController;
  TextEditingController get ageTextController => _ageTextController;
  TextEditingController get costTextController => _costTextController;
  TextEditingController get isAvailableTextController => _isAvailableTextController;
  TextEditingController get breedTextController => _breedTextController;


  GlobalKey<FormState> get formkey => _formkey;


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

  String? validateConfirmPassword(String? formConfirmPassword) {
    if (confirmPasswordTextController.text != passwordTextController.text) {
      return 'Passwords do not match.';
    }

    return null;
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
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

  Future<void> postRegister() async {
    var url = Uri.parse('https://biggievet.herokuapp.com/api/user/register');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
    };
    var payload = {"name": fullnameTextController.text,
    "phoneNumber": phoneNumberTextController.text,
    "password": passwordTextController.text,
    "email": emailTextController.text
    };
    notifyListeners();
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

  Future<void> postLogin() async {
    var url = Uri.parse('https://biggievet.herokuapp.com/api/user/login');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
    };
    var payload = {
      "password": passwordTextController.text,
      "email": emailTextController.text
    };
    notifyListeners();

    try {
      postLoginResponse = await http.post(url, headers: requestHeaders, body: jsonEncode(payload));
      print('Response status: ${postLoginResponse.statusCode}');
      print('Response body: ${postLoginResponse.body}');
      notifyListeners();
      var responseData = jsonDecode(postLoginResponse.body);

      final storage =  await SharedPreferences.getInstance();
      storage.setString('token', responseData['access_token']);
      storage.setString('email', emailTextController.text);

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

  Future<void> putUpdate(String str) async {
    final storage = await SharedPreferences.getInstance();
    token = await storage.getString('token');
    notifyListeners();

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var payload = {
      "age": ageTextController.text,
       "cost": costTextController.text,
       "isAvailable": isAvailableTextController.text,
    };
    notifyListeners();

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

  Future<void> postNewPet() async {
    var url = Uri.parse('https://biggievet.herokuapp.com/api/pet/create');
    Map<String, String> requestHeaders = {
      'Accept': '*/*',
      'Authorization': 'Bearer $token'
    };

    var payload = {
      "age": ageTextController.text,
      "cost": costTextController.text,
      "isAvailable": isAvailableTextController.text,
      'breed': breedTextController.text,
      'petPicture': file,
    };
    // var map = Map<String, dynamic>();
    // map['age'] = '2 weeks';
    // map['cost'] = '\$400';
    // map['isAvailable'] = '3';
    // map['breed'] = 'test';
    // map['petPicture'] = file;
    notifyListeners();
    try {
      postNewPetResponse = await http.post(url, headers: requestHeaders, body: json.encode(payload));
      print('Response status: ${postNewPetResponse.statusCode}');
      print('Response body: ${postNewPetResponse.body}');
      notifyListeners();
      var responseData = jsonDecode(postNewPetResponse.body);
      print(responseData);
    } catch (e, s) {
      print(e);
      print(s);
    }
  }
}