import 'package:get/get.dart';
import '../../../data/model/quick_share_model.dart';

class ShareDialogController extends GetxController {
  ShareDialogController({
    required this.steps,
  });

  final List<ShareDialogStep> steps;

  final currentMessage = ''.obs;
  final progress = 0.0.obs;
  final isRunning = false.obs;

  Future<void> run() async {
    if (steps.isEmpty) return;

    isRunning.value = true;
    progress.value = 0;
    currentMessage.value = steps.first.message;

    for (var i = 0; i < steps.length; i++) {
      currentMessage.value = steps[i].message;
      await steps[i].action();
      progress.value = (i + 1) / steps.length;
    }

    isRunning.value = false;
  }



}