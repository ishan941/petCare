import 'package:flutter/material.dart';
import 'package:project_petcare/core/statusutil.dart';
import 'package:project_petcare/helper/constBread.dart';
import 'package:project_petcare/helper/helper.dart';
import 'package:project_petcare/helper/textStyle_const.dart';
import 'package:project_petcare/model/scanner.dart';
import 'package:project_petcare/provider/scanner_provider.dart';
import 'package:project_petcare/view/loader.dart';
import 'package:provider/provider.dart';

class DogHealth extends StatefulWidget {
  const DogHealth({super.key});

  @override
  State<DogHealth> createState() => _DogHealthState();
}

class _DogHealthState extends State<DogHealth> {
  late ScannerProvider scannerProvider;
  @override
  void initState() {
    super.initState();
    scannerProvider = Provider.of<ScannerProvider>(context, listen: false);
    getValue();
  }

  getValue() {
    scannerProvider.getTokenFromSharedPref();
  }

  @override
  void dispose() {
    // Clear selected symptoms when the page is disposed
    clear();
    super.dispose();
  }

  clear() {
    scannerProvider.clearSelectedSymptoms();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScannerProvider>(
      builder: (context, scannerProvider, child) => WillPopScope(
        onWillPop: () async {
          scannerProvider.clearImage();
          return true;
        },
        child: Scaffold(
          backgroundColor: ColorUtil.BackGroundColorColor,
          appBar: AppBar(
            backgroundColor: ColorUtil.BackGroundColorColor,
            title: const Text(
              'About health',
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
                      children: [
                        Column(
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
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: Wrap(
                                  spacing:
                                      5, // Set horizontal spacing between chips
                                  runSpacing:
                                      5, // Set vertical spacing between chips
                                  children: List.generate(
                                    symptomsList.length,
                                    (index) {
                                      final symptom = symptomsList[index];
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
                                        child: Chip(
                                          backgroundColor: scannerProvider
                                                  .selectedSymptoms
                                                  .contains(symptom)
                                              ? Colors.blue
                                              : Colors.white,
                                          label: Text(
                                            symptom,
                                            style: TextStyle(
                                              color: scannerProvider
                                                      .selectedSymptoms
                                                      .contains(symptom)
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height:
                        40, // Set a fixed height for the list of selected symptoms
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: scannerProvider.selectedSymptoms.length,
                      itemBuilder: (context, index) {
                        final symptom = scannerProvider.selectedSymptoms[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Chip(
                            label: Text(
                              symptom,
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors
                                .blue, // Set default color for selected symptoms
                            deleteIconColor:
                                Colors.white, // Set color for delete icon
                            onDeleted: () {
                              setState(() {
                                scannerProvider.selectedSymptoms
                                    .removeAt(index);
                              });
                            },
                          ),
                        );
                      },
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
                                "Please wait we are finding diseases that your dog is suffering from according to the provided symptoms",
                          ),
                        ),
                      );

                      // Send symptoms to API and wait for response
                      var response = await scannerProvider.sendSymptomesToApi();

                      // Close the loader screen
                      Navigator.pop(context);
                      // Check if the response is successful
                      if (scannerProvider.symptomesUtil == StatusUtil.success) {
                        if (response != null) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // Extract the list of diseases from the response
                              // List<dynamic> diseases = response['data'];
                              // Map<String, dynamic> responseData =
                              //     response['data'];
                              // List<dynamic> diseases = responseData['diseases'];
                              // Create a StringBuffer to build the content of the dialog
                              StringBuffer content = StringBuffer();

                              // Iterate over the list of diseases and add them with indices
                              for (int i = 0;
                                  i < scannerProvider.disease.length;
                                  i++) {
                                content.write(
                                    '${i + 1}. ${scannerProvider.disease[i]}');
                                if (i < scannerProvider.disease.length - 1) {
                                  content.write(
                                      '\n'); // Add a new line if not the last disease
                                }
                              }

                              return AlertDialog(
                                title: Text(
                                    "Your Dog may be suffering from following diseases :-"),
                                content: Text(content.toString()),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        scannerProvider.selectedSymptoms
                                            .clear();
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text("OK"),
                                  )
                                ],
                              );
                            },
                          );
                        } else {
                          // Display an error message
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Error"),
                                content:
                                    Text("Failed to send symptoms to API."),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("OK"),
                                  )
                                ],
                              );
                            },
                          );
                        }
                      } else if (scannerProvider.symptomesUtil ==
                          StatusUtil.error) {
                        Helper.snackBar("Failed", context);
                      }
                    },
                    child: Text("Submit"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
