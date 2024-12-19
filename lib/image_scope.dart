import 'package:flutter/material.dart';
import 'package:image_scope/config/image_config.dart';
import 'package:image_scope/enum.dart';
import 'package:image_scope/src/image_preview_dialog.dart';

/// ImageScope is a customizable Flutter package designed to provide an intuitive and visually appealing
/// interface for previewing images in a full-screen modal. It supports advanced features like zoom, swipe navigation,
/// descriptions, pagination dots, navigation buttons, and more. This package is ideal for applications
/// requiring image galleries or detailed image exploration.
class ImageScope {
  /// Shows a modal image preview with the provided configuration.
  ///
  /// This method displays a full-screen dialog containing the specified images.
  /// You can customize various aspects of the preview through the provided
  /// configuration options.
  ///
  ///   - [context]: The BuildContext of the widget that triggers the preview.
  ///
  ///   - [configuration]: An instance of [ImageScopeConfiguration] that defines the images and settings for the preview.
  ///
  ///   - [imageIndex (optional)]: The initial index of the image to be displayed. Defaults to 0.
  ///
  ///   - [enableZoom (optional)]: Whether to enable zooming on the images. Defaults to false.
  ///
  ///   - [transitionDuration (optional)]: The duration of the animation used when transitioning between images. Defaults to 3 seconds.
  ///
  ///   - [transitionCurve (optional)]: The curve used for the animation. Defaults to Curves.easeInOut.
  ///
  ///   - [showNavigationButtons (optional)]: Whether to show navigation buttons for switching between images. Defaults to false.
  ///
  ///   - [showPaginationDots (optional)]: Whether to show pagination dots indicating the number of images. Defaults to false.
  ///
  ///   - [enableSwipe (optional)]: Whether to enable swiping to navigate between images. Defaults to true.
  ///
  ///   - [nextButtonColor (optional)]: The color of the next button.
  ///
  ///   - [previousButtonColor (optional)]: The color of the previous button.
  ///
  ///   - [activeDotColor (optional)]: The color of the active pagination dot.
  ///
  ///   - [inactiveDotColor (optional)]: The color of the inactive pagination dots.
  ///
  ///   - [activeDotHeight (optional)]: The height of the active pagination dot.
  ///
  ///   - [activeDotWidth (optional)]: The width of the active pagination dot.
  ///
  ///   - [inactiveDotHeight (optional)]: The height of the inactive pagination dots.
  ///
  ///   - [inactiveDotWidth (optional)]: The width of the inactive pagination dots.
  ///
  ///   - [action (optional)]: A widget to display below the image preview.
  ///
  ///   - [imageType]: Type of image (asset or network)
  ///
  ///   - [transitionBuilder (optional)]: A custom builder function for the transition animation between images.
  static void show({
    required BuildContext context,
    required ImageScopeConfiguration configuration,
    required ImageType imageType,
    int imageIndex = 0,
    bool enableZoom = false,
    Duration transitionDuration = const Duration(seconds: 3),
    Curve transitionCurve = Curves.easeInOut,
    bool showNavigationButtons = false,
    bool showPaginationDots = false,
    bool enableSwipe = true,
    Color? nextButtonColor,
    Color? previousButtonColor,
    Color? activeDotColor,
    Color? inactiveDotColor,
    double? activeDotHeight,
    double? activeDotWidth,
    double? inactiveDotHeight,
    double? inactiveDotWidth,
    Widget? action,
    Widget Function(
      BuildContext context,
      Animation<double> animation1,
      Animation<double> animation2,
      Widget child,
    )? transitionBuilder,
  }) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return ImagePreviewDialog(
          imageUrls: configuration.imageUrls,
          initialIndex: imageIndex,
          imageType: imageType,
          enableZoom: enableZoom,
          showDescription: configuration.showDescription ?? false,
          descriptions: configuration.descriptions,
          showNavigationButtons: showNavigationButtons,
          showPaginationDots: showPaginationDots,
          enableSwipeGesture: enableSwipe,
          activeDotColor: activeDotColor,
          inactiveDotColor: inactiveDotColor,
          activeDotHeight: activeDotHeight,
          activeDotWidth: activeDotWidth,
          inactiveDotHeight: inactiveDotHeight,
          inactiveDotWidth: inactiveDotWidth,
          nextButtonColor: nextButtonColor,
          previousButtonColor: previousButtonColor,
          action: action,
          customBackground: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(0, 0, 0, 0.6),
                Colors.transparent,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        );
      },
      transitionBuilder: transitionBuilder ??
          (context, animation, secondaryAnimation, child) {
            // Custom transition with slide-in effect
            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, 1), // Start below the screen
                end: Offset.zero,
              ).animate(
                  CurvedAnimation(parent: animation, curve: transitionCurve)),
              child: FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: animation,
                  child: child,
                ),
              ),
            );
          },
      transitionDuration: transitionDuration,
    );
  }
}
