import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:practica5/api/api_nasa.dart';
import 'package:practica5/models/photo_model.dart';
import 'package:practica5/screens/details.dart';

class CatalogScreen extends StatefulWidget {
  CatalogScreen({Key? key}) : super(key: key);

  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final String nasaLogo = 'assets/nasa-6.svg';
  String fecha = Get.arguments.toString().substring(0, 10);

  ApiNasa? apiNasa;

  @override
  void initState() {
    super.initState();
    apiNasa = ApiNasa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[800],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                nasaLogo,
                height: 40,
              ),
              Padding(padding: EdgeInsets.only(left: 10)),
              Text('Mission Curiosity'),
            ],
          ),
        ),
        body: _futureGallery(fecha));
  }

  Widget _futureGallery(String fecha) {
    return FutureBuilder(
      future: apiNasa!.getPhotos(fecha),
      builder:
          (BuildContext context, AsyncSnapshot<List<PhotoModel>?> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Hay un error en la peticion'),
          );
        } else {
          if (snapshot.connectionState == ConnectionState.done) {
            return _gridView(snapshot.data);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      },
    );
  }

  Widget _gridView(List<PhotoModel>? photos) {
    print(photos!.length);
    if (photos != null) {
      if (photos.length > 0) {
        return GridView.builder(
          itemCount: photos.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            PhotoModel photo = photos[index];
            String? url = photo.img_src;
            print(photos.length);
            return (url == null)
                ? _iconError()
                : GestureDetector(
                    onTap: () {
                      Get.to(DetailScreen(),
                          arguments: photo, transition: Transition.zoom);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Image.network(
                        url,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
          },
        );
      } else {
        return _sinDatos();
      }
    } else {
      return _sinDatos();
    }
  }

  Widget _sinDatos() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.exclamationTriangle,
            color: Colors.grey,
            size: 60,
          ),
          SizedBox(
            height: 10,
          ),
          Text('No se encontraron fotografías para esta fecha')
        ],
      ),
    );
  }

  Widget _iconError() {
    return FaIcon(
      FontAwesomeIcons.exclamationTriangle,
      color: Colors.amber[700],
    );
  }
}
