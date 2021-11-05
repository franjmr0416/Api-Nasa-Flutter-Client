import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica5/models/photo_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  PhotoModel detalles = Get.arguments;
  final String nasaLogo = 'assets/nasa-6.svg';

  @override
  Widget build(BuildContext context) {
    print(detalles.img_src);
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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[350],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Image.network(
                      detalles.img_src!,
                      width: 370,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 400, left: 10, right: 10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        offset: Offset(0, 3.0),
                        blurRadius: 3.0),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.image,
                        color: Colors.blue[900],
                      ),
                      Text(
                        'Fotografía Número: ${detalles.id.toString()}',
                        style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.sun,
                        color: Colors.blue[900],
                      ),
                      Text(
                        'Soles Transcurridos: ${detalles.sol.toString()}',
                        style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.globeAmericas,
                        color: Colors.blue[900],
                      ),
                      Text(
                        'Fecha Terrestre: ${detalles.earth_date}',
                        style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
