import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_api/bloc/auth/auth_bloc.dart';
import 'package:login_api/screen/home_page.dart';
import 'package:login_api/screen/resgiter_page.dart';
import 'package:login_api/widget/utility.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const HomePage()));
        } else if (state is AuthEror) {
          Utility().showSnackBar(context, state.text);
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text("Login Page"),
          ),
          body: Column(
            children: [
              TextField(
                controller: _emailTextController,
                decoration: const InputDecoration(hintText: "Email"),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _passwordTextController,
                decoration: const InputDecoration(hintText: "Password"),
              ),
              const SizedBox(
                height: 45,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(Login(
                      email: _emailTextController.text,
                      password: _passwordTextController.text));
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const RegisterPage())),
                child: const Text(
                  "Dont have account ??  Make your Acount",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
