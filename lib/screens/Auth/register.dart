
import 'package:biggie_vet/widgets/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/provider.dart';
import '../../utils/app_colors.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text.dart';
import '../../widgets/my_text_form_field.dart';


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;

  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _fullnameTextController = TextEditingController();
  final TextEditingController _phoneNumberTextController = TextEditingController();
  final TextEditingController _confirmPasswordTextController = TextEditingController();

  String? validateConfirmPassword(String? formConfirmPassword) {
    if (_confirmPasswordTextController.text != _passwordTextController.text) {
      return 'Passwords do not match.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ProviderClass>(context);
    return Scaffold(
      backgroundColor: backGround,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 18, right: 18),
            child: Column(
              children: [
                SizedBox(height: 30,),
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back,
                        color: white,)),
                ),
                SizedBox(height: 70,),
                Align(
                  alignment: Alignment.topLeft,
                  child: MyText(
                    'Sign Up',
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: white,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),

                Form(
                  key: _formkey,
                  child: Column(
                    children:  [
                      InputField(
                        inputController: _fullnameTextController,
                        isPassword: false,
                        hintText: 'Enter Full Name',
                        hasSuffixIcon: false,
                        keyBoardType: TextInputType.text,
                        prefixIcon: const Icon(Icons.person_outline),
                        validator: validateFullName,
                      ),

                      const SizedBox(
                        height: 40,),

                      InputField(
                        inputController: _phoneNumberTextController,
                        isPassword: false,
                        hintText: 'Enter Phone Number',
                        hasSuffixIcon: false,
                        keyBoardType: TextInputType.number,
                        prefixIcon: const Icon(Icons.phone),
                        validator: validatePhoneNumber,
                      ),

                      const SizedBox(
                        height: 40,),

                      InputField(
                        inputController: _emailTextController,
                        isPassword: false,
                        hintText: 'Enter your Email',
                        hasSuffixIcon: false,
                        keyBoardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.email_outlined),
                        validator: validateEmail,
                      ),
                      SizedBox(
                        height: 40,
                      ),

                      InputField(
                        inputController: _passwordTextController,
                        isPassword: true,
                        hintText: 'Password',
                        hasSuffixIcon: true,
                        keyBoardType: TextInputType.text,
                        prefixIcon: const Icon(Icons.lock_outlined),
                        validator: validatePassword1,
                      ),
                      const SizedBox(
                        height: 40,
                      ),

                      InputField(
                        inputController: _confirmPasswordTextController,
                        isPassword: true,
                        hintText: 'Confirm Password',
                        hasSuffixIcon: true,
                        keyBoardType: TextInputType.text,
                        prefixIcon: const Icon(Icons.lock_outlined),
                        validator: validateConfirmPassword,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: MyButton(
                      height: 50,
                      color: mainred,
                      child: isLoading == false ? MyText('Sign Up',
                        color: white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ):  Center(
                        child: CircularProgressIndicator(
                          color: mainBlue,
                        ),
                      ),
                      onTap:  () async {
                        if (_formkey.currentState!.validate()){
                          isLoading = true;
                          setState(() {
                          });
                          
                          // final storage = await SharedPreferences.getInstance();
                          // await storage.setString('fullname', _fullnameTextController.text);
                          // setState(() {
                          // });


                          Duration waitTime = Duration(seconds: 4);
                          Future.delayed(waitTime, (){
                            isLoading = false;
                            setState(() {});
                          });
                          try {
                            var payload = {"name": _fullnameTextController.text,
                                            "phoneNumber": _phoneNumberTextController.text,
                                            "password": _passwordTextController.text,
                                            "email": _emailTextController.text};
                            await data.postRegister(payload)
                            .then((value)
                            {
                              Navigator.pop(context);} );
                          }catch (e, s) {
                            print(e);
                            print(s);
                          }
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}