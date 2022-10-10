

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';
import '../utils/app_colors.dart';
import '../widgets/my_button.dart';
import '../widgets/my_text.dart';
import '../widgets/my_text_form_field.dart';
import 'homePage.dart';

class addNewPet extends StatefulWidget {
  const addNewPet({Key? key}) : super(key: key);

  @override
  State<addNewPet> createState() => _addNewPetState();
}

class _addNewPetState extends State<addNewPet> {

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ProviderClass>(context);
    //final fileName = data.file != null ? basename(data.file!.path) : 'No File Selected';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainBlue,
        automaticallyImplyLeading: true,
        title: const Text('Add New Pet',
          style: TextStyle(
            color: white,
          ),),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(30),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  MyButton(
                    height: 40,
                    icon: Icons.attach_file,
                    color: mainred,
                    onTap: data.selectFile,
                    child: MyText (
                      'Select Pet Image',
                      color: white,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 8),

                  MyText(
                    data.file == null ? 'No File Selected' : data.file.toString(),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: mainBlue,
                  ),
                  const SizedBox(height: 20),

                  InputField(
                    inputController: data.breedTextController,
                    isPassword: false,
                    hintText: 'Pet Breed',
                    hasSuffixIcon: false,
                    keyBoardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 20,),

                  InputField(
                    inputController: data.ageTextController,
                    isPassword: false,
                    hintText: 'Pet Age',
                    hasSuffixIcon: false,
                    keyBoardType: TextInputType.text,
                  ),
                  const SizedBox(height: 20,),

                  InputField(
                    inputController: data.costTextController,
                    isPassword: false,
                    hintText: 'Pet Price',
                    hasSuffixIcon: false,
                    keyBoardType: TextInputType.text,

                  ),
                  const SizedBox(height: 20,),

                  InputField(
                    inputController: data.isAvailableTextController,
                    isPassword: false,
                    hintText: 'Number of available Pets',
                    hasSuffixIcon: false,
                    keyBoardType: TextInputType.text,

                  ),

                  const SizedBox(height: 100,),

                  MyButton(
                      color: mainred,
                      height: 50,
                      icon: Icons.cloud_upload_outlined,
                      onTap: () async {
                        data.isLoading = true;
                        if (mounted) {
                          setState(() {});
                        }

                        Duration waitTime = const Duration(seconds: 4);
                        Future.delayed(waitTime, (){
                          data.isLoading = false;
                          if (mounted) {
                            setState(() {});
                          }
                        });

                        try{
                          await data.postNewPet()
                              .then((value) {
                            if (data.error == false) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text(
                                    'Pet has been Added'),
                                duration: Duration(seconds: 5),),);
                              data.ageTextController.clear();
                              data.costTextController.clear();
                              data.isAvailableTextController.clear();
                              data.breedTextController.clear();
                              //data.file!.clear();

                              Navigator.pop(context,);
                            }else{
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
                      },
                      child: data.isLoading == false ? MyText(
                        'Add',
                        color: white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,)
                          : const Center(
                           child: CircularProgressIndicator(
                          color: mainBlue,
                        ),
                      )
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
