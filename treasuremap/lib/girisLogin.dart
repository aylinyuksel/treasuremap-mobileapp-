import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Giriş Yap")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "E-posta veya Kullanıcı Adı",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Şifre",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Burada giriş işlemi gerçekleştirilebilir
              },
              child: Text("Giriş Yap"),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SifremiUnuttumScreen(),
                      ),
                    );
                  },
                  child: Text("Şifremi Unuttum"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HesapOlusturScreen(),
                      ),
                    );
                  },
                  child: Text("Hesap Oluştur"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SifremiUnuttumScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("Şifremi Unuttum")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Şifrenizi sıfırlamak için e-posta adresinizi girin.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "E-posta Adresiniz",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Şifre sıfırlama işlemi burada yapılır.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Şifre sıfırlama bağlantısı gönderildi!"),
                  ),
                );
              },
              child: Text("Şifremi Sıfırla"),
            ),
          ],
        ),
      ),
    );
  }
}

class HesapOlusturScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("Hesap Oluştur")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: "Kullanıcı Adı",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "E-posta",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Şifre",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Hesap başarıyla oluşturuldu!")),
                );
                Navigator.pop(context); // Geri dön
              },
              child: Text("Hesap Oluştur"),
            ),
          ],
        ),
      ),
    );
  }
}
