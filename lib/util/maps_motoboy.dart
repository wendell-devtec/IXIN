import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'common.dart';


final loginData = LoginSingleton.loginData;
final storeName = loginData.loja;
final latitude = loginData.latitude;
final longitude = loginData.longitude;




// ignore: must_be_immutable
class MapsMotoboy extends StatefulWidget{

  String latnow;
  String longnow;
  String latnext;
  String longnext;

   MapsMotoboy({super.key, required this.latnow , required this.longnow , required this.latnext , required this.longnext});

  @override
  State<StatefulWidget> createState() => _StateMapsMotoboy();

}

class _StateMapsMotoboy extends State<MapsMotoboy> {

  late GoogleMapController mapController;
  late Position currentPosition;

  final Set<Marker> _markers = {};

  final Set<Polyline> _polylines = {};

  String distanceInMeters = '';

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _setPolylines() {
    List<LatLng> polylineCoordinates = [];

    polylineCoordinates.add(LatLng(double.parse(widget.latnow), double.parse(widget.longnow)));
    polylineCoordinates.add(LatLng(double.parse(widget.latnext), double.parse(widget.longnext)));

    setState(() {
      _polylines.add(Polyline(
          polylineId: const PolylineId('route1'),
          color: Colors.red,
          width: 5,
          points: polylineCoordinates));
    });
  }


  void _setMarkers() {
    _markers.add(
        Marker(
          markerId: const MarkerId('current'),
          position: LatLng(double.parse(widget.latnow), double.parse(widget.longnow)),
          infoWindow: InfoWindow(title: 'LOCAL DE SAIDA' , snippet: storeName),
        )
    );

    _markers.add(
        Marker(
          markerId: const MarkerId('destination'),
          position: LatLng(double.parse(widget.latnext), double.parse(widget.longnext)),
          infoWindow: InfoWindow(title: 'DESTINO' , snippet: storeName),
        )
    );
  }





  void _calculateDistance() async {
    double lat1 = double.parse(widget.latnow);
    double lon1 = double.parse(widget.longnow);
    double lat2 = double.parse(widget.latnext);
    double lon2 = double.parse(widget.longnext);

    String url = 'https://maps.googleapis.com/maps/api/directions/json?origin=$lat1,$lon1&destination=$lat2,$lon2&key=AIzaSyDpmfdMzey3-Jc9Z3KnEZyCxeDg753yKnI';

    http.Response response = await http.get(Uri.parse(url));

    Map<String, dynamic> data = jsonDecode(response.body);
    int distanceInMeters = data['routes'][0]['legs'][0]['distance']['value'];

    double distanceInKilometers = distanceInMeters / 1000;

    setState(() {
      this.distanceInMeters = '${distanceInKilometers.toStringAsFixed(1)} Km';
    });
  }

  @override
  void initState() {
    super.initState();

    _setMarkers();
    _setPolylines();
    _calculateDistance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text("ROTA ATUAL MOTOBOY", style: TextStyle(fontFamily: 'SuperCell' , fontSize: 20, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(double.parse(widget.latnow), double.parse(widget.longnow)),
              zoom: 12,
            ),
            mapType: MapType.normal,
            markers: _markers,
            polylines: _polylines,
          ),
          Positioned(
            bottom: 20,
            left: 10,
            child: Text(
              'DISTÂNCIA: $distanceInMeters',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

