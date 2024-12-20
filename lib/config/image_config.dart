import 'package:image_scope/error/image_scope_error.dart';

/// A configuration class for managing image URLs and their corresponding descriptions.
///
/// This class is used to configure the images and their optional descriptions for the
/// image scope feature. It ensures that the number of descriptions matches the number of
/// images when descriptions are provided, throwing an error if there is a mismatch.
///
/// ### Constructor Parameters:
/// - **[imageUrls]**: A required list of image URLs to be displayed in the image scope.
///
/// - **[descriptions]**: An optional list of descriptions corresponding to the images.
///   If provided, it must have the same length as the [imageUrls] list.
///
/// - **[showDescription]**: A boolean flag indicating whether descriptions should be shown.
///   Defaults to `false` if not provided.
///
/// ### Throws:
/// - **[ImageScopeError]** if [showDescription] is `true` and the length of [descriptions]
///   does not match the length of [imageUrls]. An error message will be thrown to notify the mismatch.
///
/// ### Example:
/// ```dart
/// ImageScopeConfiguration(
///   imageUrls: ['image1.jpg', 'image2.jpg'],  // List of image URLs
///   descriptions: ['Description for image 1', 'Description for image 2'],  // Descriptions corresponding to each image
///   showDescription: true,  // Enabling description visibility
/// );
/// ```
///
/// ### Usage Notes:
/// - Ensure that the number of descriptions matches the number of images when [showDescription] is `true`.
/// - If no descriptions are required, either provide `null` for [descriptions] or omit it entirely.
class ImageScopeConfiguration {
  final List<String> imageUrls;
  final List<String>? descriptions;
  bool? showDescription = false;

  /// Creates a image configuration with optional descriptions.
  ///
  /// This constructor ensures that if descriptions are provided, their count must match the
  /// number of images in [imageUrls]. If [showDescription] is `true`, a mismatch will result
  /// in an [ImageScopeError].
  ///
  /// ### Parameters:
  /// - **[imageUrls]**: List of image URLs to be displayed.
  /// - **[descriptions]**: List of descriptions corresponding to the images (optional).
  /// - **[showDescription]**: Flag to toggle description visibility (optional).
  ImageScopeConfiguration({
    required this.imageUrls,
    this.descriptions,
    this.showDescription,
  }) {
    // Check if descriptions are enabled and validate the length
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
