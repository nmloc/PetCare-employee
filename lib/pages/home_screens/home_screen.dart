import 'package:dogs_park/resources/resource.dart';
import '../../pages/home_screens/components/appbar_custom.dart';
import '../../pages/home_screens/components/scan_qr_code.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
//    final double maxHeight = MediaQuery.of(context).size.height;
    final double maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar:AppBarCustom(tittle: Strings.checking,appBar:AppBar(),backIcon: false),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: maxWidth*0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QRViewExample(pageName:"CheckIn",)));
              },
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorResources.mainColor),
                child: const Center(
                  child: Text(
                   Strings.checkInPet,
                    style: TextStyle(
                        color: ColorResources.whiteColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 18.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: maxWidth*0.07),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QRViewExample(pageName: "CheckOut",)));
              },
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color:ColorResources.mainColor),
                    color: ColorResources.whiteColor),
                child: const Center(
                  child: Text(
                    Strings.checkOutPet,
                    style: TextStyle(
                        color: ColorResources.mainColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 18.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
