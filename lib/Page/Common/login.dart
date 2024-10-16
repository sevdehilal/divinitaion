import 'package:divinitaion/Views/client_button_navigation.dart';
import 'package:divinitaion/Models/login.dart';
import 'package:divinitaion/Page/Common/email_verification.dart';
import 'package:divinitaion/Page/Common/register.dart';
import 'package:divinitaion/Services/service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiService _loginService = ApiService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final loginModel = Login(
        userName: _usernameController.text,
        password: _passwordController.text,
      );

      LoginResponse? response = await _loginService.login(loginModel);

      if (response != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful')),
        );
        if (response.emailConfirmed == false) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => EmailVerificationPage(
                      id: response.userId,
                    )),
          );
        } else {
          if (response.roles.contains("client")) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CustomBottomNavigation()),
            );
          } else if (response.roles.contains("fortuneTeller")) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CustomBottomNavigation()),
            );
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(14.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // "Fall in Fal" başlığı
                const Text(
                  'Fall in Fal',
                  style: TextStyle(
                    color: Color.fromARGB(255, 138, 43, 226), // Morumsu renk
                    fontWeight: FontWeight.bold, // Kalın yazı
                    fontStyle: FontStyle.italic, // Eğik yazı
                    fontSize: 40, // Yazı boyutu büyük
                  ),
                ),
                const SizedBox(height: 20), // Başlık ile logo arası boşluk

                // Yuvarlak Logo
                ClipOval(
                  child: Image.asset(
                    'lib/assets/logo1.png',
                    height: 250,
                    width: 250,
                    fit: BoxFit
                        .cover, // Resmin tam ortalanıp sığdırılmasını sağlar
                  ),
                ),
                const SizedBox(height: 15),

                // Username alanı
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Password alanı
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Login butonu
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15), // Buton boyutları
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        color: Color.fromARGB(255, 175, 113, 14)), // Yazı rengi
                  ),
                ),
                const SizedBox(height: 10),

                // Şifremi Unuttum linki
                TextButton(
                  onPressed: null, // Şimdilik null, işlevi yok
                  child: const Text(
                    'Şifremi Unuttum',
                  ),
                ),
                const SizedBox(height: 10),
                Text("Hesabınız yok mu?"),

                // Kayıt Ol ve Falcı Olarak Kayıt Ol linkleri
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()),
                        );
                      },
                      child: const Text(
                        'Kayıt Ol',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
