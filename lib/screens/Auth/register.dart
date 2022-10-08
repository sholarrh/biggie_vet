
import 'package:biggie_vet/widgets/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                const SizedBox(height: 30,),
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back,
                        color: white,)),
                ),

                const SizedBox(height: 70,),

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
                  key: data.formkey,
                  child: Column(
                    children:  [
                      InputField(
                        inputController: data.fullnameTextController,
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
                        inputController: data.phoneNumberTextController,
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
                        inputController: data.emailTextController,
                        isPassword: false,
                        hintText: 'Enter your Email',
                        hasSuffixIcon: false,
                        keyBoardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.email_outlined),
                        validator: validateEmail,
                      ),

                      const SizedBox(
                        height: 40,
                      ),

                      InputField(
                        inputController: data.passwordTextController,
                        isPassword: true,
                        hintText: 'Password',
                        hasSuffixIcon: true,
                        keyBoardType: TextInputType.text,
                        prefixIcon: const Icon(Icons.lock_outlined),
                        validator: validatePassword,
                      ),
                      const SizedBox(
                        height: 40,
                      ),

                      InputField(
                        inputController: data.confirmPasswordTextController,
                        isPassword: true,
                        hintText: 'Confirm Password',
                        hasSuffixIcon: true,
                        keyBoardType: TextInputType.text,
                        prefixIcon: const Icon(Icons.lock_outlined),
                        validator: data.validateConfirmPassword,
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
                      child: data.isLoading == false ? MyText('Sign Up',
                        color: white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ):
                      const Center(
                        child: CircularProgressIndicator(
                          color: mainBlue,
                        ),
                      ),
                      onTap:  () async {
                        if (data.formkey.currentState!.validate()){
                          data.isLoading = true;
                          setState(() {
                          });

                          Duration waitTime = const Duration(seconds: 4);
                          Future.delayed(waitTime, (){
                            if (mounted) {
                              data.isLoading = false;
                            }
                            setState(() {});
                          });

                          try {
                            await data.postRegister()
                            .then((value)
                            {
                              if (data.postRegisterResponse.statusCode == 200
                                  || data.postRegisterResponse.statusCode == 201
                              ){
                                data.fullnameTextController.clear();
                                data.phoneNumberTextController.clear();
                                data.passwordTextController.clear();
                                data.emailTextController.clear();

                                Navigator.pop(context);
                              }else {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text(
                                      'There is an error'),
                                  duration: Duration(seconds: 5),),);
                              }
                            }
                            );
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