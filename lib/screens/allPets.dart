
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
  void initState() {
    // TODO: implement initState
    super.initState();
    ProviderClass().get();
  }
  
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ProviderClass>(context,);
    return RefreshIndicator(
      onRefresh: ()async{
        await data.get();
      },
      child: Center(
        child: Consumer<ProviderClass>(
          builder: (ctx, value, child) {
            return  Container(
                   height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: FutureBuilder(
                  future: ProviderClass().get(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData && !snapshot.hasError ?
                        const Center(
                          child: SizedBox(
                              height: 50,
                            width: 50,
                              child: CircularProgressIndicator(
                                valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue),
                              ),
                          ),
                        )
                    : snapshot.hasError ?
                    const Text('Something went wrong ',textAlign: TextAlign.center,)
                      : Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                            reverse: true,
                            itemCount: snapshot.data!.data!.length,
                            itemBuilder: (context, index) {
                              final apidata = snapshot.data!.data!;
                              print(apidata);
                                return PetCard(
                                    sId: apidata[index].sId!.toString(),
                                    breed: apidata[index].breed!.toString(),
                                    age: apidata[index].age!.toString(),
                                    isAvailable: apidata[index].isAvailable!,
                                    petPicture: apidata[index].petPicture!.toString(),
                                    cost: apidata[index].cost!.toString()
                                );
                            },
                    ),
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                        ],
                      );
                  }
              ),
            );
          },
        ),
      ),
    );
  }
}




// ListView.builder(
// itemCount: value.map['data'].length,
// itemBuilder: (ctx, i) {
// return PetCard(
// sId: value.map[i].sId!.toString(),
// breed: value.map[i].breed!.toString(),
// age: value.map[i].age!.toString(),
// isAvailable:value.map[i].isAvailable!,
// petPicture: value.map[i].petPicture!.toString(),
// cost: value.map[i].cost!.toString()
// );
// }
// );