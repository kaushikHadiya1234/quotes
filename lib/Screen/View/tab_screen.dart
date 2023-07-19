import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes/Screen/View/add_quotes_screen.dart';
import 'package:quotes/Screen/View/add_screen.dart';
import 'package:sizer/sizer.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
               child: Text("Add Quotes"),
              ),
              Tab(
                child: Text("Add Category"),
              ),
            ],
            labelStyle: GoogleFonts.almendra(fontWeight: FontWeight.bold,fontSize: 13.sp),
          ),
        ),
        body: TabBarView(
          children: [
            AddQuptesScreen(),
            AddCategoryScreen()
          ],
        ),
      ),
    ),);
  }
}
