import 'package:dogs_park/controllers/controller.dart';
import 'package:dogs_park/resources/resource.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final authenticationController = Get.put(AuthenticationController());

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final double maxHeight = MediaQuery.of(context).size.height;
    final double maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Strings.welcome,
                style: GoogleFonts.secularOne(
                  fontSize: 42.0,
                  fontWeight: FontWeight.bold,
                  color: ColorResources.blackColor,
                ),
                textAlign: TextAlign.left,
              ),
              Container(
                margin: const EdgeInsets.only(top: 5.0, bottom: 40),
                child: const Text(Strings.signInTitle,
                    style: TextStyle(
                        fontSize: 16, color: ColorResources.greyColor)),
              ),
              //email text field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorResources.whiteColor,
                    border: Border.all(color: ColorResources.blackColor12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _phoneController,
                      style: const TextStyle(color: ColorResources.blackColor),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: Strings.phoneNumber,
                      ),
                    ),
                  ),
                ),
              ),
              //password text field
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorResources.whiteColor,
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _passwordController,
                      style: const TextStyle(color: ColorResources.blackColor),
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: Strings.password,
                      ),
                    ),
                  ),
                ),
              ),
              //login button
              GestureDetector(
                onTap: () {
                  authenticationController.signInHandler(
                      _phoneController, _passwordController);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorResources.mainColor,
                    ),
                    child: const Center(
                      child: Text(
                        Strings.login,
                        style: TextStyle(
                            color: ColorResources.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Obx(
                            () => Checkbox(
                              value: authenticationController.remember.value,
                              shape: const CircleBorder(),
                              onChanged: (value) {
                                authenticationController.setRemember();
                              },
                              checkColor: ColorResources.whiteColor,
                              activeColor: ColorResources.rememberRadioButtonColor,
                            ),
                          ),
                          const Text(Strings.rememberMe),
                        ],
                      ),
                      TextButton(
                        onPressed: () {authenticationController.onTapForgotOrSignUp();},
                        child: const Text(
                          Strings.forgotPass,
                          style: TextStyle(
                              color: ColorResources.greyColor,
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.underline,
                              fontSize: 16),
                        ),
                      )
                    ],
                  ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: maxWidth * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(Strings.haveAccount,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: ColorResources.greyColor)),
                    TextButton(
                      onPressed: () {authenticationController.onTapForgotOrSignUp();},
                      child: Text(
                        Strings.signUp,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: ColorResources.blackColor, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
