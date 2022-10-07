

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';
import '../utils/app_colors.dart';
import '../widgets/my_button.dart';
import '../widgets/my_text.dart';
import '../widgets/my_text_form_field.dart';

class MakeOrder extends StatefulWidget {
  String sId;
  String breed;
  String age;
  int isAvailable;
  String petPicture;
  String cost;

  MakeOrder(
      this.sId,
      this.breed,
      this.age,
      this.isAvailable,
      this.petPicture,
      this.cost,
      );


  @override
  State<MakeOrder> createState() => _MakeOrderState();
}

class _MakeOrderState extends State<MakeOrder> {

  bool isLoading = false;
  final TextEditingController _breedTextController = TextEditingController();
  final TextEditingController _ageTextController = TextEditingController();
  final TextEditingController _costTextController = TextEditingController();
  final TextEditingController _isAvailableTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ProviderClass>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainBlue,
        automaticallyImplyLeading: true,
        title: MyText('Make Order',
        color: mainred,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Column(
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    child: Image.network(widget.petPicture,
                      fit: BoxFit.fill,
                    ),
                  ),

                  SizedBox(height: 8),

                  Container(
                    width: double.infinity,
                    child:  MyText(widget.breed,
                      textAlign: TextAlign.center,
                      fontSize: 30,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  child: MyText('Age: ${widget.age}',
                    fontSize: 22,
                    textAlign: TextAlign.start,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                  SizedBox(height: 20,),

                  Container(
                    width: double.infinity,
                    child: MyText('Price: ${widget.cost}',
                      fontSize: 22,
                      textAlign: TextAlign.start,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 20,),

                  Container(
                    width: double.infinity,
                    child: MyText(widget.isAvailable >= 1 ? 'Available' : 'Not Available',
                      fontSize: 22,
                      textAlign: TextAlign.start,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 40,),

                  MyButton(
                    color: mainred,
                    height: 50,
                    child: MyText (
                      'Make Order',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    //icon: Icons.,
                    onTap: () async {
                      isLoading = true;
                      if (mounted)
                        setState(() {});

                      Duration waitTime = Duration(seconds: 4);
                      Future.delayed(waitTime, (){
                        isLoading = false;
                        if (mounted)
                          setState(() {});
                      });

                      if (widget.isAvailable >= 1) {
                        try {
                          await data.putMakeOrder(widget.sId)
                              .then((value) {
                         if (data.putOrderResponse.statusCode == 200){
                           widget.isAvailable = widget.isAvailable - 1;
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                             content: const Text(
                                 'Purchase Completed'),
                             duration: const Duration(seconds: 5),),);
                           Navigator.pop(context);
                         }
                          });
                        } catch (e, s) {
                          print(e);
                          print(s);
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text(
                              'Order can not be completed'),
                          duration: const Duration(seconds: 5),),);
                        Navigator.pop(context);
                      }
                    }
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
