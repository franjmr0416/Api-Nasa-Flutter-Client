import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        backgroundColor: Colors.orange[700],
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
                  image: AssetImage('assets/bgMars.png'),
                  fit: BoxFit.fitHeight)),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton.icon(
                onPressed: callDatePicker,
                icon: FaIcon(FontAwesomeIcons.spaceShuttle),
                label: Text('Seleccionar Fecha')),
            ElevatedButton.icon(
                onPressed: () {},
                icon: FaIcon(FontAwesomeIcons.spaceShuttle),
                label: Text('Ver')),
          ],
        ),
      ]),
    );
  }

  Future<DateTime?> _dateInput() {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2022),
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
