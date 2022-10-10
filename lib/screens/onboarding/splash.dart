

import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text.dart';
import '../Auth/login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              'BiggieVet',
              color: Colors.pinkAccent,
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
            Row(
              children: [
                MyText('Help',
                  color: white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,),
                const SizedBox(
                  width: 20,
                ),
                MyText('Privacy',
                  color: white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,),
              ],
            )
          ],
        ),
      ),
      backgroundColor: backGround,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backgroundDog.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 41, right: 41, top: 420,),
            child: MyButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginPage()),
                );
              },
              child: Container(
                height: 56,
                width: 332,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: MyText(
                    'Welcome',
                    color: Colors.pinkAccent,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
