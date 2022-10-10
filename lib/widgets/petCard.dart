

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';
import '../screens/make_order.dart';
import '../screens/petDetailScreen.dart';
import 'my_text.dart';

class PetCard extends StatefulWidget {
  String sId;
  String breed;
  String age;
  int isAvailable;
  String petPicture;
  String cost;

  PetCard({
    required this.sId,
    required this.breed,
    required this.age,
    required this.isAvailable,
    required this.petPicture,
    required this.cost,
  });

  @override
  State<PetCard> createState() => _PetCardState();
}

class _PetCardState extends State<PetCard> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      var data = Provider.of<ProviderClass>(context, listen: false);
      data.sharedPreferences();
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ProviderClass>(context,);
    return Card(
      color: Colors.white.withOpacity(0.2),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            width: double.infinity,
            height: 300,
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (ctx) => data.userEmail == 'emmanuelokoh@gmail.com' ?
                        PetDetail(
                        widget.sId,
                        widget.breed,
                        widget.age,
                        widget.isAvailable,
                        widget.petPicture,
                        widget.cost,
                        )
                            : MakeOrder(
                          widget.sId,
                          widget.breed,
                          widget.age,
                          widget.isAvailable,
                          widget.petPicture,
                          widget.cost,
                        )
                    ));
              },
              child: Image.network(widget.petPicture,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child:  MyText(widget.breed,
              textAlign: TextAlign.center,
              fontSize: 30,
              color: Colors.blueAccent,
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: MyText('Age: ${widget.age}',
              fontSize: 22,
              textAlign: TextAlign.start,
              color: Colors.blueAccent,
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: MyText('Price: ${widget.cost}',
              fontSize: 22,
              textAlign: TextAlign.start,
              color: Colors.blueAccent,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
