import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class IstanbulCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("İstanbulKart")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "İstanbulKart",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
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
                            builder: (context) => IstanbulKartInfoScreen(),
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
    );
  }
}

class IstanbulKartInfoScreen extends StatelessWidget {
  void _openLink() async {
    final Uri uri = Uri.parse("https://www.istanbulkart.istanbul");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    } else {
      debugPrint("Link açılamadı.");
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

            _buildListTile(
              title: "🔹 İstanbulkart Nasıl Çıkarılır?",
              subtitle: "İstanbulkart başvuru noktalarından ya da internet üzerinden çıkarabilirsiniz.",
              icon: Icons.info_outline,
            ),
            _buildListTile(
              title: "🔹 İstanbulkart Nasıl Kullanılır?",
              subtitle: "Toplu taşıma araçlarında kartınızı okuyuculara yaklaştırarak kullanabilirsiniz.",
              icon: Icons.directions_bus,
            ),
            _buildListTile(
              title: "🔹 İstanbulkart Nasıl Doldurulur?",
              subtitle: "Dolum noktalarından veya mobil uygulama ile bakiye yükleyebilirsiniz.",
              icon: Icons.credit_card,
            ),
            _buildListTile(
              title: "🔹 İstanbulkart Nerede Kullanılır?",
              subtitle: "Metro, otobüs, vapur ve diğer toplu taşıma araçlarında geçerlidir.",
              icon: Icons.map,
            ),

            SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: _openLink,
                icon: Icon(Icons.link),
                label: Text("Daha Fazla Bilgi İçin Tıklayın"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({required String title, required String subtitle, required IconData icon}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
    );
  }
}
