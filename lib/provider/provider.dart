

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
  var responsedata;


  bool _error = false;
  String _errorMessage = '';

  bool get error => _error;
  String get errorMessage => _errorMessage;


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
    try {
       postRegisterResponse = await http.post(url, headers: requestHeaders, body: jsonEncode(payload));
      print('Response status: ${postRegisterResponse.statusCode}');
      print('Response body: ${postRegisterResponse.body}');
    } catch (e, s) {
      print(e);
      print(s);
    }
    notifyListeners();
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


    if (getResponse.statusCode == 200){
      try{
        responsedata = getCLassModelFromJson(getResponse.body);
        print(responsedata.data!);
        _error = false;
      } catch(e){
        _error = true;
        _errorMessage = e.toString();

      }
    }else{
      _error = true;
      _errorMessage = 'It could be your Internet Connection';

    }
    notifyListeners();
    return responsedata;
  }

  void initialValues() {
    _error = false;
    _errorMessage = '';
    responsedata = {};
    notifyListeners();
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

    var headers = {
      'Authorization': 'Bearer $token',
      //'Cookie': 'access_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzM2MxZDgzYzVkNDk5YjdmMDQyMDE4ZSIsImlhdCI6MTY2NTQwMjc3MCwiZXhwIjoxNjY1NDA2MzcwfQ.SemHi6DFjF5pwajO9fdfteLRX_SgxDZYDICIVk3dUxk'
    };
    postNewPetResponse = http.MultipartRequest('POST', Uri.parse('https://biggievet.herokuapp.com/api/pet/create'));
    postNewPetResponse.fields.addAll({
      'age': ageTextController.text,
      'isAvailable': isAvailableTextController.text,
      'cost': costTextController.text,
      'breed': breedTextController.text,
    });
    postNewPetResponse.files.add(await http.MultipartFile.fromPath('petPicture',file!.path));
    postNewPetResponse.headers.addAll(headers);

    try {
      http.StreamedResponse response = await postNewPetResponse.send();
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        error == false;
      }
      else {
        print(response.reasonPhrase);
      }
    }catch(e){
      print(e);
    }

    // var mapData = {
    //   "age": ageTextController.text,
    //   "cost": costTextController.text,
    //   "isAvailable": isAvailableTextController.text,
    //   'breed': breedTextController.text,
    // };

    // FormData data = FormData.fromMap(mapData);
    // data.files.add(
    //   MapEntry(
    //       'petPicture',
    //     MultipartFile.fromFileSync(imageFile.path,
    //       filename: imageFile.path.split('/').last
    //     )
    //   ),
    // );


    // try {
    //   postNewPetResponse = await http.post(url, headers: requestHeaders, body: json.encode(mapData));
    //   print('Response status: ${postNewPetResponse.statusCode}');
    //   print('Response body: ${postNewPetResponse.body}');
    //   notifyListeners();
    //   var responseData = jsonDecode(postNewPetResponse.body);
    //   print(responseData);
    // } catch (e, s) {
    //   print(e);
    //   print(s);
    // }
  }
}