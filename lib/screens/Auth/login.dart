


import 'package:biggie_vet/screens/Auth/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../provider/provider.dart';
import '../../utils/app_colors.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text.dart';
import '../../widgets/my_text_form_field.dart';
import '../../widgets/validator.dart';
import '../homePage.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ProviderClass>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black26,
      body:  SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 18, right: 18,),
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: MyText('Log In',
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),

                Form(
                  key: data.formkey,
                  child: Column(
                    children: [
                      const SizedBox(height: 40,),

                      InputField(
                        inputController: data.emailTextController,
                        isPassword: false,
                        hintText: 'Email Address',
                        hasSuffixIcon: false,
                        keyBoardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.person_outline),
                        validator: validateEmail,),

                      SizedBox(height: 40,),

                      InputField(
                        inputController: data.passwordTextController,
                        isPassword: true,
                        hintText: 'Password',
                        hasSuffixIcon: true,
                        keyBoardType: TextInputType.text,
                        prefixIcon: const Icon(Icons.lock_outlined),
                        validator: validatePassword,
                      ),

                      SizedBox(height: 150,),

                      MyButton(
                        height: 50,
                        color: mainred,
                        onTap: () async {
                          if (data.formkey.currentState!.validate()) {
                            data.isLoading = true;

                            setState(() {});
                            Duration waitTime = Duration(seconds: 4);
                            Future.delayed(waitTime, (){
                              if (mounted) {
                                data.isLoading = false;
                              }
                              setState(() {});
                            });

                            try {
                              await data.postLogin()
                                  .then((value) {
                                    if (data.postLoginResponse.statusCode == 200){
                                      data.passwordTextController.clear();
                                      data.emailTextController.clear();

                                    Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => HomePage()));
                                    }else {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                        content: Text(
                                            'There is an error'),
                                        duration: Duration(seconds: 5),),);
                                    }
                                  });
                              }catch(e,s){
                              print(e);
                              print(s);
                            }
                          }
                        },
                        child: data.isLoading == false ? MyText(
                          'Log In',
                          color: white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,)
                            : const Center(
                              child: CircularProgressIndicator(
                                color: mainBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText('Don\'t have an Account ? ',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: white),

                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const Register()));
                        },
                        child: MyText('Sign Up',
                          color: mainBlue,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}