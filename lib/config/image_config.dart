import 'package:image_scope/error/image_scope_error.dart';

/// A configuration class for managing image URLs and their corresponding descriptions.
///
/// This class is used to configure the images and their optional descriptions for the
/// image scope feature. It ensures that the number of descriptions matches the number of
/// images when descriptions are provided, throwing an error if there is a mismatch.
///
/// ### Constructor Parameters:

///
/// ### Throws:
/// - [ImageScopeError] if [showDescription] is `true` and the length of [descriptions]
///   does not match the length of [imageUrls].
///
/// ### Example:
/// ```dart
/// ImageScopeConfiguration(
///   imageUrls: ['image1.jpg', 'image2.jpg'],
///   descriptions: ['Description for image 1', 'Description for image 2'],
///   showDescription: true,
/// );
/// ```
class ImageScopeConfiguration {
  /// - [imageUrls]: A list of image URLs that will be displayed in the image scope.
  final List<String> imageUrls;

  /// - [descriptions]: An optional list of descriptions corresponding to the images.
  ///   If provided, it must have the same length as the [imageUrls] list.
  final List<String>? descriptions;

  /// - [showDescription]: A boolean flag indicating whether descriptions should be shown.
  ///   Defaults to `false` if not provided.
  bool? showDescription = false;

  ImageScopeConfiguration({
    required this.imageUrls,
    this.descriptions,
    this.showDescription,
  }) {
    // If descriptions are enabled, check if their count matches the image count
    if (showDescription == true) {
      if (descriptions != null && descriptions!.length != imageUrls.length) {
        throw ImageScopeError(
          message:
              "Oops! The number of descriptions (${descriptions!.length}) doesn't match the number of images (${imageUrls.length}).",
          context: 'Description & Image Mismatch',
          solution:
              'Ensure that every image has a corresponding description, or leave descriptions null if not needed.',
        );
      }
    }
  }
}
