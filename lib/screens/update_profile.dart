import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class StudentDetailsUpdateForm extends StatefulWidget {
  const StudentDetailsUpdateForm(
      {super.key,
      required this.studentDetailsList,
      required this.defaultImage});
  final dynamic studentDetailsList;
  final String defaultImage;
  @override
  State<StudentDetailsUpdateForm> createState() =>
      _StudentDetailsUpdateFormState();
}

class _StudentDetailsUpdateFormState extends State<StudentDetailsUpdateForm> {
  var pageLoading = false;

  File? _imageFile;
  File? pickedImage;

  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController alternateMobileController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //  print(widget.studentDetailsList);
    addressController.text =
        widget.studentDetailsList['street_address'].toString();
    cityController.text = widget.studentDetailsList['city'].toString();
    stateController.text = widget.studentDetailsList['state'].toString();
    pincodeController.text = widget.studentDetailsList['pin'].toString();
    mobileController.text = widget.studentDetailsList['mobile'].toString();
    alternateMobileController.text =
        widget.studentDetailsList['alternate_mobile'].toString();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      var pickedFile = File(pickedImage.path);

      croppImage(pickedFile);
    }
  }

  croppImage(File pickedFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      uiSettings: [
        AndroidUiSettings(
          lockAspectRatio: true,
          hideBottomControls: true,
          showCropGrid: false,
          toolbarTitle: 'Adjust',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          aspectRatioPresets: [CropAspectRatioPresetCustom()],
          initAspectRatio: CropAspectRatioPresetCustom(),
        ),
        IOSUiSettings(
          title: 'Adjust',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPresetCustom(), // IMPORTANT: iOS supports only one custom aspect ratio in preset list
          ],
        ),
      ],
    );
    if (croppedFile != null) {
      setState(() {
        _imageFile = File(croppedFile.path);
      });
    } else {
      return _imageFile = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return pageLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: const Text("Update Student Details"),
            ),
            body: ListView(
              children: [
                Builder(
                  builder: (BuildContext context) {
                    if (_imageFile != null) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        margin: const EdgeInsets.all(18.0),
                        padding: const EdgeInsets.all(20.0),
                        child: Image.file(
                          _imageFile!,
                          fit: BoxFit.fill,
                          width: 300,
                          height: 350,
                        ),
                      );
                    } else if (widget.defaultImage.toString().isNotEmpty) {
                      return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          margin: const EdgeInsets.all(18.0),
                          padding: const EdgeInsets.all(10.0),
                          child: Image.network(
                            width: 300,
                            height: 350,
                            widget.defaultImage,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.person,
                                size: 100,
                                color: Colors.white,
                              );
                            },
                          ));
                    } else {
                      return const Icon(
                        Icons.person,
                        size: 150,
                      );
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.black)),
                      onPressed: () {
                        _pickImage(ImageSource.gallery);
                      },
                      child: const Text(
                        'Gallery',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.black)),
                      onPressed: () {
                        _pickImage(ImageSource.camera);
                      },
                      child: const Text(
                        'Camera',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  title: TextFormField(
                    keyboardType: TextInputType.multiline,
                    controller: addressController,
                    //initialValue: widget.studentDetailsList['street_address'],
                    decoration: const InputDecoration(
                      label: Text("Address"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: TextFormField(
                    keyboardType: TextInputType.multiline,
                    controller: cityController,
                    decoration: const InputDecoration(
                      label: Text("City"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ),
                ListTile(
                  title: TextFormField(
                    keyboardType: TextInputType.multiline,
                    controller: stateController,
                    decoration: const InputDecoration(
                      label: Text("State"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: TextFormField(
                    controller: pincodeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text("PinCode"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: mobileController,
                    decoration: const InputDecoration(
                      label: Text("Mobile"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: alternateMobileController,
                    decoration: const InputDecoration(
                      label: Text("Alternate Mobile"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.black)),
                    onPressed: () {},
                    child: const Text(
                      "Submit Detail",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (7, 9);

  @override
  String get name => '7x9 (customized)';
}
