import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wiin/data/Works_model.dart';
import 'package:wiin/providers/user_provider.dart';
import 'package:wiin/services/error_hundling.dart';
import 'package:http/http.dart' as http;

import '../consts/consts.dart';

class WorksServices {
  void uploadWork({
    required String title,
    required String description,
    required List<File> images,
    required BuildContext context,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      List<String> imagesUrl = [];
      final cloudinary = CloudinaryPublic('dgvyd70ml', 'ohvddsp6');
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(images[i].path, folder: 'works/$title'));
        imagesUrl.add(res.secureUrl);
      }
      WorksModel works = WorksModel(
          images: imagesUrl,
          title: title,
          content: description,
          userId: user.id);
      http.Response res = await http.post(Uri.parse('$uri/api/upload-works'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': user.token,
          },
          body: (works.toJson()));
      httpErrorHundle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Work added Successfully');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<WorksModel>> fetchWorks(
      {required BuildContext context, required String userId}) async {
    List<WorksModel> worksList = [];
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response res = await http.get(
          Uri.parse("$uri/api/fetch-works/$userId"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': user.token,
          });

      httpErrorHundle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              worksList.add(
                WorksModel.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    print('works: ${worksList}');
    return worksList;
  }
}
