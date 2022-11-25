import 'package:flutter/material.dart';
import 'package:dogs_park/resources/resource.dart';

Container buttonChecking(
    {required String title,
    required Color color,
    required BuildContext context,
    required Function() onPressed}) {
  final double maxWidth = MediaQuery.of(context).size.width;
  return Container(
    height: 50,
    width: maxWidth * 0.42,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
    ),
    child: ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(color)),
      onPressed: () {
        onPressed.call();
      },
      child: Text(
        title,
        style: const TextStyle(
          color: ColorResources.textDarkColor,
          fontWeight: FontWeight.w500,
          fontSize: 18.0,
        ),
      ),
    ),
  );
}
