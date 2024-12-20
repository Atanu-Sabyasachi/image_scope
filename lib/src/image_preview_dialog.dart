import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'package:image_scope/enum.dart';

/// A dialog that displays a gallery of images with various customization options.
///
/// The dialog allows users to swipe through images, zoom in, see descriptions,
/// and use navigation buttons. The images can be navigated using swipe gestures
/// or explicit navigation buttons.
///
/// Fields:

class ImagePreviewDialog extends StatefulWidget {
  /// - [imageUrls]: A list of URLs for the images to display in the gallery.
  final List<String> imageUrls;

  /// - [showDescription]: A flag that determines whether image descriptions should be shown.
  final bool showDescription;

  /// - [descriptions]: An optional list of descriptions corresponding to the images.
  final List<String>? descriptions;

  /// - [showNavigationButtons]: A flag that determines whether navigation buttons are displayed.
  final bool showNavigationButtons;

  /// - [showPaginationDots]: A flag that determines whether pagination dots are shown at the bottom.
  final bool showPaginationDots;

  /// - [enableZoomOut]: Setting it's value to true will enable user to zoom out the image.
  final bool? enableZoomOut;

  /// - [enableZoomIn]: Setting it's value to true will enable user to zoom into the image.
  final bool? enableZoomIn;

  /// - [imagePosition]: This will determine the position of the image on the screen.
  final Alignment? imagePosition;

  /// - [nextButtonColor]: The color of the "Next" navigation button.
  final Color? nextButtonColor;

  /// - [previousButtonColor]: The color of the "Previous" navigation button.
  final Color? previousButtonColor;

  /// - [activeDotColor]: The color of the active pagination dot.
  final Color? activeDotColor;

  /// - [inactiveDotColor]: The color of the inactive pagination dots.
  final Color? inactiveDotColor;

  /// - [activeDotHeight]: The height of the active pagination dot.
  final double? activeDotHeight;

  /// - [activeDotWidth]: The width of the active pagination dot.
  final double? activeDotWidth;

  /// - [inactiveDotHeight]: The height of the inactive pagination dot.
  final double? inactiveDotHeight;

  /// - [inactiveDotWidth]: The width of the inactive pagination dot.
  final double? inactiveDotWidth;

  /// - [inactiveDotWidth]: The width of the inactive pagination dot.
  final double? previousButtonSize;

  /// - [inactiveDotWidth]: The width of the inactive pagination dot.
  final double? nextButtonSize;

  /// - [initialIndex]: The initial index of the image to be displayed.
  final int initialIndex;

  /// - []: Type of image (asset or network)
  final ImageType imageType;

  /// - [action]: An optional widget that can be displayed as an action button in the top right corner.
  final Widget? action;

  /// A dialog that displays a gallery of images with various customization options.
  ///
  /// The dialog allows users to swipe through images, zoom in, see descriptions,
  /// and use navigation buttons. The images can be navigated using swipe gestures
  /// or explicit navigation buttons.
  ///
  ///
  /// Args:
  /// - [imageUrls]: A list of URLs for the images to display in the gallery.
  /// - [showDescription]: A flag that determines whether image descriptions should be shown.
  /// - [descriptions]: An optional list of descriptions corresponding to the images.
  /// - [showNavigationButtons]: A flag that determines whether navigation buttons are displayed.
  /// - [showPaginationDots]: A flag that determines whether pagination dots are shown at the bottom.
  /// - [enableZoomOut]: Setting its value to true will enable users to zoom out the image.
  /// - [enableZoomIn]: Setting its value to true will enable users to zoom into the image.
  /// - [imagePosition]: This will determine the position of the image on the screen.
  /// - [nextButtonColor]: The color of the "Next" navigation button.
  /// - [previousButtonColor]: The color of the "Previous" navigation button.
  /// - [activeDotColor]: The color of the active pagination dot.
  /// - [inactiveDotColor]: The color of the inactive pagination dots.
  /// - [activeDotHeight]: The height of the active pagination dot.
  /// - [activeDotWidth]: The width of the active pagination dot.
  /// - [inactiveDotHeight]: The height of the inactive pagination dot.
  /// - [inactiveDotWidth]: The width of the inactive pagination dot.
  /// - [previousButtonSize]: The size of the "Previous" navigation button.
  /// - [nextButtonSize]: The size of the "Next" navigation button.
  /// - [initialIndex]: The initial index of the image to be displayed.
  /// - [imageType]: Type of image (either `ImageType.asset` or `ImageType.network`).
  /// - [action]: An optional widget that can be displayed as an action button in the top right corner.

  const ImagePreviewDialog({
    super.key,
    required this.imageUrls,
    required this.showDescription,
    required this.initialIndex,
    required this.imageType,
    required this.showNavigationButtons,
    required this.showPaginationDots,
    this.descriptions,
    this.enableZoomOut,
    this.nextButtonColor,
    this.previousButtonColor,
    this.activeDotColor,
    this.inactiveDotColor,
    this.activeDotHeight,
    this.activeDotWidth,
    this.inactiveDotHeight,
    this.inactiveDotWidth,
    this.previousButtonSize,
    this.nextButtonSize,
    this.action,
    this.imagePosition,
    this.enableZoomIn,
  });

  @override
  State<ImagePreviewDialog> createState() => _ImagePreviewDialogState();
}

class _ImagePreviewDialogState extends State<ImagePreviewDialog> {
  late int _currentIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentIndex =
        widget.initialIndex; // Initialize with the passed initial index
    _pageController =
        PageController(initialPage: _currentIndex); // Set the initial page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            itemCount: widget.imageUrls.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: widget.imageType == ImageType.network
                    ? NetworkImage(widget.imageUrls[index])
                    : AssetImage(widget.imageUrls[index]),
                basePosition: widget.imagePosition ?? Alignment.center,
                minScale: (widget.enableZoomOut == true)
                    ? PhotoViewComputedScale.contained * .1
                    : PhotoViewComputedScale.contained * 1,
                maxScale: (widget.enableZoomIn == true)
                    ? PhotoViewComputedScale.contained * 2.5
                    : PhotoViewComputedScale.contained,
                errorBuilder: (context, error, stackTrace) =>
                    Center(child: Text('Failed to load image: $error')),
                heroAttributes: PhotoViewHeroAttributes(
                  tag: widget.imageUrls[index],
                  transitionOnUserGestures: true,
                ),
              );
            },
            pageController: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),

          if (widget.showNavigationButtons && _currentIndex > 0)
            Positioned(
              left: 10,
              top: MediaQuery.of(context).size.height / 2 - 25,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: widget.previousButtonColor ?? Colors.white,
                  size: widget.previousButtonSize ?? 15,
                ),
                onPressed: _currentIndex > 0
                    ? () {
                        setState(() {
                          _currentIndex--;
                        });
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    : null,
              ),
            ),
          if (widget.showNavigationButtons &&
              _currentIndex < widget.imageUrls.length - 1)
            Positioned(
              right: 10,
              top: MediaQuery.of(context).size.height / 2 - 25,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: widget.nextButtonColor ?? Colors.white,
                  size: widget.nextButtonSize ?? 15,
                ),
                onPressed: _currentIndex < widget.imageUrls.length - 1
                    ? () {
                        setState(() {
                          _currentIndex++;
                        });
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    : null,
              ),
            ),
          // Pagination dots to indicate the current image
          if (widget.showPaginationDots)
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.imageUrls.length, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: _currentIndex == index
                        ? (widget.activeDotWidth ?? 12)
                        : (widget.inactiveDotWidth ?? 8),
                    height: _currentIndex == index
                        ? (widget.activeDotHeight ?? 12)
                        : (widget.inactiveDotHeight ?? 8),
                    decoration: BoxDecoration(
                      color: _currentIndex == index
                          ? (widget.activeDotColor ?? Colors.red)
                          : (widget.inactiveDotColor ?? Colors.white),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
            ),
          // Description text shown at the bottom of the image gallery
          if (widget.showDescription && widget.descriptions != null)
            Positioned(
              bottom: 60,
              left: 10,
              right: 10,
              child: Text(
                widget.descriptions![_currentIndex],
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          // Custom action widget displayed in the top-right corner
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 10,
            child: widget.action ?? SizedBox(),
          ),
        ],
      ),
    );
  }
}
