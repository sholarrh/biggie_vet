

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';
import '../utils/app_colors.dart';
import '../widgets/my_button.dart';
import '../widgets/my_text.dart';
import '../widgets/my_text_form_field.dart';
import 'homePage.dart';

class PetDetail extends StatefulWidget {

  String sId;
  String breed;
  String age;
  int isAvailable;
  String petPicture;
  String cost;

  PetDetail(
      this.sId,
      this.breed,
      this.age,
      this.isAvailable,
      this.petPicture,
      this.cost,
      );

  @override
  State<PetDetail> createState() => _PetDetailState();
}

class _PetDetailState extends State<PetDetail> {

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ProviderClass>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: mainBlue,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 1,
              ),

              MyText(widget.breed,
                color: white,
                fontSize: 27,
                fontWeight: FontWeight.w600,
              ),

              InkWell(
                child: PopupMenuButton(
                  color: white,
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: AlertDialog(
                        title: MyText(
                          'Delete ?',
                          color: mainred,
                          fontSize: 20,
                        ),
                        content: MyText(
                          'Do you want to delete this pet?',
                          color: mainBlue,
                          fontSize: 14,
                        ),
                        actions: [
                          ElevatedButton(

                            onPressed:  ()async {
                              try {
                                await data.delete(widget.sId)
                                    .then((value) {
                                      widget.isAvailable = widget.isAvailable - 1;
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (ctx) => HomePage()));
                                });
                              } catch (e, s) {
                                print(e);
                                print(s);
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                            ),
                            child: MyText(
                              'Yes',
                              color: mainBlue,
                              fontSize: 14,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),),
                            child:  MyText(
                              'No',
                              color: mainBlue,
                              fontSize: 14,
                            ),
                          )
                        ],
                        backgroundColor: white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        backgroundColor: Colors.black26,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    child: Image.network(widget.petPicture,
                      fit: BoxFit.fill,
                    ),
                  ),

                  SizedBox(height: 20,),

                  InputField(
                    inputController: data.ageTextController,
                    isPassword: false,
                    hintText: 'New Pet Age',
                    hasSuffixIcon: false,
                    keyBoardType: TextInputType.text,
                  ),
                  SizedBox(height: 20,),

                  InputField(
                    inputController: data.costTextController,
                    isPassword: false,
                    hintText: 'New Pet Price',
                    hasSuffixIcon: false,
                    keyBoardType: TextInputType.text,

                  ),
                  SizedBox(height: 20,),

                  InputField(
                    inputController: data.isAvailableTextController,
                    isPassword: false,
                    hintText: 'Number of available Pets',
                    hasSuffixIcon: false,
                    keyBoardType: TextInputType.text,
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  MyButton(
                    height: 50,
                    color: mainred,
                    onTap: ()async {
                      data.isLoading = true;
                        if (mounted)
                          setState(() {});

                        Duration waitTime = Duration(seconds: 4);
                        Future.delayed(waitTime, (){
                          data.isLoading = false;
                          if (mounted)
                            setState(() {});
                        });

                        try {
                          await data.putUpdate(widget.sId)
                            .then((value) {
                              if (data.putResponse.statusCode == 200) {
                                data.ageTextController.clear();
                                data.costTextController.clear();
                                data.isAvailableTextController.clear();
                                Navigator.pop(context,);
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text(
                                      'There is an error'),
                                  duration: Duration(seconds: 5),),);
                              }
                        });
                      } catch (e, s) {
                        print(e);
                        print(s);
                      }
                    },
                     child: data.isLoading == false ? MyText(
                    'Update',
                    color: white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,)
                      : Center(
                        child: CircularProgressIndicator(
                        color: mainBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}




