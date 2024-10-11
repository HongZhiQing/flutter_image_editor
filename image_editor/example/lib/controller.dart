import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'dart:math' as math;

class EditImageController {
  late AssetEntity assetEntity;
  late AnimationController animationController;

  EditImageController(this.assetEntity, TickerProvider vsync)
      : animationController = AnimationController(
            vsync: vsync, duration: const Duration(milliseconds: 200));

  final showAction = true.obs;
  final flipValue = 0.0.obs;
  final rotateValue = 0.obs;

  void toggleShowAction() {
    showAction.value = !showAction.value;
    animationController.animateTo(showAction.value ? 0 : 1);
  }

  void flip() {
    flipValue.value = flipValue.value == 0 ? math.pi : 0;
  }

  void rotate() {
    rotateValue.value = (rotateValue.value + 1) % 4;
  }
}
