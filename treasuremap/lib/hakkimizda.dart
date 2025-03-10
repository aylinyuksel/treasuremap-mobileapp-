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
      
      "Adalar": ["Büyükada Rum Yetimhanesi", "Aya Yorgi Kilisesi", "Heybeliada Ruhban Okulu", "Kınalıada Camii", "Sait Faik Abasıyanık Müzesi", "Hüseyin Rahmi Gürpınar Müzesi", "Adalar Müzesi", "Reşat Nuri Güntekin Evi", "Dilburnu Tabiat Parkı", "Taş Mektep", "Saatli Meydan", "Adakule", "Değirmenburnu Tabiat Parkı", "Kalpazankaya", "Aya Nikola Hangar Müze Alanı", "Aya Yani Kilisesi", "Hamidiye Camii", "Panayia Kilisesi", "Hesed Le Avraam Sinagogu", "Ayios Nikolaos Manastırı", "Ayios Demetrios Kilisesi", "Deniz Lisesi", "Aya Triada Manastırı ve Kilisesi", "Heybeliada Sanatoryumu", "Ayios Nikolaos Rum Ortodoks Kilisesi", "Aya Yorgi Karipi Manastırı"],
      "Arnavutköy": ["Yoros Kalesi", "Durusu Gölü", "Terkos Barajı", "Taşoluk Çeşmesi", "Tevfikiye Camii", "Aya Strati Taksiarhi Rum Ortodoks Kilisesi", "Osmanlı Camii", "Rumeli Karaburun Feneri", "İzzetâbâd Kasrı", "Robert Koleji", "Arnavutköy Polis Karakolu", "Halet Çambel Yalısı", "Ayvazpaşazade Yalısı", "Profitis İlias Rum Ortodoks Kilisesi ve Ayazması", "Arnavutköy Profitis İlias Rum Ortodoks Mezarlığı"],
      "Ataşehir": ["Mimar Sinan Camii", "Nezahat Gökyiğit Botanik Bahçesi", "Kayışdağı Ormanı", "İçerenköy Pazarı", "Ali Gazi Baba Türbesi", "İçerenköy Merkez Camii", "İçerenköy Mezarlığı Çeşmesi", "Mahmut Bey Çeşmesi", "Düştepe Oyun Müzesi", "Evrensel Değerler Çocuk Müzesi ve Eğitim Kampüsü"],
      "Avcılar": ["Firuzköy Ormanı", "Avcılar Sahil Parkı", "Bathonea Antik Kenti", "Haluk Perk Müzesi", "Avcılar Atatürk Evi Müzesi", "Marmara Caddesi", "Paşaeli Kent Parkı", "Uğur Mumcu Parkı", "Cennet Piknik Alanı", "Çamlık Piknik Alanı"],
      "Bağcılar": ["Bağcılar Meydanı", "Mehmet Akif Ersoy Kültür Merkezi", "Kirazlı Mescidi", "Bağcılar Belediyesi Müzesi", "Mahmutbey Camii", "Güneşli Şapeli", "Yeşilbağ Ulu Camii", "Hacı Bayram Veli Camii", "Ulubatlı Hasan Camii", "Taceddin Dergâhı Müzesi"],
      "Bahçelievler": ["Siyavuş Paşa Kasrı", "Çobançeşme Köprüsü", "Bahçelievler Şehir Parkı", "Şirinevler Ulu Camii", "Soğanlı Çeşmesi", "Viran Saray (Viran Bosna)", "Havuzlu Köşk ve Çeşmesi", "Çobançeşme Parkı", "Mehmet Akif Ersoy Parkı", "Bahçelievler Botanik Bahçesi"],
      "Bakırköy": ["Fildamı Sarnıcı", "Bakırköy Cumhuriyet Meydanı", "Florya Atatürk Deniz Köşkü", "Yeşilköy Feneri", "Ataköy Baruthanesi", "Zuhurat Baba Türbesi", "Resneliler Köşkü", "Magnaura Sarayı", "Hilmi Nakipoğlu Kamera Müzesi", "Bakırköy Ruh ve Sinir Hastalıkları Müzesi", "İstanbul Hava Kuvvetleri Müzesi", "Bakırköy Botanik Parkı", "Veliefendi Hipodromu", "Yeşilköy Marina", "Surp Stepanos Ermeni Kilisesi", "Yeşilköy Sahil Parkı", "Bakırköy Sinagogu", "Osmanlı Mezarlığı"],
      "Başakşehir": ["Hoşdere Millet Bahçesi", "Şamlar Tabiat Parkı", "Azatlı Baruthanesi", "Başakşehir Gölet Parkı", "Yarımburgaz Mağarası", "Resneli Çiftliği", "Şamlar Köyü Camii", "Hasandere Köprüsü"],
      "Bayrampaşa": ["Rami Kışlası", "Bayrampaşa Şehir Parkı", "Malta Çeşmesi", "Bayrampaşa Kapalı Çarşı", "Maltepe Askeri Hastanesi", "Ferhat Paşa Çiftliği", "Bayrampaşa Külliyesi", "Yıldırım Beyazıt Camii", "Fevzi Çakmak Parkı", "Bayrampaşa Kültür Merkezi"],
      "Beşiktaş": ["Dolmabahçe Sarayı", "Ortaköy Camii", "Yıldız Parkı", "Barbaros Hayrettin Heykeli", "Çırağan Sarayı", "Yıldız Sarayı", "İstanbul Deniz Müzesi", "Barbaros Hayrettin Paşa Türbesi", "Ihlamur Kasrı", "Ertuğrul Tekke Camii"],
      "​Beykoz": ["Anadolu Kavağı", "Yuşa Tepesi", "Hidiv Kasrı", "Beykoz Mecidiye Kasrı", "Yoros Kalesi", "Anadolu Hisarı", "Küçüksu Kasrı", "Mihrabat Korusu", "Polonezköy Tabiat Parkı", "Beykoz Cam ve Billur Müzesi", "Çubuklu Korusu", "Otağtepe Fatih Korusu", "Kanlıca", "Anadolu Feneri", "İshak Ağa Çeşmesi (Onçeşmeler)", "Serbostani Mustafa Ağa Camii", "Surp Nigoğayos Ermeni Kilisesi"],
      "​Beylikdüzü": ["Gürpınar Sahili", "Kavaklı Sahili", "Yaşam Vadisi", "West Marina", "Kapıağa (Haramidere) Köprüsü", "Malik Ağa Çeşmesi", "Değirmenburnu Feneri", "Roma Kayıkhanesi", "Rıfat Ilgaz Eğitim Tarihi Müzesi", "Balıkçı Kenan Deniz Canlıları Müzesi"],
      "Beyoğlu": ["Galata Kulesi", "Taksim Meydanı", "İstiklal Caddesi", "Pera Müzesi", "Çiçek Pasajı", "Saint Antoine Kilisesi", "Galata Mevlevihanesi", "Madame Tussauds İstanbul", "Rahmi M. Koç Müzesi", "Masumiyet Müzesi"],
      "​Büyükçekmece": ["Kanuni Sultan Süleyman Köprüsü", "Büyükçekmece Sahili", "Mimar Sinan Camii", "Büyükçekmece Kervansarayı", "Kurşunlu Han", "Sokullu Mehmet Paşa Camii", "Kanuni Sultan Süleyman Çeşmesi", "İmaret Camii", "Zeynep Dudu Çeşmesi", "Fatih Sultan Mehmet Çeşmesi", "Süleyman Ağa Çeşmesi", "Enver Paşa Köşkü", "Sultan II. Abdülhamid Çeşmesi ve Havuzu", "Dünya Kostümleri Müzesi", "Büyükçekmece Gölü", "Atatürk Kültür Parkı", "Albatros Parkı", "Sinanoba Plajı", "Tüyap Fuar ve Kongre Merkezi", "Büyükçekmece Kültür ve Sanat Festivali", "Kervansaray", "Büyükçekmece Plajları", "Orhan Veli Sosyal Tesisleri", "Büyükçekmece İmaret Camii", "Sultan II. Abdülhamid Çeşmesi ve Havuzu"],
      "​Çatalca": ["İnceğiz Mağaraları", "Anastasios Surları", "Çilingoz Tabiat Parkı", "Subaşı Kalesi", "Ferhat Paşa Camii", "Topuklu Çeşmesi", "Mübadele Müzesi", "Kurşunlugerme Su Kemeri", "Georgios Kilisesi", "Katırcı Köprüsü", "Ballıgerme Su Kemeri", "Büyükgerme Su Kemeri", "Karamanoğlu Su Kemeri", "Kumalıgerme Su Kemeri", "Kurşunlugerme Su Kemeri", "Talas Su Kemeri-1", "Talas Su Kemeri-2", "Ali Paşa Çeşmesi", "Çatal Çeşme", "Ferhat Paşa Çeşmesi"],
      "​Çekmeköy": ["Taşdelen Mesire Alanı", "Avcıkoru Tabiat Parkı", "Ömerli Barajı", "Şile Yolu Piknik Alanı", "Alemdağ Vakıf Camii", "Turasan Bey Türbesi", "Mütevelli Suyu Çeşmesi", "Alemdağ Kaya Mezarları", "Ömerli Köprüsü"],
      "Esenler": ["Metris Kışlası", "15 Temmuz Şehitler Parkı", "Davutpaşa Kışlası", "Esenler Dörtyol Meydanı", "Avas Kemeri", "Atışalanı Çeşmesi", "Atışalanı Sebili", "Menderes Çeşmesi (Litros Ayazması)", "Yavuz Selim Çeşmesi", "Nene Hatun Çeşmesi", "Hünkar Kasrı", "Litros Aya Yorgi Kilisesi"],
      "Esenyurt": ["Esenyurt Cumhuriyet Meydanı", "Şehitler Parkı", "Haramidere Köprüsü", "Recep Tayyip Erdoğan Parkı", "Esenyurt Tarihi Merkez Camii", "Esenyurt Kültür ve Sanat Merkezi", "Pelit Çikolata Müzesi"],
      "Eyüpsultan": ["Eyüp Sultan Camii", "Pierre Loti Tepesi", "Santral İstanbul", "Zal Mahmut Paşa Külliyesi", "Feshane", "Rami Kışlası", "Bahariye Mevlevihanesi", "Sokullu Mehmet Paşa Türbesi", "Cafer Paşa Medresesi", "Eyüp Sultan Mezarlığı", "Defterdar Camii", "Eski İmaret Camii", "İdris-i Bitlisi Türbesi", "Karyağdı Baba Türbesi", "Nişancı Mehmet Paşa Camii", "Silahtarağa Elektrik Santrali Müzesi", "Haliç Surları", "Cülus Yolu", "Karagöz Evi", "Akşemsettin Mescidi"],
      "Fatih": ["Ayasofya Camii", "Topkapı Sarayı", "Sultanahmet Camii", "Kapalıçarşı", "Süleymaniye Camii", "Yerebatan Sarnıcı", "Fatih Camii", "Şehzade Camii", "Yedikule Hisarı", "Kariye Müzesi", "Mısır Çarşısı", "Fener Rum Patrikhanesi", "Zeyrek Camii", "Sultanahmet Meydanı", "Türk ve İslam Eserleri Müzesi", "Sultan II. Mahmud Türbesi", "Sirkeci Garı", "Bozdoğan Kemeri", "Gül Camii", "Sokollu Mehmet Paşa Camii"],
      "Gaziosmanpaşa": ["Karlıtepe Mesire Alanı", "Vialand Tema Parkı", "Mehmet Akif Ersoy Parkı", "Gaziosmanpaşa Merkez Camii", "Küçükköy Meydanı Saat Kulesi", "Gaziosmanpaşa Kültür ve Sanat Merkezi", "Gazi Osman Paşa Camii", "Sultan Selim Camii", "Kervansaray Tarihi Köprüsü", "Gazi Osman Paşa Kültür Merkezi"],
      "Güngören": ["Güngören Parkı", "Güngören Tarihi Çeşmesi", "Haznedar Camii", "Merter Kapalı Çarşı", "Güngören Kervansarayı", "Güngören Hamamı", "Genç Osman Camii", "Güngören Camii", "Güngören Çarşısı"],
      "Kadıköy": ["Haydarpaşa Garı", "Moda İskelesi", "Kuşdili Çayırı", "Süreyya Operası", "Barış Manço Evi", "Osman Ağa Camii", "Kethüda Çarşı Camii", "All Saints Moda Kilisesi", "Hemdat İsrael Sinagogu", "Moda Sahili", "Bahariye Caddesi", "Kadıköy Çarşısı", "Boğa Heykeli", "Kadıköy Antikacılar Sokağı", "Yoğurtçu Parkı", "Nazım Hikmet Kültür Merkezi", "Haldun Taner Sahnesi", "İstanbul Oyuncak Müzesi", "Fenerbahçe Parkı", "Ragıp Paşa Köşkü"],
      "Kağıthane": ["Sadabad Kasrı", "Kağıthane Deresi", "Hasbahçe Mesire Alanı", "Sanayi Mahallesi Köprüsü", "Aziziye Camii (Sadabad Camii - Çağlayan Camii)", "Mir-i Ahur (İmrahor) Kasrı", "İmrahor Çeşmesi (III. Murad Çeşmesi)", "Poligon Çeşmesi", "Atiye Sultan Sarayı (Kağıthane Kasrı Hümayunu-Küçük Zabit Mektebi)", "Çeşme-i Nur (III. Ahmed Çeşmesi)"],
      "Kartal": ["Dragos Tepesi", "Aydos Ormanı", "Kartal Sahili", "İstanbul Büyükşehir Belediyesi Şehir Parkı", "Aydos Kalesi", "Kartal Merkez Camii", "Maarifi Sultan Camii", "Surp Nişan Ermeni Kilisesi", "Kartal Şifa Hamamı", "Şeyh Muhammed Fethül Maarif Türbesi"],
      "Küçükçekmece": ["Yarımburgaz Mağarası", "Küçükçekmece Gölü", "Menekşe Plajı", "Kanarya Sahil Parkı", "Bathonea Antik Kenti", "Küçükçekmece Mimar Sinan Köprüsü", "Mehmet Arsay Klasik Otomobil Müzesi", "Küçükçekmece Tarih Müzesi"],
      "Maltepe": ["Başıbüyük Ormanı", "Maltepe Sahili", "Beşçeşmeler", "İdealtepe Sosyal Tesisleri", "Başıbüyük Merkez Camii", "Kazasker Feyzullah Efendi Camii", "Yalı Hamamı", "Bostancıbaşı Köprüsü", "Bryas Sarayı", "Bakireler Tapınağı", "Nokta Taşı", "Ahmet Baba Türbesi", "Süreyyapaşa Türbesi", "Feyzullah Efendi Çeşmesi", "Kayışdağı Suyu Çeşmesi", "Tatlı Su Çeşmesi"],
      "Pendik": ["Aydos Kalesi", "Pendik Sahili", "Gözdağı Korusu", "Ballıca Köyü", "Pendik Höyüğü (Temenye Höyüğü)", "Pendik Çarşı Camii", "Hilmi Abbas Paşa Camii", "Pendik Protestan Kilisesi", "Pir Keskin Sultan Türbesi", "Şeyh Kemikli Türbesi", "Velibaba Türbesi", "Sultan Konağı", "Pendik Marintürk Alışveriş ve Yaşam Merkezi", "Pendik Yenişehir Mesire Alanı", "Güzelyalı Sosyal Tesisleri", "Kurnaköy Mesire Alanı", "Pendik Masal Parkı", "Pendik Halk Pazarı", "Kaynarca Botaş Parkı", "Gözdağı Sosyal Tesisleri", "Güzelyalı Sosyal Tesisleri", "Viaport Asia Outlet Alışveriş Merkezi"],
      "Sancaktepe": ["Aydos Ormanı", "Samandıra Kışlası", "Abdurrahmangazi Camii", "Veysel Karani Camii", "Damatris Sarayı", "Paşaköy Camii", "Samandıra Merkez Camii", "Abdurrahman Gazi Türbesi", "Sarı Kadızade Şeyh Mustafa Efendi Türbesi"],
      "Sarıyer": ["Rumeli Hisarı", "Atatürk Arboretumu", "Emirgan Korusu", "Kilyos Plajı", "Sadberk Hanım Müzesi", "Belgrad Ormanı", "Garipçe Köyü", "Maslak Kasırları", "Rumeli Feneri", "Sakıp Sabancı Müzesi", "Ural Ataman Klasik Otomobil Müzesi", "Telli Baba Türbesi", "Zekeriyaköy", "Rumeli Kavağı", "Emirgan Camii", "Sait Halim Paşa Yalısı", "Tarabya Koyu", "Beyaz Köşk", "Hacıosman Korusu", "İBB Japon Bahçesi Parkı"],
      "Silivri": ["Silivri Kalesi (Selymbria Kalesi)", "Mimar Sinan Köprüsü (Sultan Süleyman Köprüsü)", "Selimpaşa Tarihi Evleri", "Piri Mehmed Paşa Camii", "Anastasios Surları", "Ali Paşa Camii", "Germiyan Kilisesi", "Ortaköy Tarihi Camii", "Silivri Kalepark", "Silivri Sahili", "Silivri Dalgakıran", "Silivri Plajları", "Ayçiçeği Tarlaları", "Silivri Gümüşyaka Gece Pazarı", "Masal Köy", "Silivri At Çiftlikleri", "Silivri Golf Alanları"],
      "Sultanbeyli": ["Aydos Kalesi", "Sultanbeyli Göleti", "Teferrüç Tepesi", "Necmettin Erbakan Parkı", "Aydos Ormanı", "Abdurrahman Gazi Türbesi", "Fatih Sultan Mehmet Tabiat Parkı", "Hasanpaşa Mesire Alanı", "Sultanbeyli Kent Meydanı", "Paşaköy Ormanı"],
      "Sultangazi": ["Cebeci Köyü", "Sultangazi Kent Ormanı", "Şehitler Parkı", "Habibler Camii", "Mağlova Kemeri", "Sultangazi Su Kemerleri", "Esentepe Parkı", "Güvercintepe Parkı", "Sultangazi Merkez Camii", "Masal Kahramanları Parkı"],
      "Şile": ["Şile Kalesi", "Ağva Sahili", "Hacıllı Şelalesi", "Kumbaba Tepesi", "Şile Feneri", "Saklı Göl", "Değirmençayırı Şelalesi", "Hanımsuyu Çeşmesi", "Tarihi Şile Evleri", "Maşatlık Parkı"],
      "Şişli": ["Atatürk Müzesi", "Ihlamur Kasrı", "Abide-i Hürriyet", "Bomontiada", "Askerî Müze ve Kültür Sitesi Komutanlığı", "Saint Esprit Kilisesi", "Şişli Camii", "Teşvikiye Camii", "Aya Dimitri Rum Kilisesi", "Harbiye Cemil Topuzlu Açıkhava Tiyatrosu", "Maçka Demokrasi Parkı", "Fatih Sultan Mehmet Tabiat Parkı", "Feriköy Antika Pazarı", "Maçka Küçükçiftlik Parkı", "Bulgar Eksarhlığı", "Darülaceze", "Lütfi Kırdar Kongre ve Sergi Sarayı", "Cemal Reşit Rey Konser Salonu", "Cemil Topuzlu Açıkhava Tiyatrosu", "Bomonti Bira Fabrikası"],
      "Tuzla": ["Tuzla Marina", "Viaport Marina", "Tuzla Sahili", "İstanbul Park", "Tuzla Tersanesi", "Tuzla Balıkçı Barınağı", "Tuzla Belediyesi Şelale Eğitim Parkı", "Tuzla Termal Tesisleri", "Tuzla Kültür Merkezi", "Tuzla Belediyesi Sanat Galerisi"],
      "Ümraniye": ["Hekimbaşı Av Köşkü", "Ümraniye Millet Bahçesi", "Dudullu Tepesi", "Ihlamurkuyu Ormanı", "Cevher Ağa Camii", "Nezahat Gökyiğit Botanik Bahçesi", "Tantavi Sosyal Tesisleri", "Ümraniye Çarşısı", "Şile Yolu Ormanı", "Ümraniye Kültür ve Sanat Merkezi"],
      "Üsküdar": ["Kız Kulesi", "Mihrimah Sultan Camii", "Çamlıca Tepesi", "Fethi Paşa Korusu", "Şemsi Paşa Camii", "Yeni Valide Camii", "Atik Valide Camii", "Çinili Camii", "Selimiye Camii", "Beylerbeyi Sarayı", "Florence Nightingale Müzesi", "Aziz Mahmud Hüdayi Türbesi", "Karacaahmet Mezarlığı", "III. Ahmet Çeşmesi", "Kuzguncuk Mahallesi"],
      "Zeytinburnu": ["Merkezefendi Camii", "Panorama 1453 Tarih Müzesi", "Kazlıçeşme Fatih Camii", "Zeytinburnu Sahili", "Merkezefendi Külliyesi", "Seyyid Nizam Tekkesi ve Camii", "Balıklı Meryem Ana Rum Ortodoks Manastırı", "Takkeci İbrahim Ağa Camii", "Abdülbaki Paşa Kütüphanesi", "Merkezefendi Hamamı"]
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
