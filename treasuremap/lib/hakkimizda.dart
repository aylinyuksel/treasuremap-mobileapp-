import 'package:flutter/material.dart';
import 'package:flutter_baslangic/IlceTarihiMekanlar.dart';

class Favoriler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("İstanbul'un Harikaları"),
        actions: [
          IconButton(
            icon: Icon(Icons.location_city),
            onPressed: () {
              _showIlceList(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.assignment_late, size: 75),
            Text("İstanbul'un Harikaları"),
          ],
        ),
      ),
    );
  }

  void _showIlceList(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("İlçe Seçin"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                ListTile(title: Text("Kadıköy"), onTap: () => _selectIlce(context, "Kadıköy")),
                ListTile(title: Text("Beşiktaş"), onTap: () => _selectIlce(context, "Beşiktaş")),
                ListTile(title: Text("Üsküdar"), onTap: () => _selectIlce(context, "Üsküdar")),
                ListTile(title: Text("Beyoğlu"), onTap: () => _selectIlce(context, "Beyoğlu")),
                // Daha fazla ilçe ekleyebilirsiniz
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("Kapat"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

 void _selectIlce(BuildContext context, String ilce) {
  Navigator.of(context).pop(); // Dialog'u kapat

  // İlçelere göre mekanları tanımlıyoruz
  Map<String, List<String>> ilceMekanlari = {
    "Kadıköy": ["Haydarpaşa Garı", "Moda İskelesi", "Kuşdili Çayırı", "Süreyya Operası"],
    "Beşiktaş": ["Dolmabahçe Sarayı", "Ortaköy Camii", "Yıldız Parkı", "Barbaros Hayrettin Heykeli"],
    "Üsküdar": ["Kız Kulesi", "Mihrimah Sultan Camii", "Çamlıca Tepesi", "Fethi Paşa Korusu"],
    "Beyoğlu": ["Galata Kulesi", "Taksim Meydanı", "İstiklal Caddesi", "Pera Müzesi"],
  };

  if (ilceMekanlari.containsKey(ilce)) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => IlceTarihiMekanlar(
          ilceAdi: ilce,
          mekanlar: ilceMekanlari[ilce]!, // O ilçeye ait mekanları gönderiyoruz
        ),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Seçilen ilçe için bilgi bulunamadı: $ilce")),
    );
  }
}

}
