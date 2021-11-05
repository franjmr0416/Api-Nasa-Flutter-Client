import 'dart:convert';

import 'package:practica5/models/photo_model.dart';
import 'package:http/http.dart' as http;

class ApiNasa {
  Future<List<PhotoModel>?> getPhotos(String fecha) async {
    var endpoint = Uri.parse(
        "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=$fecha&api_key=ZovynGDAM42pRHah9TylSXIVCRCgAtA2AXE3a0c7");
    final response = await http.get(endpoint);
    if (response.statusCode == 200) {
      var photos = jsonDecode(response.body)['photos'] as List;
      List<PhotoModel> listPhoto =
          photos.map((map) => PhotoModel.fromMap(map)).toList();

      return listPhoto;
    } else {
      return null;
    }
  }
}
