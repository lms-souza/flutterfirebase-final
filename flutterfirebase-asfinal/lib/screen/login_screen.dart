import 'package:flutter/material.dart';
import 'package:projetoflutterapi/screen/home_screen.dart';
import 'package:projetoflutterapi/screen/register_screen.dart';
import 'package:projetoflutterapi/services/firebase/auth/firebase_auth_service.dart';
import 'package:projetoflutterapi/utils/results.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool enableVisibility = false;

  changeVisibility() {
    setState(() {
      enableVisibility = !enableVisibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          constraints: BoxConstraints(maxWidth: 400),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: StreamBuilder<Results>(
            stream: _auth.resultsLogin,
            builder: (context, snapshot) {
              ErrorResult result = ErrorResult(code: "");

              if (snapshot.data is ErrorResult) {
                result = snapshot.data as ErrorResult;
              }

              if (snapshot.data is LoadingResult) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.data is SuccessResult) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                });
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Bem-vindo",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Faça login para continuar",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue.shade700),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: enableVisibility,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue.shade700),
                      ),
                      suffixIcon: IconButton(
                        onPressed: changeVisibility,
                        icon: enableVisibility
                            ? Icon(Icons.visibility_off, color: Colors.blue.shade700)
                            : Icon(Icons.visibility, color: Colors.blue.shade700),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      minimumSize: Size(double.infinity, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      final String email = _emailController.text;
                      final String password = _passwordController.text;
                      _auth.signIn(email, password);
                    },
                    child: const Text(
                      "Entrar",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Registre-se",
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (result.code.isNotEmpty)
                    switch (result.code) {
                      "invalid-email" => Text(
                        "Autenticação inválida",
                        style: TextStyle(color: Colors.red),
                      ),
                      "wrong-password" => Text(
                        "Autenticação inválida",
                        style: TextStyle(color: Colors.red),
                      ),
                      _ => Text(
                        "Erro desconhecido",
                        style: TextStyle(color: Colors.red),
                      )
                    }
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

