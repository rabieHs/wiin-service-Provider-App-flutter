import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:wiin/services/works_services.dart';
import 'package:wiin/widgets/custom_text_input_field.dart';
import 'package:wiin/widgets/rounded_button.dart';

import '../services/image_picker.dart';

class AddWorkScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddWorkScreen({Key? key}) : super(key: key);

  @override
  State<AddWorkScreen> createState() => _AddWorkScreenState();
}

class _AddWorkScreenState extends State<AddWorkScreen> {
  final TextEditingController workNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    workNameController.dispose();
    descriptionController.dispose();
  }

  String category = 'Mobiles';
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();
  WorksServices worksServices = WorksServices();

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  void uploadPost() {
    worksServices.uploadWork(
        title: workNameController.text,
        description: descriptionController.text,
        images: images,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map((i) {
                          return Builder(
                              builder: (BuildContext context) => Image.file(
                                    i,
                                    fit: BoxFit.cover,
                                    height: 200,
                                  ));
                        }).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 200,
                        ))
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Select Product Images',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade400),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 30,
                ),
                CustomTextInputField(
                    textEditingController: workNameController,
                    isPass: false,
                    hintText: 'work title',
                    textInputType: TextInputType.text),
                const SizedBox(
                  height: 10,
                ),
                CustomTextInputField(
                    textEditingController: descriptionController,
                    isPass: false,
                    hintText: 'work description',
                    textInputType: TextInputType.text),
                const SizedBox(
                  height: 10,
                ),
                RoundedButton(
                  name: 'upload',
                  height: 50,
                  width: 500,
                  onPressed: uploadPost,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
