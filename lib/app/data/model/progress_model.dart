import 'package:get/get.dart';

class ProgressModel {
  final String title;
  RxBool isLoading = false.obs;
  RxBool isCompleted = false.obs;

  ProgressModel(this.title);
}
