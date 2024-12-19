import 'package:flutter/material.dart';
import 'package:image_scope/config/image_config.dart';
import 'package:image_scope/enum.dart';
import 'package:image_scope/image_scope.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ImagePreviewDemo(),
    );
  }
}

class ImagePreviewDemo extends StatelessWidget {
  const ImagePreviewDemo({super.key});

  @override
  Widget build(BuildContext context) {
    const imageUrls = [
      'https://images.unsplash.com/photo-1730979466254-91ca4a3123d8?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHw4fHx8ZW58MHx8fHx8',
      'https://images.unsplash.com/photo-1731429945593-61610daebc11?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwxMnx8fGVufDB8fHx8fA%3D%3D',
      'https://plus.unsplash.com/premium_photo-1668948635042-a7fa8b580600?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDR8fHxlbnwwfHx8fHw%3D',
      'https://images.unsplash.com/photo-1733151451032-54fb7bd4f43e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDMwfHx8ZW58MHx8fHx8',
      'https://images.unsplash.com/photo-1731860204050-9e48425e19d7?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDQyfHx8ZW58MHx8fHx8',
      'https://plus.unsplash.com/premium_photo-1675102292270-0b867e570b07?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDUxfHx8ZW58MHx8fHx8',
    ];

    final List<String> descriptions = [
      'Description 1',
      'Description 2',
      'Description 3',
      'Description 4',
      'Description 5',
      'Description 6',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('ImageScope Demo')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in the grid
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 1.0, // Adjust for square images
          ),
          itemCount: imageUrls.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Create configuration for ImageScope
                final configuration = ImageScopeConfiguration(
                  imageUrls: imageUrls,
                  showDescription: true,
                  descriptions: descriptions,
                );

                // Show the image preview dialog
                ImageScope.show(
                  context: context,
                  imageType: ImageType.network,
                  configuration: configuration,
                  imageIndex: index,
                  activeDotColor: Colors.green,
                  inactiveDotColor: const Color.fromARGB(255, 169, 248, 210),
                  activeDotHeight: 15,
                  activeDotWidth: 15,
                  nextButtonColor: Colors.blue,
                  previousButtonColor: Colors.blue,
                  enableZoom: true, // Enable zoom functionality
                  showPaginationDots: true, // Show pagination dots
                  showNavigationButtons: true, // Show navigation buttons
                  action: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.download,
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
                  enableSwipe:
                      false, // Enable swipe gesture for image navigation
                  transitionBuilder:
                      (context, animation, secondaryAnimation, child) {
                    // Custom transition with fade, scale, and rotation effects
                    var curvedAnimation = CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOut,
                    );

                    // Define the scale effect
                    var scaleAnimation = Tween<double>(begin: 0.8, end: 1.0)
                        .animate(curvedAnimation);

                    // Define the rotation effect
                    var rotationAnimation = Tween<double>(begin: -0.1, end: 0.0)
                        .animate(curvedAnimation);

                    return ScaleTransition(
                      scale: scaleAnimation,
                      child: RotationTransition(
                        turns: rotationAnimation,
                        child: FadeTransition(
                          opacity: curvedAnimation,
                          child: child,
                        ),
                      ),
                    );
                  },
                  transitionDuration:
                      Duration(milliseconds: 900), // Set transition duration
                  transitionCurve: Curves.easeInOut, // Set transition curve
                );
              },
              child: Image.network(
                imageUrls[index],
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}
