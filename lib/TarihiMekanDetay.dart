import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'TarihiMekanBilgiKutu.dart';

class TarihiMekanDetay extends StatefulWidget {
  final String mekanAdi;

  const TarihiMekanDetay({required this.mekanAdi, Key? key}) : super(key: key);

  @override
  _TarihiMekanDetayState createState() => _TarihiMekanDetayState();
}

class _TarihiMekanDetayState extends State<TarihiMekanDetay> {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  Set<Polyline> _polylines = {};
  late LatLng _mekanKonum;
  bool _isMapTouched = false;

  @override
  void initState() {
    super.initState();
    _setMekanKonum();
    _getCurrentLocation();
  }

 void _setMekanKonum() {
  Map<String, LatLng> mekanKonumlari = {
    "Büyükada Rum Yetimhanesi": LatLng(40.8688, 29.1345),
    "Aya Yorgi Kilisesi": LatLng(40.8645, 29.1273),
    "Heybeliada Ruhban Okulu": LatLng(40.8742, 29.0897),
    "Kınalıada Camii": LatLng(40.8748, 29.0795),
    // Buraya diğer mekanları da ekleyebilirsin.
  };

  _mekanKonum = mekanKonumlari[widget.mekanAdi] ?? LatLng(41.0082, 28.9784);
}


  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) return;
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = position;
    });

    _fitMapToBounds();
    _getDirections();
  }

  Future<void> _getDirections() async {
    if (_currentPosition == null) return;

    final String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${_currentPosition!.latitude},${_currentPosition!.longitude}&destination=${_mekanKonum.latitude},${_mekanKonum.longitude}&key=YOUR_GOOGLE_MAPS_API_KEY";

    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);

    if (data['status'] == 'OK') {
      List<LatLng> polylineCoordinates = [];
      var steps = data['routes'][0]['legs'][0]['steps'];

      for (var step in steps) {
        polylineCoordinates.add(
          LatLng(step['start_location']['lat'], step['start_location']['lng']),
        );
        polylineCoordinates.add(
          LatLng(step['end_location']['lat'], step['end_location']['lng']),
        );
      }

      setState(() {
        _polylines.add(
          Polyline(
            polylineId: PolylineId("route"),
            points: polylineCoordinates,
            color: Colors.blue,
            width: 5,
          ),
        );
      });
    }
  }

  void _fitMapToBounds() {
    if (_currentPosition == null || _mapController == null) return;

    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        _currentPosition!.latitude < _mekanKonum.latitude
            ? _currentPosition!.latitude
            : _mekanKonum.latitude,
        _currentPosition!.longitude < _mekanKonum.longitude
            ? _currentPosition!.longitude
            : _mekanKonum.longitude,
      ),
      northeast: LatLng(
        _currentPosition!.latitude > _mekanKonum.latitude
            ? _currentPosition!.latitude
            : _mekanKonum.latitude,
        _currentPosition!.longitude > _mekanKonum.longitude
            ? _currentPosition!.longitude
            : _mekanKonum.longitude,
      ),
    );

    _mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.mekanAdi)),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _isMapTouched = false; // 📌 Harita dışında bir yere dokunulursa tekrar kaydırılabilir hale getir
          });
        },
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward ||
                notification.direction == ScrollDirection.reverse) {
              setState(() {
                _isMapTouched = false; // 📌 Sayfa kaydırıldığında tekrar kaydırılabilir hale getir
              });
            }
            return true;
          },
          child: SingleChildScrollView(
            physics: _isMapTouched
                ? NeverScrollableScrollPhysics()
                : AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TarihiMekanBilgiKutu(mekanAdi: widget.mekanAdi),

                ),
                SizedBox(height: 16),

                // 📌 HARİTA KUTUSU
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isMapTouched = true; // 📌 Haritaya dokununca sadece harita hareket etsin
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                      border: Border.all(color: Colors.grey.shade300, width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 400,
                        child: Stack(
                          children: [
                            AbsorbPointer(
                              absorbing: !_isMapTouched,
                              child: GoogleMap(
                                onMapCreated: (GoogleMapController controller) {
                                  _mapController = controller;
                                  _fitMapToBounds();
                                },
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(41.0082, 28.9784),
                                  zoom: 10,
                                ),
                                mapType: MapType.normal,
                                myLocationEnabled: true,
                                myLocationButtonEnabled: true,
                                markers: {
                                  Marker(
                                    markerId: MarkerId("mekan"),
                                    position: _mekanKonum,
                                    infoWindow: InfoWindow(title: widget.mekanAdi),
                                  ),
                                  if (_currentPosition != null)
                                    Marker(
                                      markerId: MarkerId("ben"),
                                      position: LatLng(
                                        _currentPosition!.latitude,
                                        _currentPosition!.longitude,
                                      ),
                                      infoWindow: InfoWindow(title: "Mevcut Konumum"),
                                    ),
                                },
                                polylines: _polylines,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
