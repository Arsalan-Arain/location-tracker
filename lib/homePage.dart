import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:location_tracker/dataInfoScreen.dart';
import 'package:location_tracker/mapPage.dart';
import 'dataHandler.dart';

class LocationApp extends StatefulWidget {
  const LocationApp({Key? key}) : super(key: key);

  @override
  _LocationAppState createState() => _LocationAppState();
}

class _LocationAppState extends State<LocationApp> {
  // this var contains location coordinates
  var locationMessage = "";
  late Timer _timer;
  bool tracker_controller = true;

  // this function will get the current location coordinates
  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;

    setState(() {
      locationMessage = "Latitude : $lat , Longitude : $long";
    });
  }

  void startTracking() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;

    ListOfDataPoints.addToList(lat, long);

    _timer = Timer.periodic(Duration(seconds: 15), (timer) async {
      if (tracker_controller == false) {
        _timer.cancel();
      }
      var currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      var lat1 = currentPosition.latitude;
      var long1 = currentPosition.longitude;
      ListOfDataPoints.addToList(lat1, long1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Location Services",
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              size: 50.0,
              color: Colors.blue,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Track User Location",
              style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15.0,
            ),
            // this text will contain location coordinates
            Text("$locationMessage"),
            SizedBox(
              height: 10.0,
            ),
            TextButton(
              onPressed: () {
                getCurrentLocation();
                startTracking();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green[400],
              ),
              child: Text(
                "Start",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
            TextButton(
              onPressed: () {
                tracker_controller = false;
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red[400],
              ),
              child: Text(
                "Stop",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return MapScreen();
                }));
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue[400],
              ),
              child: Text(
                "Show Map",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return LocationData();
                }));
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue[400],
              ),
              child: Text(
                "Show Data",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
            TextButton(
              onPressed: () {
                ListOfDataPoints.clearList();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red[400],
              ),
              child: Text(
                "Clear Data",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
