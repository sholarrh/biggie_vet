
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';
import '../widgets/petCard.dart';


class AllPets extends StatefulWidget {
  const AllPets({
    Key? key,
  }) : super(key: key);

  @override
  State<AllPets> createState() => _AllPetsState();
}

class _AllPetsState extends State<AllPets> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: FutureBuilder(
          future: ProviderClass().get(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: snapshot.data!.data!.length,
              itemBuilder: (context, index) {
                final apidata = snapshot.data!.data!;
                print(apidata);
                if (snapshot.hasData) {
                  if (snapshot.hasError){
                    return Center(
                      child: Container(
                        child: Text(
                            'There is an error'
                        ),
                      ),
                    );
                  }
                  return PetCard(
                      sId: apidata[index].sId!.toString(),
                      breed: apidata[index].breed!.toString(),
                      age: apidata[index].age!.toString(),
                      isAvailable: apidata[index].isAvailable!,
                      petPicture: apidata[index].petPicture!.toString(),
                      cost: apidata[index].cost!.toString()
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          }
      ),
    );
  }
}