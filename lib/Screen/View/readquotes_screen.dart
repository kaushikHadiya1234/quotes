import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes/Screen/Model/custom_model.dart';
import 'package:quotes/Screen/View/home_screen.dart';
import 'package:quotes/Screen/utils/Db_helper/Db_helper.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

class ReadScreen extends StatefulWidget {
  const ReadScreen({Key? key}) : super(key: key);

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  String? cat;
  @override
  void initState() {
    super.initState();
     cat = Get.arguments;
    controller.getreadData(cat);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Obx(
        () =>  ListView.builder(itemBuilder: (context, index) {
          return Container(
            height: 25.h,
            width: 90.w,
            padding: EdgeInsets.all(10.sp),
            margin: EdgeInsets.symmetric(horizontal: 10.sp,vertical: 5.sp),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(15.sp),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.grey,
                  spreadRadius: 1,
                  offset: Offset(0,0)
                )
              ]
            ),
            child: Column(
              children: [
                Text("${controller.quotesList[index]['quote']}",style:GoogleFonts.averiaSansLibre(
                fontSize: 13.sp, color: Colors.black,fontWeight: FontWeight.bold),maxLines: 3,),
                SizedBox(height: 6.sp,),
                Text("-${controller.quotesList[index]['name']}",style: GoogleFonts.averiaSansLibre(
                    fontSize: 13.sp, color: Colors.black,fontWeight: FontWeight.bold),maxLines: 1,),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.done_all),
                    IconButton(onPressed: () {
                      UpdateModel m = UpdateModel(
                        statu: 1,
                        index: index
                      );
                      Get.toNamed('tab',arguments: m);
                    },icon: Icon(Icons.edit)),
                    IconButton(onPressed: () {
                      DbHelper.helper.delete(controller.quotesList[index]['id']);
                      controller.getreadData(cat);
                    },icon: Icon(Icons.delete)),
                    IconButton(onPressed:  () {
                      Share.share('${controller.quotesList[index]['quote']}');
                    },icon: Icon(Icons.share)),
                  ],
                ),
                SizedBox(height: 3.sp,),
              ],
            ),
          );
        },
        itemCount: controller.quotesList.length,
        ),
      ),
    ),);
  }
}
