import 'package:get/get.dart';

import 'controller/full_screen_image_controller.dart';
import 'controller/home_page_controller.dart';

class ViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>FullScreenImageController());
    Get.lazyPut(()=>HomeController());
  }
}
