import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplaceScreen extends StatefulWidget {
  const SplaceScreen({Key? key}) : super(key: key);

  @override
  State<SplaceScreen> createState() => _SplaceScreenState();
}

class _SplaceScreenState extends State<SplaceScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), ()=>Get.offAllNamed('home'));
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/images/quote.jpg"),
      ),
    ),);
  }
}
