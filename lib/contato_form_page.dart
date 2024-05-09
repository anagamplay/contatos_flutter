import 'package:contatos_flutter/contato.dart';
import 'package:contatos_flutter/contatos_service.dart';
import 'package:contatos_flutter/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class ContatoFormPage extends StatefulWidget {
  Contato? contato;

  ContatoFormPage({this.contato});

  @override
  State<ContatoFormPage> createState() => _ContatoFormPageState();
}

class _ContatoFormPageState extends State<ContatoFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _tNome = TextEditingController();
  final _tTelefone = MaskedTextController(mask: '(00) 00000-0000');

  Contato? get contato => widget.contato;

  @override
  void initState() {
    super.initState();

    if (contato != null) {
      _tNome.text = contato?.nome ?? "";
      _tTelefone.text = contato?.telefone ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contato != null ? 'Editar Contato' : 'Novo Contato'),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          children: [
            TextFormField(
              controller: _tNome,
              validator: _validator,
              decoration: InputDecoration(
                labelText: "Nome",
              ),
            ),
            TextFormField(
              controller: _tTelefone,
              validator: _validator,
              decoration: InputDecoration(
                labelText: "Telefone",
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _onClickSalvar,
              child: Text(contato != null ? 'Editar' : 'Salvar'),
            )
          ],
        ),
      ),
    );
  }

  String? _validator(String? value) {
    if (value!.isEmpty) {
      return 'Preencha este camppo';
    }
    return null;
  }

  void _onClickSalvar() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Contato c = contato ?? Contato();

    c.id = contato != null ? contato?.id : await ContatosService.generateID();
    c.nome = _tNome.text;
    c.telefone = _tTelefone.text;

    contato != null
        ? await ContatosService.edit(c)
        : await ContatosService.save(c);

    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}
