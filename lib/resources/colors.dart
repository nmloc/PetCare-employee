import 'package:flutter/material.dart';

class ColorResources {
    ColorResources._();

    static const mainColor =  Color.fromARGB(255, 4, 206, 188);

    static final grey600= Colors.grey.shade600;

    static const blackColor = Colors.black;
    static const indigo = Colors.indigo;
    Color greyWithOpacity05= const Color(0xFF666666).withOpacity(0.5);
    static const blackColor12 = Colors.black12;
    static const blackColor54 = Colors.black54;
    static const textColorCheckingStatus =Color(0xFF32567A);
    static const rememberRadioButtonColor =Color(0xFFa644ff);
    static const whiteColor = Colors.white;
    static const greyColor = Colors.grey;
    static const calendarBackgroundColor =Color(0xFFF9F9F9);
    static const doneTaskColor = Color(0xFFFF2D55);
    static const pendingTaskColor=Color(0xFFFF9500);
    static const availableTaskColor = Color(0xFF5EB861);
    Color greyColorWithOpacity03 = Colors.grey.withOpacity(0.3);
    static const colorOfContainer = Colors.white;
    static const foreignColor = Color(0xFFd9d7cb);
    static final brownColor = Colors.brown.shade100;
    static const blueColor = Colors.blue;
    static const pinkColor = Colors.pink;
    static const redColor = Colors.red;
    static const greenColor = Colors.green;
    static final greyColorShade300 = Colors.grey.shade300;
    static final greyColorShade600 = Colors.grey.shade600;
    static final greyColorShade200 = Colors.grey.shade200;
    static final Color whiteColorWithOpacity03 = Colors.white.withOpacity(0.3);
    static const Color whiteColor70= Colors.white70;
    static final Color redColorWithOpacity07 = Colors.red.withOpacity(0.7);
    static const Color primaryColor = Color.fromARGB(255, 255, 255, 255);
    static const Color primaryDarkColor = Color.fromARGB(255, 36, 37, 38);
    static const Color accentColor = Color.fromARGB(255, 240, 158, 17);
    static const Color accentDarkColor = Color.fromARGB(255, 240, 158, 17);
    static const Color scaffoldBackgroundColor = Color.fromARGB(255, 58, 134, 146);
    static const Color scaffoldBackgroundDarkColor =
    Color.fromARGB(255, 58, 134, 146);
    static const Color cardColor = Color.fromARGB(255, 58, 134, 146);
    static const Color cardDarkColor = Color.fromARGB(255, 58, 134, 146);
    static const Color textSelectionColor =
    Color.fromARGB(255, 58, 134, 146);
    static const Color textSelectionDarkColor =
    Color.fromARGB(255, 58, 134, 146);
    static const Color errorColor = Color.fromARGB(255, 58, 134, 146);
    static const Color errorDarkColor = Color.fromARGB(255, 58, 134, 146);
    static const Color textColor = Color.fromARGB(255, 0, 0, 0);
    static const Color textDarkColor = Color.fromARGB(255, 255, 255, 255);
    static const Color iconColor = Color.fromARGB(255, 58, 134, 146);
    static const Color iconDarkColor = Color.fromARGB(255, 58, 134, 146);
    static const Color canvasColor = Color.fromARGB(255, 245, 243, 242);
    static const Color canvasDarkColor = Color.fromARGB(255, 24, 25, 26);
    static const Color appBarColor = Color.fromARGB(255, 58, 134, 146);
    static const Color appBarDarkColor = Color.fromARGB(255, 58, 134, 146);
    static const Color hintTextColor = Color.fromARGB(100, 0, 0, 0);
    static const Color hintTextDarkColor =
    Color.fromARGB(100, 255, 255, 255);
    static const backgroundDrawer = Colors.black87;
    static const Color textLightColor = Colors.black;

    ThemeData theme = ThemeData(
        textTheme: const TextTheme(
            caption: TextStyle(fontSize: 14),
            subtitle2: TextStyle(fontSize: 14),
            subtitle1: TextStyle(fontSize: 14,color: ColorResources.textLightColor),
            headline6: TextStyle(fontSize: 14),
            headline5: TextStyle(fontSize: 14),
            headline4: TextStyle(fontSize: 14),
            headline3: TextStyle(fontSize: 14),
            headline2: TextStyle(fontSize: 14),
            headline1: TextStyle(fontSize: 14),
            overline: TextStyle(fontSize: 14),
            button: TextStyle(fontSize: 14),
            bodyText2: TextStyle(fontSize: 14),
            bodyText1: TextStyle(fontSize: 14),
        ),
    );
}
