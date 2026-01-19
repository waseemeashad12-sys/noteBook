import 'package:flutter/material.dart';
import 'Homepage.dart';
import 'splashScreen.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Color c = Colors.grey[100]!;

  TextEditingController _name = TextEditingController();
  TextEditingController _password = TextEditingController();

  double result = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            heightFactor: 2,
            child: Padding(
              padding: EdgeInsets.all(7.0),
              child: TextField(

                controller: _name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(
                      color: Colors.red,
                      style: BorderStyle.solid,
                      width: 5,
                    ),
                  ),
                  filled: true,
                  fillColor: c,
                  labelText: "Name",
                  hintText: "input u name",
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(7.0),
            child: TextField(
              controller: _password,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide(
                    color: Colors.red,
                    style: BorderStyle.solid,
                    width: 5,
                  ),
                ),
                filled: true,
                fillColor: c,
                labelText: "Password",
                hintText: "input u Password",
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ),
          SizedBox(height: 10),

          ElevatedButton(
            style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(c)),
            onPressed: () {
              if (_name.text == "وسيم" && _password.text == "123") {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => NotesPage()),
                      (route) => false,
                );
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => NotesPage()));
                _name.text = _password.text = "";
                setState(() {});
              }
            },
            child: Text("تسجيل الدخول"),
          ),
        ],
      ),
    );
  }
}