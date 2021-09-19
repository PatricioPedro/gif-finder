import 'package:flutter/material.dart';

class Rafel extends StatefulWidget {
  const Rafel({Key key}) : super(key: key);

  @override
  _RafelState createState() => _RafelState();
}

class _RafelState extends State<Rafel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bem vindo ao mundo Rafael"),
        centerTitle: true,
      ),
      body: Center(child: Text('Ola mundo'),),
    );
  }
}
