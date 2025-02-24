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
  LatLng? _currentPosition; // Kullanıcının gerçek konumu
  final Set<Marker> _markers = {}; // İşaretçiler
  late StreamSubscription<Position> _positionStream; // Canlı konum takibi

  @override
  void initState() {
    super.initState();
    _determinePosition(); // Kullanıcının konumunu al ve haritayı oraya yönlendir
  }

  @override
  void dispose() {
    _positionStream
        .cancel(); // Uygulama kapatıldığında konum dinleyicisini durdur
    super.dispose();
  }

  // 📌 Kullanıcının konum iznini kontrol edip mevcut konumunu alır
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

    // 📌 Kullanıcının mevcut konumunu al ve haritayı yüklemeden önce bekle
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    LatLng newPosition = LatLng(position.latitude, position.longitude);

    setState(() {
      _currentPosition = newPosition;

      // Kullanıcının konumunu işaretçi olarak ekle
      _markers.clear();
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
    _moveCamera(newPosition);

    // 📌 Canlı konum takibini başlat
    _startLiveLocation();
  }

  // 📌 Canlı konum takibini başlat
  void _startLiveLocation() {
    _positionStream = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5, // 5 metre değişim olursa güncelle
      ),
    ).listen((Position position) {
      LatLng newPosition = LatLng(position.latitude, position.longitude);

      setState(() {
        _currentPosition = newPosition;

        // Kullanıcının konumunu işaretçi olarak ekle
        _markers.clear();
        _markers.add(
          Marker(
            markerId: MarkerId("current_location"),
            position: newPosition,
            infoWindow: InfoWindow(title: "Şu Anki Konumunuz"),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue,
            ),
          ),
        );
      });

      // Haritayı kullanıcının konumuna yönlendir
      _moveCamera(newPosition);
    });
  }

  Future<void> _moveCamera(LatLng newPosition) async {
    if (_controller.isCompleted) {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newLatLngZoom(newPosition, 18));
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
      appBar: AppBar(
        title: const Text('Theme Style Google Map'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(200, 233, 187, 214),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () {
                        _controller.future.then((value) {
                          DefaultAssetBundle.of(context)
                              .loadString('i_theme/standart_theme.json')
                              .then((style) {
                            value.setMapStyle(style);
                          });
                        });
                      },
                      child: Text('Standart'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        _controller.future.then((value) {
                          DefaultAssetBundle.of(context)
                              .loadString('i_theme/dark_theme.json')
                              .then((style) {
                            value.setMapStyle(style);
                          });
                        });
                      },
                      child: Text('Dark'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        _controller.future.then((value) {
                          DefaultAssetBundle.of(context)
                              .loadString('i_theme/retro_theme.json')
                              .then((style) {
                            value.setMapStyle(style);
                          });
                        });
                      },
                      child: Text('Retro'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        _controller.future.then((value) {
                          DefaultAssetBundle.of(context)
                              .loadString('i_theme/aubergine_theme.json')
                              .then((style) {
                            value.setMapStyle(style);
                          });
                        });
                      },
                      child: Text('Aubergine'),
                    ),
                  ]),
        ],
      ),
      body: _currentPosition == null
          ? Center(
              child: CircularProgressIndicator(),
            ) // 📌 Konum yüklenene kadar harita açılmasın
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _currentPosition!,
                zoom: 14.0, // 📌 Daha yakın aç
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: _markers,
            ),
    );
  }
}
