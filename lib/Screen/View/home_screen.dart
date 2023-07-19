import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes/Screen/Controller/quotes_controller.dart';
import 'package:quotes/Screen/Model/custom_model.dart';
import 'package:quotes/Screen/utils/Db_helper/Db_helper.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

QuoteController controller = Get.put(QuoteController());

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Amazing quotes",
            style: GoogleFonts.averiaSansLibre(
                fontSize: 15.sp, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.red,
          actions: [
            IconButton(
                onPressed: () {
                  UpdateModel m = UpdateModel(
                    statu: 0
                  );
                  Get.toNamed('tab',arguments: m);
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ))
          ],
        ),
        body: Column(
          children: [
            CarouselSlider(
              items: controller.sliderimageList
                  .asMap()
                  .entries
                  .map((e) => Container(
                        height: 10.sp,
                        // margin: EdgeInsets.symmetric(vertical: 10),
                        width: 100.w,
                        padding: EdgeInsets.all(15),
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.sp),
                            image: DecorationImage(
                                image: AssetImage(
                                    "${controller.sliderimageList[e.key].img}"),
                                fit: BoxFit.contain)),
                        child: Text(
                          '${controller.sliderimageList[e.key].qu}',
                          style: GoogleFonts.averiaSansLibre(
                              fontSize: 12.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  controller.sliderIndex.value = index;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: controller.sliderimageList
                  .asMap()
                  .entries
                  .map((e) => Obx(
                        () => Container(
                          height: 8,
                          width: 8,
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: controller.sliderIndex.value == e.key
                                  ? Colors.yellow
                                  : Colors.red),
                        ),
                      ))
                  .toList(),
            ),
            Container(
                margin: EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                child: Text("Most Popular",
                    style: TextStyle(
                        fontSize: 12.sp, fontWeight: FontWeight.bold))),
            Obx(
              () => Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: 20.h),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed('read',
                            arguments: controller.catList[index]['category']);
                      },
                      onLongPress: () {
                        DbHelper.helper.deletecat(controller.catList[index]['id']);
                        controller.getData();
                      },
                      onDoubleTap: () {
                        Get.toNamed('tab');
                      },
                      child: Container(
                        height: 20.h,
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.all(3.sp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.sp),
                          color: Colors.red,
                          image: DecorationImage(
                            image:
                         controller.path.value != null ?FileImage(
                            File("${controller.catList[index]['img']}"),
                          ):FileImage(File('')),fit: BoxFit.cover
                        ),
                      ),
                        child: Text("${controller.catList[index]['category']}",style: GoogleFonts.averiaSansLibre(
                    fontSize: 15.sp, color: Colors.white,fontWeight: FontWeight.bold),maxLines: 1,
                    ),),);
                  },
                  itemCount: controller.catList.length,
                ),
              ),
            )
            // Expanded(child:Obx(
            //   () =>  ListView.builder(itemBuilder: (context, index) {
            //         return InkWell( onTap: () {
            //           Get.toNamed('read',arguments: controller.catList[index]['category']);
            //         },child: ListTile(title: Text('${controller.catList[index]['category']}')));
            //       },
            //       itemCount: controller.catList.length,
            //       ),
            // ),
            // ),
          ],
        ),
      ),
    );
  }
}
