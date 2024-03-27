import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/provider/scanner_provider.dart';
import 'package:project_petcare/view/loader.dart';
import 'package:provider/provider.dart';

@immutable
class AiScanner extends StatefulWidget {
  @override
  State<AiScanner> createState() => _AiScannerState();
}

class _AiScannerState extends State<AiScanner> {
  List<String> selectedSymptoms = [];
  List<String> symptomsList = [
    "Coughing",
    "Sneezing",
    "Lethargy",
    "Loss of Appetite",
    "Vomiting",
    "Diarrhea",
    "Fever",
    "Excessive Thirst",
    "Excessive Panting",
    "Difficulty Breathing",
    "Limping",
    "Excessive Drooling",
    "Blood in Urine",
    "Blood in Stool",
    "Swollen Joints",
    "Excessive Scratching",
    "Skin Rash",
    "Jaundice",
    "Weakness",
    "Collapse",
  ];

  String? symptoms, predictedDisease;

  @override
  Widget build(BuildContext context) {
    return Consumer<ScannerProvider>(
      builder: (context, scannerProvider, child) => WillPopScope(
        onWillPop: () async {
          // Clear the image when navigating back
          scannerProvider.clearImage();
          return true;
        },
        child: Scaffold(
          backgroundColor: ColorUtil.BackGroundColorColor,
          appBar: AppBar(
            backgroundColor: ColorUtil.BackGroundColorColor,
            title: const Text(
              'Dog Scanner',
              style: appBarTitle,
            ),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          "Select symptoms that your dog is suffering from",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          // height: 400,
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  3, // Adjust the number of columns as needed
                              crossAxisSpacing:
                                  10, // Adjust the horizontal spacing between items
                              mainAxisSpacing:
                                  10, // Adjust the vertical spacing between items
                            ),
                            shrinkWrap: true,
                            itemCount:symptomsList.length,
                            itemBuilder: (BuildContext context, int index) {
                              final symptom = symptomsList[index];

                              // Set different sizes for specific symptoms

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (scannerProvider.selectedSymptoms
                                        .contains(symptom)) {
                                      scannerProvider.selectedSymptoms
                                          .remove(symptom);
                                    } else {
                                      scannerProvider.selectedSymptoms
                                          .add(symptom);
                                    }
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: scannerProvider.selectedSymptoms
                                            .contains(symptom)
                                        ? Colors.blue
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.blue,
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      symptom,
                                      style: TextStyle(
                                        fontSize: 12, // Adjust as needed
                                        color: scannerProvider.selectedSymptoms
                                                .contains(symptom)
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FormLoader(
                                    customText:
                                        "Please wait we are finding diseases that your dog is suffering form according to the provided symptomes",
                                  )));
                      await scannerProvider.sendSymptomesToApi();
                      if (scannerProvider.scannerUtil == StatusUtil.success) {
                        // Helper.snackBar(successfullySavedStr, context);
                        // Navigator.pop(context);
                      } else {
// Helper.snackBar(message, context)
                        // Navigator.pop(context);
                      }
                    },
                    child: Text("Submit"),
                  ),
                  // SizedBox(height: 20),
                  // scannerProvider.image == null && scannerProvider.photo == null
                  //     ? Text("Please add a photo to identify the dog bread ")
                  //     : Column(
                  //         children: [
                  //           // Image container
                  //           ClipRRect(
                  //             borderRadius: BorderRadius.circular(15),
                  //             child: Container(
                  //               height: 300,
                  //               width: MediaQuery.of(context).size.width,
                  //               child: Transform.scale(
                  //                 scale:
                  //                     1.0, // Adjust the scale factor as needed
                  //                 child: scannerProvider.image != null
                  //                     ? Image.file(
                  //                         File(scannerProvider.image!.path),
                  //                         fit: BoxFit.cover,
                  //                       )
                  //                     : Image.file(
                  //                         File(scannerProvider.photo!.path),
                  //                         fit: BoxFit.cover,
                  //                       ),
                  //               ),
                  //             ),
                  //           ),
                  //           ElevatedButton(
                  //             onPressed: () {
                  //               // identifyDogBreed(scannerProvider);
                  //             },
                  //             child: Text("Identify Breed"),
                  //           ),
                  //         ],
                  //       ),
                ],
              ),
            ),
          ),
          floatingActionButton: ExpandableFab(
            distance: 90,
            children: [
              ActionButton(
                onPressed: () => pickImageFormCamera(scannerProvider),
                icon: const Icon(Icons.camera_alt_outlined),
              ),
              ActionButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FormLoader(
                                customText:
                                    "Please wait we are finding diseases that your dog is suffering form according to the provided symptomes",
                              )));
                  await scannerProvider.sendSymptomesToApi();
                  if (scannerProvider.scannerUtil == StatusUtil.success) {
                    // Helper.snackBar(successfullySavedStr, context);
                    // Navigator.pop(context);
                  } else {
// Helper.snackBar(message, context)
                    // Navigator.pop(context);
                  }
                },

                // pickImageFormGallery(scannerProvider),
                icon: const Icon(Icons.safety_check),
              ),
              ActionButton(
                onPressed: () => pickImageFormCamera(scannerProvider),
                icon: const Icon(Icons.camera_alt_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    this.initialOpen,
    required this.distance,
    required this.children,
  });

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56,
      height: 56,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.close,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 600),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            
            onPressed: _toggle,
            child: const Icon(
              Icons.pets,
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.onPressed,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.secondary,
      elevation: 4,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: theme.colorScheme.onSecondary,
      ),
    );
  }
}

pickImageFormGallery(ScannerProvider scannerProvider) async {
  var image = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (image == null) return;
  await scannerProvider.setImage(image);
}

pickImageFormCamera(ScannerProvider scannerProvider) async {
  var photo = await ImagePicker().pickImage(source: ImageSource.camera);
  if (photo == null) return;
  await scannerProvider.setPhoto(photo);
}
