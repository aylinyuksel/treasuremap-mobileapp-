import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TarihiMekanBilgiKutu extends StatefulWidget {
  final String mekanAdi;

  const TarihiMekanBilgiKutu({required this.mekanAdi, Key? key}) : super(key: key);

  @override
  _TarihiMekanBilgiKutuState createState() => _TarihiMekanBilgiKutuState();
}

class _TarihiMekanBilgiKutuState extends State<TarihiMekanBilgiKutu> {
  final PageController _pageController = PageController();
  List<String> _photoUrls = [];
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = "";

  final String googleApiKey = "AIzaSyD4lzpfy5hB7WXLHuekX9QabpJAfNjyDG8"; // ✅ API ANAHTARINI GİR

  @override
  void initState() {
    super.initState();
    fetchPlacePhotos(widget.mekanAdi);
  }

  Future<void> fetchPlacePhotos(String mekanAdi) async {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _errorMessage = "";
    });

    try {
      final encodedMekanAdi = Uri.encodeComponent(mekanAdi);
      final placeSearchUrl =
          "https://maps.googleapis.com/maps/api/place/textsearch/json"
          "?query=$encodedMekanAdi&key=$googleApiKey";

      final placeSearchResponse = await http.get(Uri.parse(placeSearchUrl));
      final placeSearchData = json.decode(placeSearchResponse.body);

      if (placeSearchData['results'] == null || placeSearchData['results'].isEmpty) {
        throw Exception("❌ Mekan bulunamadı! Mekan Adı: $mekanAdi");
      }

      String placeId = placeSearchData['results'][0]['place_id'];

      final placeDetailsUrl =
          "https://maps.googleapis.com/maps/api/place/details/json"
          "?place_id=$placeId&fields=photos&key=$googleApiKey";

      final placeDetailsResponse = await http.get(Uri.parse(placeDetailsUrl));
      final placeDetailsData = json.decode(placeDetailsResponse.body);

      if (placeDetailsData['result'] == null || placeDetailsData['result']['photos'] == null) {
        throw Exception("❌ Fotoğraf referansı bulunamadı!");
      }

      List<String> photoReferences = (placeDetailsData['result']['photos'] as List<dynamic>)
          .map((photo) => photo['photo_reference'].toString())
          .toList();

      List<String> photoUrls = photoReferences.map((photoRef) {
        return "https://maps.googleapis.com/maps/api/place/photo"
            "?maxwidth=1024&photo_reference=$photoRef&key=$googleApiKey";
      }).toList();

      if (!mounted) return;

      setState(() {
         _photoUrls = photoUrls.take(2).toList(); // 📌 İlk 2 fotoğrafı al
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _hasError = true;
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 📌 Mekan İsmi
          Text(
            widget.mekanAdi,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          SizedBox(height: 8),

          // 📌 "Görseller" Başlığı
          if (!_isLoading && _photoUrls.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Görseller",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            ),

          // 📌 Fotoğraflar Yüklenirken
          if (_isLoading) Center(child: CircularProgressIndicator()),

          // 📌 API'den Gelen Fotoğraflar
          if (!_isLoading && _photoUrls.isNotEmpty)
            buildImageGallery(_photoUrls),

          // 📌 Fotoğraf Bulunamazsa
          if (!_isLoading && _photoUrls.isEmpty)
            Center(
              child: Column(
                children: [
                  Icon(Icons.error, color: Colors.red, size: 50),
                  Text("Fotoğraf bulunamadı!", style: TextStyle(color: Colors.black54)),
                  if (_hasError) Text("Hata: $_errorMessage", style: TextStyle(color: Colors.red))
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget buildImageGallery(List<String> imageUrls) {
    return Column(
      children: [
        SizedBox(
          height: 250,
          child: PageView.builder(
            controller: _pageController,
            itemCount: imageUrls.length,
            onPageChanged: (index) {
              setState(() {});
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullScreenImage(
                        imageUrls: imageUrls,
                        initialIndex: index,
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrls[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}

class FullScreenImage extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const FullScreenImage({required this.imageUrls, required this.initialIndex, Key? key})
      : super(key: key);

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.imageUrls.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Center(
                child: Image.network(widget.imageUrls[index], fit: BoxFit.contain),
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.imageUrls.length,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: _currentIndex == index ? 12 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index ? Colors.white : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
