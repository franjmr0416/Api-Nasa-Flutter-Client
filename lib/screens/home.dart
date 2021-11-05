import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:practica5/screens/catalog.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String nasaLogo = 'assets/nasa-6.svg';
  var _currentSelectDate = DateTime.now();

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
      body: Stack(alignment: AlignmentDirectional(0, 0), children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bgMars2.png'),
                  fit: BoxFit.fitHeight)),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: SvgPicture.asset(
                nasaLogo,
                width: 150,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 280),
              child: Text(
                '¡Conoce el paisaje marciano!, mediante las fotografías capturadas por el Rover Curiosity, selecciona una fecha para ver la galería de fotografías.',
                textAlign: TextAlign.justify,
                style: TextStyle(color: Colors.white, fontSize: 20, shadows: [
                  Shadow(
                      color: Colors.black87,
                      offset: Offset(0, 1),
                      blurRadius: 5)
                ]),
              ),
            ),
            ElevatedButton.icon(
                onPressed: callDatePicker,
                icon: FaIcon(FontAwesomeIcons.calendarPlus),
                label: Text(
                  'Seleccionar Fecha',
                  style: TextStyle(fontSize: 17),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[900],
                  fixedSize: Size.fromWidth(300),
                )),
            ElevatedButton.icon(
                onPressed: () {
                  Get.to(CatalogScreen(), arguments: _currentSelectDate);
                },
                icon: FaIcon(FontAwesomeIcons.rocket),
                label: Text('Ver', style: TextStyle(fontSize: 17)),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[900],
                  fixedSize: Size.fromWidth(300),
                )),
          ],
        ),
      ]),
    );
  }

  Future<DateTime?> _dateInput() {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 1)),
      firstDate: DateTime(2012, 08, 06),
      lastDate: DateTime.now().subtract(const Duration(days: 1)),
      helpText: 'Fecha de captura',
    );
  }

  void callDatePicker() async {
    var selectedDate = await _dateInput();
    if (selectedDate != null) {
      setState(() {
        _currentSelectDate = selectedDate;
      });
    }
  }
}
