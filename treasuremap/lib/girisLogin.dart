import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login() async {
    final prefs = await SharedPreferences.getInstance();
    String? usersJson = prefs.getString("users");
    if (usersJson != null) {
      List<dynamic> users = jsonDecode(usersJson);
      for (var user in users) {
        if (emailController.text == user["email"] &&
            passwordController.text == user["password"]) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Giriş Başarılı!")));
          await prefs.setBool("isLoggedIn", true);
          await prefs.setString("username", user["username"]);
          Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
          return;
        }
      }
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Hatalı e-posta veya şifre!")));
  }

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
              controller: emailController,
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
            ElevatedButton(onPressed: _login, child: Text("Giriş Yap")),
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

class HesapOlusturScreen extends StatefulWidget {
  @override
  _HesapOlusturScreenState createState() => _HesapOlusturScreenState();
}

class _HesapOlusturScreenState extends State<HesapOlusturScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _register(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    String? usersJson = prefs.getString("users");
    List<dynamic> users = usersJson != null ? jsonDecode(usersJson) : [];
    users.add({
      "username": usernameController.text,
      "email": emailController.text,
      "password": passwordController.text,
    });
    await prefs.setString("users", jsonEncode(users));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Hesap başarıyla oluşturuldu!")));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hesap Oluştur")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: "Kullanıcı Adı",
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? "Kullanıcı adı boş olamaz!"
                            : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "E-posta",
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? "E-posta boş olamaz!"
                            : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Şifre",
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? "Şifre boş olamaz!"
                            : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _register(context),
                child: Text("Hesap Oluştur"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SifremiUnuttumScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Şifre sıfırlama e-postası gönderildi!"),
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
