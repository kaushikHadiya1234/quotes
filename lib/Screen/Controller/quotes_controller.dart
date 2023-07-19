
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:quotes/Screen/Model/custom_model.dart';
import 'package:quotes/Screen/Model/quotes_model.dart';
import 'package:quotes/Screen/utils/Db_helper/Db_helper.dart';

class QuoteController extends GetxController
{
   RxList<CustomModel> sliderimageList = <CustomModel>[
     CustomModel(img:'assets/images/q1.jpg',qu: '"Success is not final; failure is not fatal: It is the courage to continue that counts." — Winston S. Churchill' ),
     CustomModel(img:'assets/images/q2.jpg',qu: "“Concentrate all your thoughts upon the work in hand. The sun's rays do not burn until brought to a focus. “ — Alexander Graham Bell"),
     CustomModel(img:'assets/images/q3.jpg',qu: "“No woman wants to be in submission to a man who isn’t in submission to God!” ― T D Jakes" ),
     CustomModel(img:'assets/images/q4.jpg',qu: "A successful man is one who can lay a firm foundation with the bricks others have thrown at him.” – David Brinkley"),
     CustomModel(img:'assets/images/q5.jpg',qu: "“Keep your eyes on the stars, and your feet on the ground.” ―Theodore Roosevelt" ),

   ].obs;

   RxInt sliderIndex = 0.obs;
   RxString path='jenil'.obs;
   Uint8List? imgByte;
   RxList<Map> catList = <Map>[

   ].obs;
   RxList<Map> quotesList = <Map>[
     {
       "quote":"“We cannot solve problems with the kind of thinking we employed when we came up with them.”",
       "name":"Albert Einstein",
       "category":"motivational"
     },
     {
       "quote":"“We cannot solve problems with the kind of thinking we employed when we came up with them.”",
       "name":"Albert Einstein",
       "category":"motivational"
     },
     {
       "quote":"“We cannot solve problems with the kind of thinking we employed when we came up with them.”",
       "name":"Albert Einstein",
       "category":"Abdul Kalam"
     },
   ].obs;

   RxString selectItem = 'motivational'.obs;



   Future<void> getData()
   async {
     catList.value=await DbHelper.helper.readcData();

     print('==========================${catList.length}');
      selectItem.value = '${catList[0]['category']}';
   }

   Future<void> getreadData(cat)
   async {
     quotesList.value=await DbHelper.helper.readData( cat:cat);
     print('=======qlist======================$quotesList');
   }

}