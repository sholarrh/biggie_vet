import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  MyButton({
    Key? key,
    required this.child,
    this.onTap,
    this.hasShadow = false,
    this.height,
    this.width,
    this.hasDoubleShadow,
    this.borderRadius,
    this.horizontalPadding,
    this.verticalPadding,
    this.alignment,
    this.gradient,
    this.boxBorder,
    this.boxShadow,
    this.shape,
    this.color,
    this.boxDecoration,
    this.bottom,
    this.icon
  }) : super(key: key);

  final Widget child;
  final Function()? onTap;
  final Color? color;
  final bool? hasDoubleShadow;
  final bool? hasShadow;
  final double? height;
  final double? width;
  final double? borderRadius;
  final BoxBorder? boxBorder;
  final double? horizontalPadding;
  final double? verticalPadding;
  final Alignment? alignment;
  final BoxDecoration? boxDecoration;
  final Positioned? bottom;
  final LinearGradient? gradient;
  final List<BoxShadow>? boxShadow;
  final BoxShape? shape;
  final IconData? icon;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding ?? 0, vertical: verticalPadding ?? 5),
        decoration: boxDecoration ??
            BoxDecoration(
              // border: boxBorder ?? Border.all(color: controller.borderColor),
                color: color,
                borderRadius: BorderRadius.circular(borderRadius ?? 8),
                boxShadow: boxShadow ?? []),
        child: Center(child: child),
      ),
    );
  }
}