

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';
import '../utils/app_colors.dart';
import '../widgets/my_button.dart';
import '../widgets/my_text.dart';
import '../widgets/my_text_form_field.dart';

class addNewPet extends StatefulWidget {
  const addNewPet({Key? key}) : super(key: key);

  @override
  State<addNewPet> createState() => _addNewPetState();
}

class _addNewPetState extends State<addNewPet> {

  bool isLoading = false;
  final TextEditingController _breedTextController = TextEditingController();
  final TextEditingController _ageTextController = TextEditingController();
  final TextEditingController _costTextController = TextEditingController();
  final TextEditingController _isAvailableTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ProviderClass>(context);
    //final fileName = data.file != null ? basename(data.file!.path) : 'No File Selected';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainBlue,
        automaticallyImplyLeading: true,
        title: Text('Add New Pet',
          style: TextStyle(
            color: mainred,
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

                  SizedBox(height: 20,),
                  MyButton(
                    height: 40,
                    icon: Icons.attach_file,
                    color: mainred,
                    child: MyText (
                      'Select Pet Image',
                      color: white,
                      fontSize: 18,
                    ),
                    onTap: data.selectFile,
                  ),

                  SizedBox(height: 8),
                  Text(
                    'fileName',
                    style: TextStyle(fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: mainBlue),
                  ),
                  SizedBox(height: 20),
                  // data.task != null ? buildUploadStatus(data.task!) : Container(
                  //   color: white,
                  // ),
                  SizedBox(height: 20),

                  InputField(
                    inputController: _breedTextController,
                    isPassword: false,
                    hintText: 'Pet Breed',
                    hasSuffixIcon: false,
                    keyBoardType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: 20,),

                  InputField(
                    inputController: _ageTextController,
                    isPassword: false,
                    hintText: 'Pet Age',
                    hasSuffixIcon: false,
                    keyBoardType: TextInputType.text,
                  ),
                  SizedBox(height: 20,),

                  InputField(
                    inputController: _costTextController,
                    isPassword: false,
                    hintText: 'Pet Price',
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

                  SizedBox(height: 100,),

                  MyButton(
                      color: mainred,
                      height: 50,
                      child: MyText (
                        'Upload',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      ),
                      icon: Icons.cloud_upload_outlined,
                      // onTap: () async {
                      //   if (data.file == null) return;
                      //
                      //   final fileName = basename(data.file!.path);
                      //   final destination = 'files/$fileName';
                      //
                      //   data.task = FirebaseApi.uploadFile(destination, data.file!);
                      //   setState(() {});
                      //
                      //   if (data.task == null) return;
                      //
                      //   final snapshot = await data.task!.whenComplete(() {});
                      //   data.imageUrl = await snapshot.ref.getDownloadURL();
                      //
                      //   print('Download-Link: ${data.imageUrl}');
                      //
                      //   if (data.imageUrl != null) {
                      //     try {
                      //       await FirebaseFirestore.instance.collection('Users')
                      //           .doc(_titleTextController.text)
                      //           .set({
                      //         'movie-title': _titleTextController.text,
                      //         'movie-description': _descriptionTextController
                      //             .text,
                      //         'urlDownload': data.imageUrl,
                      //       })
                      //           .then((value) {
                      //         setState(() {
                      //           isLoading = false;
                      //         });
                      //         Navigator.pop(context);
                      //       });
                      //     } catch (e, s) {
                      //       print(e);
                      //       print(s);
                      //     }
                      //   }
                      // }
                  ),


                ],
              ),
            )
        ),
      ),
    );
  }

  // Widget buildUploadStatus(UploadTask task) =>
  //     StreamBuilder<TaskSnapshot>(
  //       stream: task.snapshotEvents,
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           final snap = snapshot.data!;
  //           final progress = snap.bytesTransferred / snap.totalBytes;
  //           final percentage = (progress * 100).toStringAsFixed(2);
  //
  //           return Text(
  //             '$percentage %',
  //             style: TextStyle(fontSize: 20,
  //               fontWeight: FontWeight.bold,
  //               color: mainBlue,),
  //           );
  //         } else {
  //           return Container();
  //         }
  //       },
  //     );
}
