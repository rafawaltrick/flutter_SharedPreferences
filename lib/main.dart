import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

// dev_dependencies:

//  flutter_test:

//    sdk: flutter

//  shared_preferences: ^2.0.7

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared Preferences Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _complementoController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _siteController = TextEditingController();

// nome
// endereço
// número
// complemento
// cidade
// estado
// e-mail
// site

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _cidadeController.dispose();
    _complementoController.dispose();
    _enderecoController.dispose();
    _estadoController.dispose();
    _numeroController.dispose();
    _siteController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              obscureText: true,
            ),
            TextField(
              controller: _enderecoController,
              decoration: const InputDecoration(labelText: 'Endereco'),
              obscureText: true,
            ),
            TextField(
              controller: _estadoController,
              decoration: const InputDecoration(labelText: 'Estado'),
              obscureText: true,
            ),
            TextField(
              controller: _numeroController,
              decoration: const InputDecoration(labelText: 'Numero'),
              obscureText: true,
            ),
            TextField(
              controller: _complementoController,
              decoration: const InputDecoration(labelText: 'Complemento'),
              obscureText: true,
            ),
            TextField(
              controller: _cidadeController,
              decoration: const InputDecoration(labelText: 'Cidade'),
              obscureText: true,
            ),
            TextField(
              controller: _siteController,
              decoration: const InputDecoration(labelText: 'Site'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                print("save");

                final username = _nomeController.text;
                final email = _emailController.text;
                final cidade = _cidadeController.text;
                final estado = _estadoController.text;
                final numero = _numeroController.text;
                final endereco = _enderecoController.text;
                final complemento = _complementoController.text;
                final site = _siteController.text;

                final prefs = await SharedPreferences.getInstance();

                final usernameSaved =
                    await prefs.setString("username", username);
                final emailSaved = await prefs.setString("email", email);
                final cidadeSaved = await prefs.setString("cidade", cidade);
                final estadoSaved = await prefs.setString("estado", estado);
                final numeroSaved = await prefs.setString("numero", numero);
                final enderecoSaved =
                    await prefs.setString("endereco", endereco);
                final complementoSaved =
                    await prefs.setString("complemento", complemento);
                final siteSaved = await prefs.setString("site", site);
              },
              child: const Text('Save'),
            ),
            ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();

                final username = prefs.getString("username");
                final email = prefs.getString("email");
                final cidade = prefs.getString("cidade");
                final estado = prefs.getString("estado");
                final numero = prefs.getString("numero");
                final complemento = prefs.getString("complemento");
                final site = prefs.getString("site");
                final endereco = await prefs.getString("endereco");

                print(username);
                print(email);
                print(estado);
                print(cidade);
                print(numero);
                print(complemento);
                print(site);

                setState(() {
                  _nomeController.text = username.toString();
                  _emailController.text = email.toString();
                  _cidadeController.text = cidade.toString();
                  _estadoController.text = estado.toString();
                  _numeroController.text = numero.toString();
                  _enderecoController.text = endereco.toString();
                  _complementoController.text = complemento.toString();
                  _siteController.text = site.toString();
                });
              },
              child: const Text('Restore'),
            ),
            ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear(); // Corrected: Call the clear() method

                setState(() {
                  _nomeController.text = "";
                  _emailController.text = "";
                  _cidadeController.text = "";
                  _enderecoController.text = "";
                  _estadoController.text = "";
                  _numeroController.text = "";
                  _complementoController.text = "";
                  _siteController.text = "";
                });
              },
              child: const Text('Clear'),
            )
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: FutureBuilder<Map<String, String>>(
          future: SharedPreferencesHelper.getCredentials(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final username = snapshot.data!['username'];
              final email = snapshot.data!['email'];

              return Text('Username: $username\Email: $email');
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class SharedPreferencesHelper {
  static const String _kUsernameKey = 'username';
  static const String _kEmailKey = 'email';
  static const String _kCidadeKey = 'cidade';
  static const String _kEstadoKey = 'estado';
  static const String _kNumeroKey = 'numero';
  static const String _kcomplementoKey = 'complemento';
  static const String _kSiteKey = 'site';
  static const String _kEnderecoKey = 'endereco';

  static Future<Map<String, String>> getCredentials() async {
    final prefs = await SharedPreferences.getInstance();

    final username = prefs.getString(_kUsernameKey);
    final email = prefs.getString(_kEmailKey);
    final cidade = prefs.getString(_kCidadeKey);
    final estado = prefs.getString(_kEstadoKey);
    final numero = prefs.getString(_kNumeroKey);
    final complemento = prefs.getString(_kcomplementoKey);
    final site = prefs.getString(_kSiteKey);
    final endereco = prefs.getString(_kEnderecoKey);

    return {
      'username': username.toString(),
      'email': email.toString(),
      "cidade": cidade.toString(),
      "estado": estado.toString(),
      "endereco": endereco.toString(),
      "numero": numero.toString(),
      "complemento": complemento.toString(),
      "site": site.toString()
    };
  }
}
