

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

  final TextEditingController _ageTextController = TextEditingController();
  final TextEditingController _costTextController = TextEditingController();
  final TextEditingController _isAvailableTextController = TextEditingController();
  bool isLoading = false;
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
                color: mainred,
                fontSize: 27,
                fontWeight: FontWeight.w600,
              ),

              InkWell(
                child: PopupMenuButton(
                  color: mainBlue,
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Expanded(
                        child: AlertDialog(
                          title: MyText(
                            'Delete ?',
                            color: mainred,
                            fontSize: 20,
                          ),
                          content: MyText(
                            'Do you want to delete this pet?',
                            color: white,
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
                              child: MyText(
                                'Yes',
                                color: white,
                                fontSize: 14,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child:  MyText(
                                'No',
                                color: white,
                                fontSize: 14,
                              ),
                            )
                          ],
                          backgroundColor: mainBlue,
                        ),
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
                    inputController: _ageTextController,
                    isPassword: false,
                    hintText: 'New Pet Age',
                    hasSuffixIcon: false,
                    keyBoardType: TextInputType.text,
                  ),
                  SizedBox(height: 20,),

                  InputField(
                    inputController: _costTextController,
                    isPassword: false,
                    hintText: 'New Pet Price',
                    hasSuffixIcon: false,
                    keyBoardType: TextInputType.text,

                  ),
                  SizedBox(height: 20,),

                  InputField(
                    inputController: _isAvailableTextController,
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
                      try {
                        isLoading = true;
                        if (mounted)
                          setState(() {});

                        var payload = {
                          "age": _ageTextController.text,
                           "cost": _costTextController.text,
                          "isAvailable": _isAvailableTextController.text
                        };

                        Duration waitTime = Duration(seconds: 4);
                        Future.delayed(waitTime, (){
                          isLoading = false;
                          if (mounted)
                            setState(() {});

                        });

                        await data.putUpdate(payload, widget.sId)
                            .then((value) {
                          Navigator.pop(context);
                        });
                      } catch (e, s) {
                        print(e);
                        print(s);
                      }
                    },
                     child: isLoading == false ? MyText(
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
