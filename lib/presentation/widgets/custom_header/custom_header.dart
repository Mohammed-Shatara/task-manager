import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/presentation/widgets/custom_header/paint/paint_header.dart';

class CustomHeader extends StatefulWidget {
  const CustomHeader({
    super.key,
    this.leading,
    this.action,
    this.bottom,
    this.backgroundColor,
    this.additionalHeight = 0,
    this.height,
    this.start,
    this.end,
    this.padding,
  });

  final Color? backgroundColor;
  final double? height;
  final double additionalHeight;
  final Color? start;
  final Color? end;

  final Widget? leading;
  final Widget? action;
  final Widget? bottom;
  final EdgeInsetsGeometry? padding;

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  double height = 0;

  @override
  Widget build(BuildContext context) {
    final padding = height != 0 ? 200 : 228;
    // print(
    //     'height: ${AppBar().preferredSize.height} ${height} ${ScreensHelper.of(context).fromHeight(12)} ${117.sp}');
    final size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SizedBox(
        width: size.width,
        height:
            AppBar().preferredSize.height +
            ScreenUtil().statusBarHeight +
            100 +
            height +
            widget.additionalHeight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              painter: HeaderPainter(
                color: widget.backgroundColor ?? Theme.of(context).primaryColor,
                height:
                    widget.height != null
                        ? widget.height! + height + ScreenUtil().statusBarHeight
                        : AppBar().preferredSize.height +
                            height +
                            padding - 20 +
                            widget.additionalHeight,
                start: widget.start,
                end: widget.end,
              ),
              child: Container(),
            ),
            SafeArea(
              child: Padding(
                padding:
                    widget.padding ?? EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 30.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Task Manager',
                                style: TextTheme.of(context).titleLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),

                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: widget.leading ?? const SizedBox.shrink(),
                          ),
                        ),
                      ],
                    ),
                    if (widget.bottom != null)
                      MeasureSize(
                        onChange: (Size size) {
                          print('size.height: ${size.height}');
                          setState(() {
                            height = size.height;
                          });
                        },
                        child: widget.bottom!,
                      ),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 18.0.sp),
            //   child: Image.asset(ImagesKeys.bigLogo),
            // ),
            // PositionedDirectional(
            //     top: 135.sp + 22.sp,
            //     start: 22.sp,
            //     child: Text(
            //       "${"Last Update at".tr(context)} $date",
            //       style: Theme.of(context)
            //           .textTheme
            //           .labelMedium
            //           ?.copyWith(color: locator<AppThemeColors>().white),
            //     ))
          ],
        ),
      ),
    );
  }
}

typedef OnWidgetSizeChange = void Function(Size size);

class MeasureSizeRenderObject extends RenderProxyBox {
  Size? oldSize;
  OnWidgetSizeChange onChange;

  MeasureSizeRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();

    Size newSize = child!.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}

class MeasureSize extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onChange;

  const MeasureSize({Key? key, required this.onChange, required Widget child})
    : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureSizeRenderObject(onChange);
  }

  @override
  void updateRenderObject(BuildContext context, covariant MeasureSizeRenderObject renderObject) {
    renderObject.onChange = onChange;
  }
}
