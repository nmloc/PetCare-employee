import 'package:dogs_park/resources/colors.dart';
import 'package:flutter/material.dart';

class ItemDetailCommon extends StatefulWidget {
  final String tittle;
  final String description;
  final Function() onTap;

  const ItemDetailCommon({super.key, required this.tittle, required this.description, required this.onTap});

  @override
  State<ItemDetailCommon> createState() => _ItemDetailCommonState();
}

class _ItemDetailCommonState extends State<ItemDetailCommon> {
  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height;
    // final double maxWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: GestureDetector(
          onTap:(){widget.onTap.call();},
          child: Container(
            height: maxHeight*0.08,
            decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: ColorResources.greyColor),
                color:const Color(0xFFF9F9F9)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.tittle,
                    style: const TextStyle(
                      color:Color(0xFF666666) ,
                      fontWeight: FontWeight.w500,
                      fontFamily: "SF Pro Display",
                      fontSize: 15.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      widget.description,
                      style: const TextStyle( fontWeight: FontWeight.w400,
                          fontFamily: "SF Pro Display",
                          fontSize: 15.0,color: Color(0xFF8A8A8F)
                      ),
                    ),
                  ),
                ],
              ),
            ) ,
          ),
        ),
      ),
    );
  }
}
