

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';
import '../utils/app_colors.dart';
import '../widgets/my_text.dart';
import 'add_new_pet.dart';
import 'allPets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProviderClass().get();
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ProviderClass>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyText(
            'BiggieVet',
                color: white,
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
              Padding(
                padding: EdgeInsets.only(left: 80),
                child: InkWell(
                  child: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                            child: Row(
                              children: const [
                                Icon(Icons.account_circle,
                                  color: Colors.black,),

                                SizedBox(
                                  width: 5,
                                ),
                                Text('User')
                              ],
                            )),
                        PopupMenuItem(
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const addNewPet()));
                                },
                                child: const Text('Add New Pet'))),
                      ]),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.cyan,
        body:
        SingleChildScrollView(
          child: Column(
            children: [
            //   data.getResponse.isEmpty ?
          //   Center(
          //     child: CircularProgressIndicator(
          //     color: mainBlue,
          // ),
          // ):
              AllPets(),
            ],
          ),
        ),
      ),
    );
  }
}


