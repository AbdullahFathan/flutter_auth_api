import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_api/repository/cache_repository.dart';
import 'package:login_api/screen/login_page.dart';

import '../bloc/auth/auth_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var tokenUser = '';
  var emailUser = '';

  getDataCache() async {
    await Cache.getData('user_data').then((value) {
      setState(() {
        tokenUser = value['token'];
        emailUser = value['email'];
      });
    });
  }

  @override
  void initState() {
    getDataCache();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const LoginPage()));
        }
      },
      builder: (context, state) {
        if (state is AuthenticatedLoading) {
          return const Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text("Home Page"),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Selamat Datang $emailUser",
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Token anda:  $tokenUser",
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(Logout());
                },
                child: const Text(
                  "Log Out",
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
