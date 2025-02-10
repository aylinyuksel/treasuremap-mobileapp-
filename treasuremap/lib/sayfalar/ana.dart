import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Ana extends StatefulWidget {
  @override
  _AnaState createState() => _AnaState();
}

class _AnaState extends State<Ana> {
   final Completer<GoogleMapController> _controller = Completer();
  LatLng? _currentPosition; // Kullanıcının mevcut konumu
  final Set<Marker> _markers = {}; // İşaretçiler

  // Harita başlangıç noktası (Varsayılan: İstanbul)
  final LatLng _initialPosition = LatLng(41.0082, 28.9784);

  @override
  void initState() {
    super.initState();
    _determinePosition(); // Konumu almayı başlat
  }

  // Kullanıcının konum iznini kontrol edip konumunu alır
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Konum servisi açık mı?
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Konum servisi kapalı.");
      return;
    }

    // Konum izinlerini kontrol et
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Konum izni reddedildi.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Konum izni kalıcı olarak reddedildi.");
      return;
    }

    // Kullanıcının mevcut konumunu al
    Position position = await Geolocator.getCurrentPosition();
    LatLng newPosition = LatLng(position.latitude, position.longitude);

    setState(() {
      _currentPosition = newPosition;

      // Kullanıcının konumunu işaretçi olarak ekle
      _markers.clear(); // Önceki markerları temizle
      _markers.add(
        Marker(
          markerId: MarkerId("current_location"),
          position: newPosition,
          infoWindow: InfoWindow(title: "Şu Anki Konumunuz"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    });

    // Haritayı kullanıcının konumuna yönlendir
   if (_controller.isCompleted) {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newLatLngZoom(newPosition, 14),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    if (!_controller.isCompleted) {
      _controller.complete(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _currentPosition ?? _initialPosition, // İlk konum
          zoom: 10.0,
        ),
        myLocationEnabled: true, // Kullanıcının konumunu göster
        myLocationButtonEnabled: true, // Konum butonunu aktif et
        markers: _markers, // İşaretçileri haritaya ekle
      ),
    );
  }
}
