import 'package:flutter/material.dart';
import '../theme/neobrutalism.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeoColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: NeoBox.decoration(
                      color: NeoColors.secondary,
                      radius: 14,
                      borderWidth: 2.5,
                      shadowOffset: const Offset(4, 4),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NeoBadge(
                          text: 'CATATANKU AUTH',
                          color: Colors.white,
                          fontSize: 11,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Selamat Datang Kembali!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: NeoColors.black,
                            letterSpacing: -0.5,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Kelola semua catatan harianmu tanpa batasan.',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: NeoColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  Container(
                    decoration: NeoBox.decoration(
                      color: Colors.white,
                      radius: 12,
                      borderWidth: 2.2,
                      shadowOffset: const Offset(3, 3),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                      decoration: const InputDecoration(
                        labelText: 'Email atau Username',
                        labelStyle: TextStyle(
                          color: NeoColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        prefixIcon: Icon(Icons.person, color: NeoColors.black),
                        border: InputBorder.none,
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Masukkan email atau username';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 18),

                  Container(
                    decoration: NeoBox.decoration(
                      color: Colors.white,
                      radius: 12,
                      borderWidth: 2.2,
                      shadowOffset: const Offset(3, 3),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                          color: NeoColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        prefixIcon: const Icon(Icons.lock, color: NeoColors.black),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                            color: NeoColors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        border: InputBorder.none,
                      ),
                      validator: (val) {
                        if (val == null || val.length < 6) {
                          return 'Password minimal 6 karakter';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 28),

                  NeoButton(
                    onPressed: _handleLogin,
                    color: NeoColors.primary,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('MASUK SEKARANG'),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward_rounded, color: NeoColors.black),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  Row(
                    children: [
                      const Expanded(
                        child: Divider(color: NeoColors.black, thickness: 2),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: NeoColors.black, width: 1.5),
                        ),
                        child: const Text(
                          'ATAU',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: NeoColors.black,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Divider(color: NeoColors.black, thickness: 2),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  NeoButton(
                    onPressed: _handleLogin,
                    color: Colors.white,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.g_mobiledata_rounded, size: 28, color: NeoColors.black),
                        SizedBox(width: 6),
                        Text('Masuk dengan Google'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
