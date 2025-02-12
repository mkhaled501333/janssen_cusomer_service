import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:janssen_cusomer_service/Ui/recourses/widgets.dart';
import 'package:janssen_cusomer_service/Ui/users/data/local.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 169, 182, 169),
      // appBar: AppBar(
      //   title:,
      // ),
      body: Stack(
        children: [
          Image.asset(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
              "assets/ba.jpg"),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 9),
                child: ServerStutus(),
              ),
              // const Text('الدخول ب اسم'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).nextFocus();
                          },
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0)),
                          decoration: const InputDecoration(
                              labelText: 'username',
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.teal)),
                              border: OutlineInputBorder(),
                              focusColor: Colors.lightBlue,
                              labelStyle: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 3, 38, 241),
                                  fontWeight: FontWeight.bold),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              fillColor: Color.fromARGB(31, 3, 67, 241),
                              filled: true),
                          controller: _emailController,
                        ),
                      ),
                      const Gap(11),
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          onFieldSubmitted: (v) {
                            authProvider.login(_emailController.text,
                                _passwordController.text);
                          },
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0)),
                          decoration: const InputDecoration(
                              labelText: 'password',
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.teal)),
                              border: OutlineInputBorder(),
                              focusColor: Colors.lightBlue,
                              labelStyle: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 3, 38, 241),
                                  fontWeight: FontWeight.bold),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              fillColor: Color.fromARGB(31, 3, 67, 241),
                              filled: true),
                          controller: _passwordController,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          authProvider.login(
                              _emailController.text, _passwordController.text);
                        },
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
