import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes/Screen/Model/custom_model.dart';
import 'package:quotes/Screen/Model/quotes_model.dart';
import 'package:quotes/Screen/View/home_screen.dart';
import 'package:quotes/Screen/utils/Db_helper/Db_helper.dart';
import 'package:sizer/sizer.dart';

class AddQuptesScreen extends StatefulWidget {
  const AddQuptesScreen({Key? key}) : super(key: key);

  @override
  State<AddQuptesScreen> createState() => _AddQuptesScreenState();
}

class _AddQuptesScreenState extends State<AddQuptesScreen> {
  UpdateModel? m1;

  TextEditingController txtquote = TextEditingController();
  TextEditingController txtname = TextEditingController();

  var txtkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller.getData();
    m1 = Get.arguments;
    if (m1!.statu == 1) {
      txtquote = TextEditingController(
          text: "${controller.quotesList[m1!.index!]['quote']}");
      txtname = TextEditingController(
          text: "${controller.quotesList[m1!.index!]['name']}");
      controller.selectItem.value =
          controller.quotesList[m1!.index!]['category'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: txtkey,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    validator: (value) {
                      if(value!.isEmpty)
                        {
                          return "Enter the quote";
                        }
                    },
                    controller: txtquote,
                    maxLines: 4,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.sp),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.sp),
                        ),
                        hintText: 'Enter the Quotes.....'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    validator: (value) {
                      if(value!.isEmpty)
                      {
                        return "Enter the author name";
                      }
                    },
                    controller: txtname,
                    maxLines: 1,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.sp),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.sp),
                        ),
                        hintText: 'Enter the Author name.....'),
                  ),
                ),
                SizedBox(height: 3.h),
                Container(
                  height: 6.h,
                  width: 90.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      color: Colors.red),
                  child: Obx(
                    () => DropdownButton(
                      style: TextStyle(color: Colors.black),
                      dropdownColor: Colors.red.shade900,
                      value: controller.selectItem!.value,
                      underline: Container(),
                      alignment: Alignment.center,
                      icon: Container(),
                      items: controller.catList
                          .asMap()
                          .entries
                          .map((e) => DropdownMenuItem(
                                alignment: Alignment.center,
                                child: Text(
                                    "${controller.catList[e.key]['category']}",
                                    style: GoogleFonts.almendra(
                                        color: Colors.white,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold)),
                                value: controller.catList[e.key]['category'],
                              ))
                          .toList(),
                      onChanged: (value) {
                        controller.selectItem!.value = value as String;
                      },
                      isExpanded: true,
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
                ElevatedButton(
                    onPressed: () {
                    if(txtkey.currentState!.validate())
                      {
                        if(m1!.statu==0)
                        {
                          QuotesModel m = QuotesModel(
                              quotes: txtquote.text,
                              name: txtname.text,
                              cat: controller.selectItem.value);
                          DbHelper.helper.insertDb(m);
                          controller.getData();
                          Get.back();
                        }
                        else
                        {
                          QuotesModel m = QuotesModel(
                              quotes: txtquote.text,
                              name: txtname.text,
                              cat: controller.selectItem.value);
                          DbHelper.helper.update(model: m,id: controller.quotesList[m1!.index!]['id']);
                          controller.getreadData(controller.selectItem.value);
                          Get.back();
                        }
                      }
                    },
                    child: Text(m1!.statu == 0 ? "Add Quotes" : "Update"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
