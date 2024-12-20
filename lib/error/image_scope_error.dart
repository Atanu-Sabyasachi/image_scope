/// A custom error class to handle image scope-related errors.
///
/// This class is used to represent errors that occur in the image scope feature. It
/// provides detailed error information including a message, context, and an optional
/// suggested solution.
///
/// ### Constructor Parameters:
/// - [message]: A required string that describes the error message.
/// - [context]: An optional string that provides additional context about the error.
/// - [solution]: An optional string that suggests a solution for resolving the error.
///
/// ### Example:
/// ```dart
/// throw ImageScopeError(
///   message: "Mismatch between image count and description count.",
///   context: "Description & Image Mismatch",
///   solution: "Ensure that the number of descriptions matches the number of images.",
/// );
/// ```
class ImageScopeError extends Error {
  final String message;
  final String? context;
  final String? solution;

  ImageScopeError({
    required this.message,
    this.context,
    this.solution,
  });

  @override
  String toString() {
    final StringBuffer sb = StringBuffer();

    sb.writeln('💥 Oops! Something went wrong! 💥');
    sb.writeln('🌟 Context: ${context ?? 'Unknown'}');
    sb.writeln('🔴 Error: $message');

    if (solution != null) {
      sb.writeln('🛠️ Suggested Solution: $solution');
    }

    sb.writeln('🔧 Please check your setup and try again!');

    return sb.toString();
  }
}
