import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'TarihiMekanBilgiKutu.dart';
import 'providers/favoriler_provider.dart';

class TarihiMekanDetay extends StatefulWidget {
  final String mekanAdi;

  const TarihiMekanDetay({required this.mekanAdi, Key? key}) : super(key: key);

  @override
  _TarihiMekanDetayState createState() => _TarihiMekanDetayState();
}

class _TarihiMekanDetayState extends State<TarihiMekanDetay> {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  final Set<Polyline> _polylines = {};
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
"Büyükada Rum Yetimhanesi": LatLng(40.86083, 29.12333),
"Aya Yorgi Kilisesi": LatLng(40.8645, 29.1273),
"Heybeliada Ruhban Okulu": LatLng(40.8742, 29.0897),
"Kınalıada Camii": LatLng(40.8748, 29.0795),
"Yoros Kalesi": LatLng(41.1741, 29.0935),
"Durusu Gölü": LatLng(41.2998, 28.6638),
"Terkos Barajı": LatLng(41.2998, 28.6638),
"Taşoluk Çeşmesi": LatLng(41.1798, 28.7487),
"Mimar Sinan Camii": LatLng(40.9876, 29.1163),
"Nezahat Gökyiğit Botanik Bahçesi": LatLng(40.9928, 29.1243),
"Kayışdağı Ormanı": LatLng(40.9702, 29.1845),
"İçerenköy Pazarı": LatLng(40.9637, 29.1112),
"Firuzköy Ormanı": LatLng(41.0136, 28.6758),
"Avcılar Sahil Parkı": LatLng(40.9785, 28.7224),
"Bathonea Antik Kenti": LatLng(40.9881, 28.6898),
"Haluk Perk Müzesi": LatLng(40.9963, 28.7206),
"Bağcılar Meydanı": LatLng(41.0390, 28.8567),
"Mehmet Akif Ersoy Kültür Merkezi": LatLng(41.0385, 28.8572),
"Kirazlı Mescidi": LatLng(41.0422, 28.8595),
"Bağcılar Belediyesi Müzesi": LatLng(41.0359, 28.8555),
"Siyavuş Paşa Kasrı": LatLng(40.9944, 28.8694),
"Çobançeşme Köprüsü": LatLng(40.9981, 28.8449),
"Bahçelievler Şehir Parkı": LatLng(40.9936, 28.8598),
"Şirinevler Ulu Camii": LatLng(40.9930, 28.8525),
"Fildamı Sarnıcı": LatLng(40.9989, 28.8875),
"Bakırköy Cumhuriyet Meydanı": LatLng(40.9775, 28.8753),
"Florya Atatürk Deniz Köşkü": LatLng(40.9643, 28.7967),
"Yeşilköy Feneri": LatLng(40.9591, 28.8226),
"Hoşdere Millet Bahçesi": LatLng(41.0990, 28.7754),
"Şamlar Tabiat Parkı": LatLng(41.1168, 28.7797),
"Azatlı Baruthanesi": LatLng(41.0935, 28.8056),
"Başakşehir Gölet Parkı": LatLng(41.0912, 28.8022),
"Rami Kışlası": LatLng(41.0467, 28.9172),
"Bayrampaşa Şehir Parkı": LatLng(41.0463, 28.8996),
"Malta Çeşmesi": LatLng(41.0445, 28.9123),
"Bayrampaşa Kapalı Çarşı": LatLng(41.0429, 28.9025),
"Dolmabahçe Sarayı": LatLng(41.0390, 28.9983),
"Ortaköy Camii": LatLng(41.0471, 29.0277),
"Yıldız Parkı": LatLng(41.0430, 29.0156),
"Barbaros Hayrettin Heykeli": LatLng(41.0387, 29.0043),
"Anadolu Kavağı": LatLng(41.1766, 29.0935),
"Yuşa Tepesi": LatLng(41.1760, 29.0939),
"Hidiv Kasrı": LatLng(41.0931, 29.0758),
"Beykoz Mecidiye Kasrı": LatLng(41.1255, 29.0841),
"Gürpınar Sahili": LatLng(40.9762, 28.6408),
"Kavaklı Sahili": LatLng(40.9821, 28.6267),
"Yaşam Vadisi": LatLng(40.9934, 28.6270),
"West Marina": LatLng(40.9674, 28.6209),
"Galata Kulesi": LatLng(41.0256, 28.9744),
"Taksim Meydanı": LatLng(41.0369, 28.9850),
"İstiklal Caddesi": LatLng(41.0340, 28.9779),
"Pera Müzesi": LatLng(41.0313, 28.9751),
"Kanuni Sultan Süleyman Köprüsü": LatLng(41.0225, 28.5833),
"Büyükçekmece Sahili": LatLng(41.0216, 28.5745),
"Büyükçekmece Kervansarayı": LatLng(41.0228, 28.5772),
"İnceğiz Mağaraları": LatLng(41.1864, 28.4398),
"Anastasios Surları": LatLng(41.1432, 28.4827),
"Çilingoz Tabiat Parkı": LatLng(41.6347, 28.2039),
"Subaşı Kalesi": LatLng(41.2212, 28.4617),
"Taşdelen Mesire Alanı": LatLng(41.0153, 29.2315),
"Avcıkoru Tabiat Parkı": LatLng(41.0796, 29.2641),
"Ömerli Barajı": LatLng(41.0803, 29.3586),
"Şile Yolu Piknik Alanı": LatLng(41.0865, 29.2601),
"Metris Kışlası": LatLng(41.0790, 28.8820),
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
    final favorilerProvider = Provider.of<FavorilerProvider>(context);
    bool isFavorite =favorilerProvider.favoriMekanlar.contains(widget.mekanAdi);
    return Scaffold(
      appBar: AppBar(title: Text(widget.mekanAdi),
     actions: [
        IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.black,
          ),
          onPressed: () {
            setState(() {
               favorilerProvider.favoriEkleCikar(widget.mekanAdi);
             });
          },
        ),
      ],
    ), // 🔥 AppBar burada kapatıldı!
  


    
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
