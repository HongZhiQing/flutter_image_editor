import 'package:flutter/material.dart';
import 'package:flutter_image_editor_example/controller.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class EditImagePage extends StatefulWidget {
  final AssetEntity assets;

  const EditImagePage({Key? key, required this.assets}) : super(key: key);

  @override
  State<EditImagePage> createState() => _EditImagePageState();
}

class _EditImagePageState extends State<EditImagePage>
    with SingleTickerProviderStateMixin {
  late EditImageController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = EditImageController(widget.assets, this);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: GestureDetector(
        onTap: () {
          controller.toggleShowAction();
        },
        child: Stack(
          children: [
            _buildImage(),
            _buildAppBar(),
            _buildAction(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Obx(() {
      return RotatedBox(
        quarterTurns: controller.rotateValue.value,
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(controller.flipValue.value),
          child: Container(
            alignment: Alignment.center,
            child: Image(
              image: AssetEntityImageProvider(widget.assets),
              fit: BoxFit.contain,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildAppBar() {
    return AnimatedBuilder(
      animation: controller.animationController,
      builder: (_, c) {
        return Opacity(
          opacity: 1 - controller.animationController.value,
          child: Container(
            height: MediaQuery.of(context).padding.top + kToolbarHeight,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              left: 16,
              right: 16,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.transparent,
                ],
              ),
            ),
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                if (controller.animationController.isAnimating ||
                    controller.animationController.value != 0) return;
                Navigator.of(context).maybePop();
              },
              child: Text(
                "取消",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAction() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
          animation: controller.animationController,
          builder: (_, c) {
            var child = Opacity(
              opacity: 1 - controller.animationController.value,
              child: Container(
                height: MediaQuery.of(context).padding.bottom + 56 * 2,
                padding: EdgeInsets.only(
                  top: 56,
                  bottom: MediaQuery.of(context).padding.bottom,
                  left: 16,
                  right: 16,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black,
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 28,
                    ),
                    SizedBox(width: 24),
                    GestureDetector(
                      onTap: controller.flip,
                      child: Icon(
                        Icons.flip,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    SizedBox(width: 24),
                    GestureDetector(
                      onTap: controller.rotate,
                      child: Icon(
                        Icons.rotate_right,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    SizedBox(width: 24),
                    Icon(
                      Icons.crop,
                      color: Colors.white,
                      size: 28,
                    ),
                    Spacer(),
                    Container(
                      height: 34,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Color(0xff3D6AE6),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "完成",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
            if (controller.animationController.value == 0) {
              return child;
            }
            return IgnorePointer(
              child: child,
            );
          }),
    );
  }
}
