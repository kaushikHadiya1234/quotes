import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quotes/Screen/Model/quotes_model.dart';
import 'package:quotes/Screen/utils/Db_helper/Db_helper.dart';
import 'package:sizer/sizer.dart';

import 'home_screen.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {

  TextEditingController txtcat = TextEditingController();

  var txtkey = GlobalKey<FormState>();

  @override
  void initState() {
    controller.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: txtkey,
        child: Scaffold(
          body: Column(
            children: [
              SizedBox(height: 20),
              Text("Pick image",style: TextStyle(fontSize: 15.sp,color: Colors.black,fontWeight: FontWeight.bold),),
              SizedBox(height: 20),
              Obx(
                () =>  Container(
                  height: 15.h,
                  width: 15.h,
                  alignment: Alignment(1.2,0.7),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,color: Colors.red.shade100,
                    image: DecorationImage(
                      image:controller.path!=null? FileImage(File("${controller.path.value}")):FileImage(File("")),fit: BoxFit.cover
                    )
                  ),
                  child:  InkWell(
                    onTap: () async {
                      ImagePicker picker = ImagePicker();
                      XFile? xfile = await picker.pickImage(source: ImageSource.gallery);

                      controller.imgByte = await xfile!.readAsBytes();

                      controller.path.value =await xfile.path;
                    },
                    child: Container(
                      height: 5.h,
                      width: 5.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,color: Colors.blue
                      ),
                      child: Icon(Icons.edit),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  validator: (value) {
                    if(value!.isEmpty)
                      {
                        return "Enter the category";
                      }
                  },
                  controller: txtcat,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Enter your Category"
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: () {
              if(txtkey.currentState!.validate())
                {
                 if(controller.path.isEmpty)
                   {

                   }
                 else
                   {
                     CategoryModel m = CategoryModel(
                         cat: txtcat.text,
                         img: controller.path.value
                     );
                     DbHelper.helper.insertcDb(model: m);
                     controller.getData();
                     Get.back();
                   }
                }
              }, child: Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}
