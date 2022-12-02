import 'package:flutter/material.dart';
import 'package:library_final_project/res/constraint/constraint.dart';

class DrawerBar extends StatelessWidget {
  const DrawerBar({
    Key? key,
  }) : super(key: key);

  final double coverHeight = 200;
  final double profileHeight = 120;

  @override
  Widget build(BuildContext context) {
    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;
    return Drawer(
        backgroundColor:backgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
             children: [
                Container(
                  color:Colors.white,
                  width: double.infinity,
                  height: coverHeight,
                  margin: EdgeInsets.only(bottom: bottom ),
                  child: Image.network('https://z-p3-scontent.fpnh5-2.fna.fbcdn.net/v/t39.30808-6/292252498_110774601690646_1618977608937918361_n.png?_nc_cat=109&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeHi5NGOCslzaAEjsydTbxGNVfkQPvqVi-9V-RA--pWL7-cI0Wj8LP13RRemA-hm1ZAy-zydlZXzxLIjyzhm5X1B&_nc_ohc=d1UjmjbW3xsAX8R0aoI&_nc_zt=23&_nc_ht=z-p3-scontent.fpnh5-2.fna&oh=00_AfBe-iNvQzjelg8Sa3CtZpMTz8IQOorXYcqkGM_34hf5ZQ&oe=638DCBFB',),
                ),
              Positioned(
                top: top,
                child: Container(
                  //color: Colors.grey,
                  width: 150,
                    height: top,
                    child: Image.asset('assets/img/splash-img.png',fit: BoxFit.cover,)),
              ),
             ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Text('Final Project',style: TextStyle(fontSize: 28,color: Colors.black,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Text('Topic : LIBRARY',style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Text('Teacher : KIT TARA',style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Text('Develop by : SONG KIMCHHAY',style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),

                ],
              ),
            ),
          ],
        ));
  }
}
