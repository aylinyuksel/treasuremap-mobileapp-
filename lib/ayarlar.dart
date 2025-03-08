import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Ayarlar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Ayarlar")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.settings, size: 75),
              Text("Ayarlar"),
              SizedBox(height: 20),

              Card(
                margin: EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "📌 İstanbulkart Bilgilendirme",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "İstanbulkart nasıl çıkarılır, nasıl kullanılır, nasıl doldurulur ve nerede kullanılır gibi bilgileri aşağıda bulabilirsiniz.",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => IstanbulkartBilgiSayfasi(),
                            ),
                          );
                        },
                        child: Text("Daha Fazla Bilgi"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IstanbulkartBilgiSayfasi extends StatelessWidget {
  void _openLink() async {
    final Uri uri = Uri.parse("https://www.istanbulkart.istanbul");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print("Link açılamadı.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("İstanbulkart Bilgilendirme")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "📌 İstanbulkart Hakkında",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "İstanbulkart, İstanbul'da toplu taşıma araçlarında kullanılabilen elektronik bir ulaşım kartıdır.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            ListTile(
              title: Text("🔹 İstanbulkart Nasıl Çıkarılır?"),
              subtitle: Text(
                "İstanbulkart başvuru noktalarından ya da internet üzerinden çıkarabilirsiniz.",
              ),
              leading: Icon(Icons.info_outline),
            ),
            ListTile(
              title: Text("🔹 İstanbulkart Nasıl Kullanılır?"),
              subtitle: Text(
                "Toplu taşıma araçlarında kartınızı okuyuculara yaklaştırarak kullanabilirsiniz.",
              ),
              leading: Icon(Icons.directions_bus),
            ),
            ListTile(
              title: Text("🔹 İstanbulkart Nasıl Doldurulur?"),
              subtitle: Text(
                "Dolum noktalarından veya mobil uygulama ile bakiye yükleyebilirsiniz.",
              ),
              leading: Icon(Icons.credit_card),
            ),
            ListTile(
              title: Text("🔹 İstanbulkart Nerede Kullanılır?"),
              subtitle: Text(
                "Metro, otobüs, vapur ve diğer toplu taşıma araçlarında geçerlidir.",
              ),
              leading: Icon(Icons.map),
            ),

            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _openLink,
              icon: Icon(Icons.link),
              label: Text("Daha Fazla Bilgi İçin Tıklayın"),
            ),
          ],
        ),
      ),
    );
  }
}
