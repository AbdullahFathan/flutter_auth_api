import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../widget/utility.dart';
import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
            title: const Text("Register Page"),
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
                  context.read<AuthBloc>().add(Register(
                      email: _emailTextController.text,
                      password: _passwordTextController.text));
                },
                child: const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
