import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:treasuremap/IlceTarihiMekanlar.dart';

class Favoriler extends StatefulWidget {
  @override
  _FavorilerState createState() => _FavorilerState();
}

class _FavorilerState extends State<Favoriler> {
  final List<String> tumIlceler = [
    "Adalar", "Arnavutköy", "Ataşehir", "Avcılar", "Bağcılar", "Bahçelievler", "Bakırköy", "Başakşehir", "Bayrampaşa", "Beşiktaş", "Beykoz", "Beylikdüzü", "Beyoğlu", "Büyükçekmece", "Çatalca", "Çekmeköy", "Esenler", "Esenyurt", "Eyüpsultan", "Fatih", "Gaziosmanpaşa", "Güngören", "Kadıköy", "Kağıthane", "Kartal", "Küçükçekmece", "Maltepe", "Pendik", "Sancaktepe", "Sarıyer", "Silivri", "Sultanbeyli", "Sultangazi", "Şile", "Şişli", "Tuzla", "Ümraniye", "Üsküdar", "Zeytinburnu"
  ];

  List<String> filteredIlceler = [];

  @override
  void initState() {
    super.initState();
    filteredIlceler = List.from(tumIlceler);
  }

  void _filterIlceler(String query) {
    setState(() {
      filteredIlceler = tumIlceler
          .where((ilce) => ilce.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("İstanbul'un Harikaları"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 1,
              color: const Color.fromARGB(255, 251, 52, 85),
              padding: EdgeInsets.all(10),
              child: Text(
                "İstanbul'daki İlçeler",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                onChanged: _filterIlceler,
                decoration: InputDecoration(
                  labelText: "Ara...",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredIlceler.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      filteredIlceler[index],
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onTap: () => _selectIlce(context, filteredIlceler[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectIlce(BuildContext context, String ilce) {
    Map<String, List<String>> ilceMekanlari = {
      
      "Adalar": ["Büyükada Rum Yetimhanesi", "Aya Yorgi Kilisesi", "Heybeliada Ruhban Okulu", "Kınalıada Camii"],
      "Arnavutköy": ["Yoros Kalesi", "Durusu Gölü", "Terkos Barajı", "Taşoluk Çeşmesi"],
      "Ataşehir": ["Mimar Sinan Camii", "Nezahat Gökyiğit Botanik Bahçesi", "Kayışdağı Ormanı", "İçerenköy Pazarı"],
      "Avcılar": ["Firuzköy Ormanı", "Avcılar Sahil Parkı", "Bathonea Antik Kenti", "Haluk Perk Müzesi"],
      "Bağcılar": ["Bağcılar Meydanı", "Mehmet Akif Ersoy Kültür Merkezi", "Kirazlı Mescidi", "Bağcılar Belediyesi Müzesi"],
      "Bahçelievler": ["Siyavuş Paşa Kasrı", "Çobançeşme Köprüsü", "Bahçelievler Şehir Parkı", "Şirinevler Ulu Camii"],
      "Bakırköy": ["Fildamı Sarnıcı", "Bakırköy Cumhuriyet Meydanı", "Florya Atatürk Deniz Köşkü", "Yeşilköy Feneri"],
      "Başakşehir": ["Hoşdere Millet Bahçesi", "Şamlar Tabiat Parkı", "Azatlı Baruthanesi", "Başakşehir Gölet Parkı"],
      "Bayrampaşa": ["Rami Kışlası", "Bayrampaşa Şehir Parkı", "Malta Çeşmesi", "Bayrampaşa Kapalı Çarşı"],
      "Beşiktaş": ["Dolmabahçe Sarayı", "Ortaköy Camii", "Yıldız Parkı", "Barbaros Hayrettin Heykeli"],
      "Beykoz": ["Anadolu Kavağı", "Yuşa Tepesi", "Hidiv Kasrı", "Beykoz Mecidiye Kasrı"],
      "Beylikdüzü": ["Gürpınar Sahili", "Kavaklı Sahili", "Yaşam Vadisi", "West Marina"],
      "Beyoğlu": ["Galata Kulesi", "Taksim Meydanı", "İstiklal Caddesi", "Pera Müzesi"],
      "Büyükçekmece": ["Kanuni Sultan Süleyman Köprüsü", "Büyükçekmece Sahili", "Mimar Sinan Camii", "Büyükçekmece Kervansarayı"],
      "Çatalca": ["İnceğiz Mağaraları", "Anastasios Surları", "Çilingoz Tabiat Parkı", "Subaşı Kalesi"],
      "Çekmeköy": ["Taşdelen Mesire Alanı", "Avcıkoru Tabiat Parkı", "Ömerli Barajı", "Şile Yolu Piknik Alanı"],
      "Esenler": ["Metris Kışlası", "15 Temmuz Şehitler Parkı", "Davutpaşa Kışlası", "Esenler Dörtyol Meydanı"],
      "Esenyurt": ["Esenyurt Cumhuriyet Meydanı", "Şehitler Parkı", "Haramidere Köprüsü", "Recep Tayyip Erdoğan Parkı"],
      "Eyüpsultan": ["Eyüp Sultan Camii", "Pierre Loti Tepesi", "Santral İstanbul", "Zal Mahmut Paşa Külliyesi"],
      "Fatih": ["Ayasofya Camii", "Topkapı Sarayı", "Sultanahmet Camii", "Kapalıçarşı"],
      "Gaziosmanpaşa": ["Karlıtepe Mesire Alanı", "Vialand Tema Parkı", "Mehmet Akif Ersoy Parkı", "Gaziosmanpaşa Merkez Camii"],
      "Güngören": ["Güngören Parkı", "Güngören Tarihi Çeşmesi", "Haznedar Camii", "Merter Kapalı Çarşı"],
      "Kadıköy": ["Haydarpaşa Garı", "Moda İskelesi", "Kuşdili Çayırı", "Süreyya Operası"],
      "Kağıthane": ["Sadabad Kasrı", "Kağıthane Deresi", "Hasbahçe Mesire Alanı", "Sanayi Mahallesi Köprüsü"],
      "Kartal": ["Dragos Tepesi", "Aydos Ormanı", "Kartal Sahili", "İstanbul Büyükşehir Belediyesi Şehir Parkı"],
      "Küçükçekmece": ["Yarımburgaz Mağarası", "Küçükçekmece Gölü", "Menekşe Plajı", "Kanarya Sahil Parkı"],
      "Maltepe": ["Başıbüyük Ormanı", "Maltepe Sahili", "Beşçeşmeler", "İdealtepe Sosyal Tesisleri"],
      "Pendik": ["Aydos Kalesi", "Pendik Sahili", "Gözdağı Korusu", "Ballıca Köyü"],
      "Sancaktepe": ["Aydos Ormanı", "Samandıra Kışlası", "Abdurrahmangazi Camii", "Veysel Karani Camii"],
      "Sarıyer": ["Rumeli Hisarı", "Atatürk Arboretumu", "Emirgan Korusu", "Kilyos Plajı"],
      "Silivri": ["Silivri Kalesi", "Mimar Sinan Köprüsü", "Selimpaşa Sahili", "Gümüşyaka Plajı"],
      "Sultanbeyli": ["Aydos Kalesi", "Sultanbeyli Göleti", "Teferruç Tepesi", "Necmettin Erbakan Parkı"],
      "Sultangazi": ["Cebeci Köyü", "Sultangazi Kent Ormanı", "Şehitler Parkı", "Habibler Camii"],
      "Şile": ["Şile Kalesi", "Ağva Sahili", "Hacıllı Şelalesi", "Kumbaba Tepesi"],
      "Şişli": ["Atatürk Müzesi", "Ihlamur Kasrı", "Abide-i Hürriyet", "Bomontiada"],
      "Tuzla": ["Tuzla Marina", "Viaport Marina", "Tuzla Sahili", "İstanbul Park"],
      "Ümraniye": ["Hekimbaşı Av Köşkü", "Ümraniye Millet Bahçesi", "Dudullu Tepesi", "Şile Yolu Mesire Alanı"],
      "Üsküdar": ["Kız Kulesi", "Mihrimah Sultan Camii", "Çamlıca Tepesi", "Fethi Paşa Korusu"],
      "Zeytinburnu": ["Merkezefendi Camii", "Panorama 1453 Tarih Müzesi", "Kazlıçeşme Fatih Camii", "Zeytinburnu Sahili"]
    };

    if (ilceMekanlari.containsKey(ilce)) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => IlceTarihiMekanlar(
            ilceAdi: ilce,
            mekanlar: ilceMekanlari[ilce]!,
          ),
        ),
      );
    }
  }
}
