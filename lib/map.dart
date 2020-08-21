import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class Map extends StatefulWidget {
  @override 
  _MapState createState() => _MapState(); 
}

class _MapState extends State<Map> {
   BitmapDescriptor pinLocationIcon;
 var position;
    Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'asets/destination_map_marker.png');
  }
  String _locationMessage = ""; 

  void _getCurrentLocation() async {

    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);

    setState(() {
      _locationMessage = "${position.latitude}, ${position.longitude}";
    });

  }

@override
void initState() {
  super.initState();
  setCustomMapPin();
}

@override
void dispose() {
  
  super.dispose();
}

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LatLng pinPosition = LatLng(position.latitude, position.longitude);
    
    // these are the minimum required values to set 
    // the camera position 
    CameraPosition initialLocation = CameraPosition(
        zoom: 20,
        bearing: 30,
         tilt: 59.440717697143555,
        target: pinPosition
    );
   return Scaffold(
          body: Stack(
        children: <Widget>[
          GoogleMap(
            myLocationEnabled: true,
            compassEnabled: true,
            //markers: _markers,
            
            initialCameraPosition: initialLocation,
            onMapCreated: (GoogleMapController controller) {
                setState(() {
                  _markers.add(
                      Marker(
                        draggable: true,
                        markerId: MarkerId('<MARKER_ID>'),
                        position: pinPosition,
                        icon: pinLocationIcon,
                        
                      )
                      
                  );
              });
            }
            ),
            
        ],
      ),
    );
  }
}