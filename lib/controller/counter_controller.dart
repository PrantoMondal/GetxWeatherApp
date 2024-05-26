import 'package:get/get.dart';

class CounterController extends GetxController {
  RxInt count = 0.obs;
  increment() {
    count.value++;
  }

  decrement() {
    if (count.value > 0) {
      count.value--;
    }
  }

  reset() {
    count.value = 0;
  }
}
