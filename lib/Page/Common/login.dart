import 'package:divinitaion/AuthGoogle/google_auth_service.dart';
import 'package:divinitaion/Models/login.dart';
import 'package:divinitaion/Page/Common/email_verification.dart';
import 'package:divinitaion/Page/Common/register.dart';
import 'package:divinitaion/Services/service.dart';
import 'package:divinitaion/Widgets/ClientWidgets/client_navigation_bar.dart';
import 'package:divinitaion/Widgets/FortuneWidgets/fortune_teller_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiService _loginService = ApiService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _isPasswordVisible = false;
  final GoogleAuthService _googleAuthService = GoogleAuthService();
  LoginResponse? _loginResponse;

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
            await _storage.write(key: 'loggedInAs', value: "client");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CustomBottomNavigation()),
            );
          } else if (response.roles.contains("fortuneteller")) {
            await _storage.write(key: 'loggedInAs', value: "fortuneteller");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => FortuneTellerBottomNavigation()),
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

  Future<void> _checkLoginStatus() async {
    String? loggedInAs = await _storage.read(key: 'loggedInAs');
    if (loggedInAs != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CustomBottomNavigation()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  Future<void> _handleSignIn() async {
    try {
      final loginResponse = await _googleAuthService.signInWithGoogle();
      if (loginResponse.success) {
        await _storage.write(key: 'loggedInAs', value: "client");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CustomBottomNavigation()),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Giriş başarılı: ${loginResponse.message}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google ile giriş başarısız: ${loginResponse.message}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: $e')),
      );
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
                const Text(
                  'Fall in Fal',
                  style: TextStyle(
                    color: Color.fromARGB(255, 138, 43, 226),
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 40,
                  ),
                ),
                const SizedBox(height: 20),

                ClipOval(
                  child: Image.asset(
                    'lib/assets/logo1.png',
                    height: 250,
                    width: 250,
                    fit: BoxFit
                        .cover,
                  ),
                ),
                const SizedBox(height: 15),

                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                  },
                ),
                const SizedBox(height: 10),

                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                     suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),),
                  obscureText: !_isPasswordVisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  focusNode: _passwordFocusNode,
                  onFieldSubmitted: (_) {
                    _login();
                  },
                ),
                const SizedBox(height: 20),

                // Login butonu
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        color: Color.fromARGB(255, 175, 113, 14)), 
                  ),
                ),
                const SizedBox(height: 10),

                TextButton(
                  onPressed: null,
                  child: const Text(
                    'Şifremi Unuttum',
                  ),
                ),
                const SizedBox(height: 10),
                Text("Hesabınız yok mu?"),

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

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _handleSignIn,
                      child: Text('Google ile Giriş Yap'),
                    )
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
