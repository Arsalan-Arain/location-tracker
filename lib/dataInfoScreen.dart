import 'package:flutter/material.dart';
import 'package:location_tracker/dataHandler.dart';

class LocationData extends StatefulWidget {
  const LocationData({Key? key}) : super(key: key);

  @override
  _LocationDataState createState() => _LocationDataState();
}

class _LocationDataState extends State<LocationData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location Data"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Text('${ListOfDataPoints.getData()}'),
        ),
      ),
    );
  }
}
