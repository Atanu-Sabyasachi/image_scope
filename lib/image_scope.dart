import 'package:flutter/material.dart';
import 'package:image_scope/config/image_config.dart';
import 'package:image_scope/enum.dart';
import 'package:image_scope/src/image_preview_dialog.dart';

class ImageScope {
  /// Shows a modal image preview with the provided configuration.
  ///
  /// This method displays a full-screen dialog containing the specified images.
  /// You can customize various aspects of the preview through the provided
  /// configuration options.
  ///
  /// Example usage:
  /// ```dart
  /// final configuration = ImageScopeConfiguration(
  ///   imageUrls: imageUrls,
  ///   showDescription: true,
  ///   descriptions: descriptions,
  /// );
  ///
  /// ImageScope.show(
  ///   context: context,
  ///   configuration: configuration,
  ///   imageIndex: index,
  ///   imageType: ImageType.network,
  /// );
  ///
  /// ```
  /// [imageIndex] is required if you want to show the image that is clicked if there are more than one images especially in case of List or Grid view. (defaults to 0 i.e, 1st image will be shown by default)
  ///
  /// [ImageType] needs to be provided to handle both asset and network images.
  ///
  /// N.B. - All the image urls must be of the same type (network/asset).
  ///
  /// Args:
  ///   - [context]: The BuildContext of the widget that triggers the preview.
  ///
  ///   - [configuration]: An instance of [ImageScopeConfiguration] that defines the images and settings for the preview.
  ///
  ///   - [imageIndex]: The initial index of the image to be displayed. Defaults to 0.
  ///
  ///   - [transitionDuration]: The duration of the animation used when transitioning between images. Defaults to 3 seconds.
  ///
  ///   - [transitionCurve]: The curve used for the animation. Defaults to Curves.easeInOut.
  ///
  ///   - [showNavigationButtons]: Whether to show navigation buttons for switching between images. Defaults to false.
  ///
  ///   - [showPaginationDots]: Whether to show pagination dots indicating the number of images. Defaults to false.
  ///
  ///   - [enableZoomIn]: Whether to enable zooming into the images.
  ///
  ///   - [enableZoomOut]: Whether to enable zooming out the images.
  ///
  ///   - [imagePosition]: Determines the position of the image on the screen.
  ///
  ///   - [nextButtonColor]: The color of the next button.
  ///
  ///   - [previousButtonColor]: The color of the previous button.
  ///
  ///   - [previousButtonSize]: The size of the previous button.
  ///
  ///   - [nextButtonSize]: The size of the next button.
  ///
  ///   - [activeDotColor]: The color of the active pagination dot.
  ///
  ///   - [inactiveDotColor]: The color of the inactive pagination dots.
  ///
  ///   - [activeDotHeight]: The height of the active pagination dot.
  ///
  ///   - [activeDotWidth]: The width of the active pagination dot.
  ///
  ///   - [inactiveDotHeight]: The height of the inactive pagination dots.
  ///
  ///   - [inactiveDotWidth]: The width of the inactive pagination dots.
  ///
  ///   - [action]: A widget to display below the image preview.
  ///
  ///   - [imageType]: Type of image (asset or network)
  ///
  ///   - [transitionBuilder]: A custom builder function for the transition animation between images.
  static void show({
    required BuildContext context,
    required ImageScopeConfiguration configuration,
    required ImageType imageType,
    int imageIndex = 0,
    Duration transitionDuration = const Duration(seconds: 3),
    Curve transitionCurve = Curves.easeInOut,
    bool showNavigationButtons = false,
    bool showPaginationDots = false,
    Color? nextButtonColor,
    Color? previousButtonColor,
    Color? activeDotColor,
    Color? inactiveDotColor,
    double? activeDotHeight,
    double? activeDotWidth,
    double? inactiveDotHeight,
    double? inactiveDotWidth,
    double? previousButtonSize,
    double? nextButtonSize,
    Widget? action,
    bool? enableZoomOut,
    bool? enableZoomIn,
    Alignment? imagePosition,
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
          showDescription: configuration.showDescription ?? false,
          descriptions: configuration.descriptions,
          showNavigationButtons: showNavigationButtons,
          showPaginationDots: showPaginationDots,
          activeDotColor: activeDotColor,
          inactiveDotColor: inactiveDotColor,
          activeDotHeight: activeDotHeight,
          activeDotWidth: activeDotWidth,
          inactiveDotHeight: inactiveDotHeight,
          inactiveDotWidth: inactiveDotWidth,
          nextButtonColor: nextButtonColor,
          previousButtonColor: previousButtonColor,
          nextButtonSize: nextButtonSize,
          previousButtonSize: previousButtonSize,
          enableZoomIn: enableZoomIn,
          enableZoomOut: enableZoomOut,
          imagePosition: imagePosition,
          action: action,
        );
      },
      transitionBuilder: transitionBuilder ??
          (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, 1), // Start below the screen
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: transitionCurve,
                ),
              ),
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
