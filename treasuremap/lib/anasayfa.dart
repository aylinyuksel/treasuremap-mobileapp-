import 'dart:io';

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
 @override
  void initState() {
    super.initState();
    sayfalar = [Ana(), FavorilerSayfasi(), Profilim()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("TreasureMap"),
      ),
      body: IndexedStack(
        index: aktifSayfa,
        children: sayfalar,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: aktifSayfa,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Anasayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Favoriler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profilim',
          ),
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
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white10,
              ),
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
            Divider(),
            ListTile(
              leading: Icon(Icons.label_outline),
              title: Text('Çıkış Yap'),
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
