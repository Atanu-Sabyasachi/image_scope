## Support Me

<a href="https://www.buymeacoffee.com/AtanuSabyasachi"><img src="https://img.buymeacoffee.com/button-api/?text=Buy me a coffee&emoji=&slug=AtanuSabyasachi&button_colour=FFDD00&font_colour=000000&font_family=Poppins&outline_colour=000000&coffee_colour=ffffff" />
</a>

`Image Scope` is a Flutter package designed for viewing images in a gallery format with advanced customization options. It includes zooming capabilities, pagination dots, navigation buttons, and optional descriptions for each image. This package is ideal for creating immersive image-viewing experiences in your Flutter applications.

---

## Table of Contents

1. [Installation](#installation)
2. [Usage](#usage)
3. [Key Features](#key-features)
4. [Available Properties](#available-properties)
5. [Important Notes](#important-notes)
<a href="#important-notes"></a>

6. [Contributing](#contributing)
7. [License](#license)

---

## Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  image_scope: ^1.0.0
```

## Usage
Basic Implementation
To use Image Scope, import the package and create an image preview dialog:

```dart
import 'package:flutter/material.dart';
import 'package:image_scope/image_scope.dart';

void showImagePreview(BuildContext context) {
  final configuration = ImageScopeConfiguration(
    imageUrls: imageUrls,
    showDescription: true,
    descriptions: descriptions,
  );

  ImageScope.show(
    context: context,
    imageType: ImageType.network,
    configuration: configuration,
    imageIndex: index, // Ensure index is defined
    activeDotColor: Colors.white,
    inactiveDotColor: Colors.grey,
    activeDotHeight: 5,
    activeDotWidth: 5,
    inactiveDotHeight: 2,
    inactiveDotWidth: 2,
    nextButtonColor: Colors.white,
    previousButtonColor: Colors.white,
    nextButtonSize: 40,
    previousButtonSize: 40,
    showPaginationDots: true,
    showNavigationButtons: true,
    action: Row(
      children: [
        IconButton(
          onPressed: () async {},
          icon: Icon(
            Icons.share,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          onPressed: () async {},
          icon: Icon(
            Icons.download_rounded,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ],
    ),
    transitionDuration: Duration(milliseconds: 400),
    transitionCurve: Curves.easeOutQuart,
  );
}
```

## Key Features
- **Image Gallery View**: Display multiple images in a swipeable gallery.
- **Zoom Functionality**: Zoom in and out of images with smooth scaling.
- **Navigation Buttons**: Easily move between images with previous and next buttons.
- **Pagination Dots**: Show the current image index with customizable dots.
- **Image Descriptions**: Provide descriptive text for each image.
- **Customizable UI**: Adjust colors, sizes, and alignments for buttons and indicators.

## Available Properties

### ImageScopeConfiguration Properties

| Property            | Type             | Description                                      | Default         |
|---------------------|------------------|--------------------------------------------------|-----------------|
| `imageUrls`         | `List<String>`   | A required list of image URLs to display.        | **Required**    |
| `descriptions`      | `List<String>?`  | An optional list of descriptions for the images. | `null`          |
| `showDescription`   | `bool?`          | Whether to show descriptions of the images.      | `false`         |

### ImageSCope properties

| Property              | Type              | Description                                                   | Default         |
|-----------------------|-------------------|---------------------------------------------------------------|-----------------|
| `configuration`       | `List<String>`    | Image configuration including `imageUrls`, `descriptions` and `showDescription`| **Required**    |
| `imageUrls`           | `List<String>`    | List of image URLs to display.                                | **Required**    |
| `initialIndex`        | `int`             | The starting index for the image gallery.                     | `0`             |
| `imageType`           | `ImageType`       | The type of image (`ImageType.network` or `ImageType.asset`). | **Required**    |
| `showDescription`     | `bool`            | Whether to show descriptions below the images.                | `false`         |
| `descriptions`        | `List<String>?`   | Optional list of descriptions for the images.                 | `null`          |
| `showNavigationButtons`| `bool`           | Whether to show navigation buttons (Previous and Next).       | `false`         |
| `showPaginationDots`  | `bool`            | Whether to display pagination dots below the gallery.         | `false`         |
| `nextButtonColor`     | `Color?`          | Color of the "Next" button.                                   | `Colors.white`  |
| `previousButtonColor` | `Color?`          | Color of the "Previous" button.                               | `Colors.white`  |
| `activeDotColor`      | `Color?`          | Color of the active pagination dot.                           | `Colors.red`    |
| `inactiveDotColor`    | `Color?`          | Color of the inactive pagination dots.                        | `Colors.white`  |
| `activeDotWidth`      | `double?`         | Width of the active pagination dot.                           | `12.0`          |
| `activeDotHeight`     | `double?`         | Height of the active pagination dot.                          | `12.0`          |
| `inactiveDotWidth`    | `double?`         | Width of the inactive pagination dots.                        | `8.0`           |
| `inactiveDotHeight`   | `double?`         | Height of the inactive pagination dots.                       | `8.0`           |
| `enableZoomIn`        | `bool?`           | Whether zooming in is enabled for the images.                 | `false`         |
| `enableZoomOut`       | `bool?`           | Whether zooming out is enabled for the images.                | `false`         |
| `imagePosition`       | `Alignment?`      | Alignment of the image in the preview dialog.                 | `Alignment.center`|
| `action`              | `Widget?`         | A custom widget (e.g., a close button) displayed in the top-right corner. | `null`|

<h2 id="important-notes" style="color: #FF5733;">Important Notes</h2>
1. **imageUrls should contain URLs of the same type**  
   The `imageUrls` list in the configuration must contain URLs of the same type, either all assets or all network URLs. You cannot mix both asset and network URLs in the same list.

2. **Handling Descriptions**  
   If you don't have any descriptions for all your images, you can either:
   - Leave the respective description empty

   <br>**Example**
   ```dart
    final List<String> descriptions = [
      'Desc. 1',
      '',
      'Desc. 3',
      'Desc. 4',
    ];
   ```
    Basically length of both imageUrls and description list should be same.

    <br>**OR**

   - Pass `null` as the entire description list.

3. **Image Index and Default Image Display**  
   If you want to show the image that was clicked, the `imageIndex` is required in the configuration. By default, the `imageIndex` is set to `0`, which means the first image will always be opened first. To display a specific image, make sure to pass the correct `imageIndex`.


## Contributing
Contributions are welcome! If you find bugs or have feature suggestions, feel free to create an issue or submit a pull request. Make sure to follow the contribution guidelines.

- Report bugs and request features via [GitHub Issues](https://github.com/Atanu-Sabyasachi/image_scope/issues)
- Engage in discussions and help users solve their problems/questions in the [Discussions](https://github.com/discussions)

## License
This package is licensed under the MIT License. See the LICENSE file for more details.

Happy coding! 🚀

This `README.md` covers installation, usage, features, property descriptions, and customization, making it beginner-friendly and informative for all users of the package.

-------------------------------------------------------------

**Version**: 1.0.0  
**Author**: Atanu Sabyasachi Jena  
**License**: MIT




