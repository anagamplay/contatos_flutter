import 'package:contatos_flutter/contato_form_page.dart';
import 'package:contatos_flutter/contatos_listview.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Contatos'),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: _onClickFloatingB,
        child: Icon(Icons.add),
      ),
    );
  }

  _body() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: ContatosListview(),
    );
  }

  void _onClickFloatingB() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ContatoFormPage()));
  }
}
