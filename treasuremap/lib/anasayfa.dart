import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'sayfalar/ana.dart';
import 'sayfalar/favoriler.dart';
import 'sayfalar/profilim.dart';

class Anasayfa extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  int aktifSayfa = 0;
  late List<Widget> sayfalar;
  bool isLoggedin = false;
  String username = "";
  @override
  void initState() {
    super.initState();
    sayfalar = [Ana(), FavorilerSayfasi(), Profilim()];
    _loadLoginState();
  }

  Future<void> _loadLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedin = prefs.getBool("isLoggedIn") ?? false;
      username = prefs.getString("username") ?? "Misafir";
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoggedIn", false);
    setState(() {
      isLoggedin = false;
    });
    Navigator.pop(context); // Drawer'ı kapat
  }

  void girisCikisYap() async {
    final prefs = await SharedPreferences.getInstance();

    if (isLoggedin) {
      // Çıkış Yap
      await prefs.setBool("isLoggedIn", false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Çıkış Başarılı!")));
      setState(() {
        isLoggedin = false;
      });
      Navigator.pop(context); // Drawer'ı kapat
    } else {
      // Giriş Yap
      Navigator.pushNamed(context, "/girisLogin").then((_) async {
        // Giriş sayfasından döndüğünde tekrar kontrol et
        final prefs = await SharedPreferences.getInstance();
        setState(() {
          isLoggedin = prefs.getBool("isLoggedIn") ?? false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("TreasureMap")),
      body: IndexedStack(index: aktifSayfa, children: sayfalar),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: aktifSayfa,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Anasayfa'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Favoriler'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profilim'),
        ],
        onTap: (int i) {
          aktifSayfa = i;
          setState(() {});
        },
      ),
      drawer: new Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Align(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("TreasureMap"),
                    SizedBox(height: 8),
                    Text(
                      isLoggedin ? "Hoşgeldin, $username!" : "Giriş yapmadınız",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(color: Colors.white10),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Anasayfa'),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.assignment_late),
              title: Text('istanbulun harikalari'),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.pushNamed(context, "/hakkimizda");
              },
            ),

            ListTile(
              leading: Icon(Icons.settings),
              title: Text('istanbulCard'),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.pushNamed(context, "/istanbulcard");
              },
            ),

            ListTile(
              leading: Icon(isLoggedin ? Icons.logout : Icons.login),
              title: Text(isLoggedin ? 'Çıkış Yap' : 'Giriş Yap'),
              trailing: Icon(Icons.arrow_right),
              onTap: girisCikisYap,
            ),

            Divider(),
            ListTile(
              leading: Icon(Icons.label_outline),
              title: Text('Uygulamadan Çıkış Yap'),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                exit(0);
              },
            ),
          ],
        ),
      ),
    );
  }
}
