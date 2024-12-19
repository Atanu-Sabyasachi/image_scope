import 'package:flutter/material.dart';
import 'package:image_scope/enum.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

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

  /// - [enableZoom]: A flag that determines whether zooming functionality is enabled.
  final bool enableZoom;

  /// - [showDescription]: A flag that determines whether image descriptions should be shown.
  final bool showDescription;

  /// - [descriptions]: An optional list of descriptions corresponding to the images.
  final List<String>? descriptions;

  /// - [showNavigationButtons]: A flag that determines whether navigation buttons are displayed.
  final bool showNavigationButtons;

  /// - [showPaginationDots]: A flag that determines whether pagination dots are shown at the bottom.
  final bool showPaginationDots;

  /// - [enableSwipeGesture]: A flag to enable swipe gestures to navigate between images.
  final bool enableSwipeGesture;

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

  /// - [customBackground]: The custom background decoration for the gallery view.
  final BoxDecoration customBackground;

  /// - [initialIndex]: The initial index of the image to be displayed.
  final int initialIndex;

  /// - []: Type of image (asset or network)
  final ImageType imageType;

  /// - [action]: An optional widget that can be displayed as an action button in the top right corner.
  final Widget? action;

  const ImagePreviewDialog({
    super.key,
    required this.imageUrls,
    required this.enableZoom,
    required this.showDescription,
    this.descriptions,
    required this.showNavigationButtons,
    required this.showPaginationDots,
    this.enableSwipeGesture = true,
    this.nextButtonColor,
    this.previousButtonColor,
    this.activeDotColor,
    this.inactiveDotColor,
    this.activeDotHeight,
    this.activeDotWidth,
    this.inactiveDotHeight,
    this.inactiveDotWidth,
    required this.customBackground,
    required this.initialIndex,
    this.action,
    required this.imageType,
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
          // Background container with the custom background decoration
          Container(
            decoration: widget.customBackground,
          ),
          GestureDetector(
            // Gesture detection for swipe navigation between images
            onPanUpdate: widget.enableSwipeGesture
                ? (details) {
                    if (details.primaryDelta! < -10 &&
                        _currentIndex < widget.imageUrls.length - 1) {
                      setState(() {
                        _currentIndex++;
                      });
                    } else if (details.primaryDelta! > 10 &&
                        _currentIndex > 0) {
                      setState(() {
                        _currentIndex--;
                      });
                    }
                  }
                : null,
            child: PhotoViewGallery.builder(
              itemCount: widget.imageUrls.length,
              builder: (context, index) {
                // Build each photo view page
                return PhotoViewGalleryPageOptions(
                  imageProvider: widget.imageType == ImageType.network
                      ? NetworkImage(widget.imageUrls[index])
                      : AssetImage('assets/images/hello.png'),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: widget.enableZoom
                      ? PhotoViewComputedScale.covered * 2.0
                      : PhotoViewComputedScale.contained,
                );
              },
              pageController:
                  _pageController, // Page controller with initial index
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          // Navigation buttons for "Previous" and "Next"
          if (widget.showNavigationButtons)
            Positioned(
              left: 10,
              top: MediaQuery.of(context).size.height / 2 - 30,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: widget.previousButtonColor ?? Colors.white,
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
          if (widget.showNavigationButtons)
            Positioned(
              right: 10,
              top: MediaQuery.of(context).size.height / 2 - 30,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: widget.nextButtonColor ?? Colors.white,
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
