// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:timer_app/Utilities/AppColor.dart';
import 'package:timer_app/Widgets/CircularProgressIndicator.dart';
import 'package:timer_app/Widgets/CounterText.dart';
import 'package:timer_app/Widgets/Ripple/RippleAnimation.dart';

class ToastService {
  static final instance = ToastService();

  static const _heightDivider = 7;

  void errorToast(
      BuildContext context, String title, String message, Alignment alignment,
      {Duration? progressDuration, bool? counter}) {
    GlobalKey keyCircularProgress = GlobalKey();
    showToastWidget(
        GestureDetector(
            child: Container(
              height: MediaQuery.of(context).size.height / _heightDivider,
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              margin: const EdgeInsets.only(left: 5, right: 5),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color: AppColor.redColor,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const RipplesAnimation(
                    color: AppColor.white,
                    size: 15,
                    child: Icon(
                      Icons.error_rounded,
                      color: AppColor.redColor,
                      size: 20.0,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Column(
                      mainAxisSize: title.isNotEmpty
                          ? MainAxisSize.max
                          : MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          height: 4,
                        ),
                        Visibility(
                          visible: title.isNotEmpty,
                          child: Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.22,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.18,
                              ),
                              children: [
                                WidgetSpan(
                                  child: Visibility(
                                    visible: counter ?? false,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2, vertical: 2),
                                      margin: const EdgeInsets.only(right: 5),
                                      child: CounterText(
                                          count: progressDuration != null
                                              ? progressDuration.inSeconds
                                              : 0),
                                      decoration: BoxDecoration(
                                        color: AppColor.redColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                ),
                                TextSpan(
                                  text: message,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: CustomCircularProgressIndicator(
                      key: keyCircularProgress,
                      duration: progressDuration ??
                          const Duration(milliseconds: 5500),
                    ),
                  ),
                ],
              ),
            ),
            onLongPressStart: (details) {
              CustomCircularProgressIndicator widget = keyCircularProgress
                  .currentWidget as CustomCircularProgressIndicator;
              widget.animationController?.stop();
            },
            onLongPressEnd: (details) {
              CustomCircularProgressIndicator widget = keyCircularProgress
                  .currentWidget as CustomCircularProgressIndicator;
              widget.animationController?.forward();
            },
            onVerticalDragUpdate: (details) {
              int sensitivity = 8;
              if (details.delta.dy > sensitivity) {
                // Down Swipe
                if (alignment == Alignment.bottomCenter) {
                  dismissAllToast(showAnim: true);
                }
              } else if (details.delta.dy < -sensitivity) {
                // Up Swipe
                if (alignment == Alignment.topCenter) {
                  dismissAllToast(showAnim: true);
                }
              }
            }),
        context: context,
        animation: StyledToastAnimation.slideFromBottom,
        reverseAnimation: StyledToastAnimation.slideToBottom,
        endOffset: alignment == Alignment.bottomCenter
            ? const Offset(0.0, 0.2)
            : const Offset(0.0, 0.0),
        startOffset: alignment == Alignment.bottomCenter
            ? const Offset(0.0, 2.0)
            : const Offset(0.0, -1.0),
        reverseEndOffset: alignment == Alignment.bottomCenter
            ? const Offset(0.0, 2.0)
            : const Offset(0.0, -1.0),
        position: alignment == Alignment.bottomCenter
            ? StyledToastPosition.bottom
            : alignment == Alignment.topCenter
                ? StyledToastPosition.top
                : StyledToastPosition.center,
        isIgnoring: false,
        alignment: alignment,
        axis: Axis.vertical,
        textDirection: TextDirection.ltr,
        animDuration: const Duration(milliseconds: 500),
        duration: Duration.zero,
        curve: Curves.linearToEaseOut,
        reverseCurve: Curves.fastOutSlowIn);
  }

  void successToast(
      BuildContext context, String title, String message, Alignment alignment,
      {Duration? progressDuration, bool? counter}) {
    GlobalKey keyCircularProgress = GlobalKey();
    showToastWidget(
        GestureDetector(
          child: Container(
            height: MediaQuery.of(context).size.height / _heightDivider,
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            margin: const EdgeInsets.only(left: 5, right: 5),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              color: AppColor.greenColor,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RipplesAnimation(
                  color: AppColor.white,
                  size: 15,
                  child: Icon(
                    Icons.check_circle,
                    color: AppColor.greenColor,
                    size: 20.0,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Column(
                    mainAxisSize:
                        title.isNotEmpty ? MainAxisSize.max : MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 4,
                      ),
                      Visibility(
                        visible: title.isNotEmpty,
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.22,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.18,
                            ),
                            children: [
                              WidgetSpan(
                                child: Visibility(
                                  visible: counter ?? false,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 2),
                                    margin: const EdgeInsets.only(right: 5),
                                    child: CounterText(
                                        count: progressDuration != null
                                            ? progressDuration.inSeconds
                                            : 0),
                                    decoration: BoxDecoration(
                                      color: AppColor.redColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: message,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: CustomCircularProgressIndicator(
                    key: keyCircularProgress,
                    duration:
                        progressDuration ?? const Duration(milliseconds: 5500),
                  ),
                ),
              ],
            ),
          ),
          onLongPressStart: (details) {
            CustomCircularProgressIndicator widget = keyCircularProgress
                .currentWidget as CustomCircularProgressIndicator;
            widget.animationController?.stop();
          },
          onLongPressEnd: (details) {
            CustomCircularProgressIndicator widget = keyCircularProgress
                .currentWidget as CustomCircularProgressIndicator;
            widget.animationController?.forward();
          },
          onVerticalDragUpdate: (details) {
            int sensitivity = 8;
            if (details.delta.dy > sensitivity) {
              // Down Swipe
              if (alignment == Alignment.bottomCenter) {
                dismissAllToast(showAnim: true);
              }
            } else if (details.delta.dy < -sensitivity) {
              // Up Swipe
              if (alignment == Alignment.topCenter) {
                dismissAllToast(showAnim: true);
              }
            }
          },
        ),
        context: context,
        animation: StyledToastAnimation.slideFromBottom,
        reverseAnimation: StyledToastAnimation.slideToBottom,
        endOffset: alignment == Alignment.bottomCenter
            ? const Offset(0.0, 0.2)
            : const Offset(0.0, 0.0),
        startOffset: alignment == Alignment.bottomCenter
            ? const Offset(0.0, 2.0)
            : const Offset(0.0, -1.0),
        reverseEndOffset: alignment == Alignment.bottomCenter
            ? const Offset(0.0, 2.0)
            : const Offset(0.0, -1.0),
        position: alignment == Alignment.bottomCenter
            ? StyledToastPosition.bottom
            : alignment == Alignment.topCenter
                ? StyledToastPosition.top
                : StyledToastPosition.center,
        isIgnoring: false,
        alignment: alignment,
        axis: Axis.vertical,
        textDirection: TextDirection.ltr,
        animDuration: const Duration(milliseconds: 500),
        duration: Duration.zero,
        curve: Curves.linearToEaseOut,
        reverseCurve: Curves.fastOutSlowIn);
  }

  void infoToast(
      BuildContext context, String title, String message, Alignment alignment,
      {Duration? progressDuration, bool? counter}) {
    final keyCircularProgress = GlobalKey();
    showToastWidget(
        GestureDetector(
            child: Container(
              height: MediaQuery.of(context).size.height / _heightDivider,
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0),
              margin: const EdgeInsets.only(left: 5, right: 5),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color: AppColor.blueColor,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const RipplesAnimation(
                    color: AppColor.primaryColor,
                    size: 15,
                    child: Icon(
                      Icons.info,
                      color: AppColor.white,
                      size: 20.0,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Column(
                      mainAxisSize: title.isNotEmpty
                          ? MainAxisSize.max
                          : MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          height: 4,
                        ),
                        Visibility(
                          visible: title.isNotEmpty,
                          child: Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.22,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                              // style: TextStyles(context).toasterMessage,
                              children: [
                                WidgetSpan(
                                  child: Visibility(
                                    visible: counter ?? false,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2, vertical: 2),
                                      margin: const EdgeInsets.only(right: 5),
                                      child: CounterText(
                                          count: progressDuration != null
                                              ? progressDuration.inSeconds
                                              : 0),
                                      decoration: BoxDecoration(
                                        color: AppColor.redColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                ),
                                TextSpan(
                                  text: message,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: CustomCircularProgressIndicator(
                      key: keyCircularProgress,
                      duration: progressDuration ??
                          const Duration(milliseconds: 5500),
                    ),
                  ),
                ],
              ),
            ),
            onLongPressStart: (details) {
              CustomCircularProgressIndicator widget = keyCircularProgress
                  .currentWidget as CustomCircularProgressIndicator;
              widget.animationController?.stop();
            },
            onLongPressEnd: (details) {
              CustomCircularProgressIndicator widget = keyCircularProgress
                  .currentWidget as CustomCircularProgressIndicator;
              widget.animationController?.forward();
            },
            onVerticalDragUpdate: (details) {
              int sensitivity = 8;
              if (details.delta.dy > sensitivity) {
                // Down Swipe
                if (alignment == Alignment.bottomCenter) {
                  dismissAllToast(showAnim: true);
                }
              } else if (details.delta.dy < -sensitivity) {
                // Up Swipe
                if (alignment == Alignment.topCenter) {
                  dismissAllToast(showAnim: true);
                }
              }
            }),
        context: context,
        animation: StyledToastAnimation.slideFromBottom,
        reverseAnimation: StyledToastAnimation.slideToBottom,
        endOffset: alignment == Alignment.bottomCenter
            ? const Offset(0.0, 0.2)
            : const Offset(0.0, 0.0),
        startOffset: alignment == Alignment.bottomCenter
            ? const Offset(0.0, 2.0)
            : const Offset(0.0, -1.0),
        reverseEndOffset: alignment == Alignment.bottomCenter
            ? const Offset(0.0, 2.0)
            : const Offset(0.0, -1.0),
        position: alignment == Alignment.bottomCenter
            ? StyledToastPosition.bottom
            : alignment == Alignment.topCenter
                ? StyledToastPosition.top
                : StyledToastPosition.center,
        isIgnoring: false,
        alignment: alignment,
        axis: Axis.vertical,
        textDirection: TextDirection.ltr,
        animDuration: const Duration(milliseconds: 500),
        duration: Duration.zero,
        curve: Curves.linearToEaseOut,
        reverseCurve: Curves.fastOutSlowIn);
  }

  void warningToast(
      BuildContext context, String title, String message, Alignment alignment,
      {Duration? progressDuration, bool? counter}) {
    final keyCircularProgress = GlobalKey();
    showToastWidget(
      GestureDetector(
          child: Container(
            height: MediaQuery.of(context).size.height / _heightDivider,
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0),
            margin: const EdgeInsets.only(left: 5, right: 5),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              color: AppColor.yellowColor,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const RipplesAnimation(
                  color: AppColor.white,
                  size: 15,
                  child: Icon(
                    Icons.warning,
                    color: AppColor.yellowColor,
                    size: 20.0,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Column(
                    mainAxisSize:
                        title.isNotEmpty ? MainAxisSize.max : MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 4,
                      ),
                      Visibility(
                        visible: title.isNotEmpty,
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.22,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.18,
                            ),
                            children: [
                              WidgetSpan(
                                child: Visibility(
                                  visible: counter ?? false,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 2),
                                    margin: const EdgeInsets.only(right: 5),
                                    child: CounterText(
                                        count: progressDuration != null
                                            ? progressDuration.inSeconds
                                            : 0),
                                    decoration: BoxDecoration(
                                      color: AppColor.redColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: message,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: CustomCircularProgressIndicator(
                    key: keyCircularProgress,
                    duration:
                        progressDuration ?? const Duration(milliseconds: 5500),
                  ),
                ),
              ],
            ),
          ),
          onLongPressStart: (details) {
            CustomCircularProgressIndicator widget = keyCircularProgress
                .currentWidget as CustomCircularProgressIndicator;
            widget.animationController?.stop();
          },
          onLongPressEnd: (details) {
            CustomCircularProgressIndicator widget = keyCircularProgress
                .currentWidget as CustomCircularProgressIndicator;
            widget.animationController?.forward();
          },
          onVerticalDragUpdate: (details) {
            int sensitivity = 8;
            if (details.delta.dy > sensitivity) {
              // Down Swipe
              if (alignment == Alignment.bottomCenter) {
                dismissAllToast(showAnim: true);
              }
            } else if (details.delta.dy < -sensitivity) {
              // Up Swipe
              if (alignment == Alignment.topCenter) {
                dismissAllToast(showAnim: true);
              }
            }
          }),
      context: context,
      animation: StyledToastAnimation.slideFromBottom,
      reverseAnimation: StyledToastAnimation.slideToBottom,
      endOffset: alignment == Alignment.bottomCenter
          ? const Offset(0.0, 0.2)
          : const Offset(0.0, 0.0),
      startOffset: alignment == Alignment.bottomCenter
          ? const Offset(0.0, 2.0)
          : const Offset(0.0, -1.0),
      reverseEndOffset: alignment == Alignment.bottomCenter
          ? const Offset(0.0, 2.0)
          : const Offset(0.0, -1.0),
      position: alignment == Alignment.bottomCenter
          ? StyledToastPosition.bottom
          : alignment == Alignment.topCenter
              ? StyledToastPosition.top
              : StyledToastPosition.center,
      isIgnoring: false,
      alignment: alignment,
      axis: Axis.vertical,
      textDirection: TextDirection.ltr,
      animDuration: const Duration(milliseconds: 500),
      duration: Duration.zero,
      curve: Curves.linearToEaseOut,
      reverseCurve: Curves.fastOutSlowIn,
    );
  }
}
