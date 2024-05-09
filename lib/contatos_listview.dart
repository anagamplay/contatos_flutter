import 'dart:async';

import 'package:contatos_flutter/contato.dart';
import 'package:contatos_flutter/contato_form_page.dart';
import 'package:contatos_flutter/contatos_service.dart';
import 'package:flutter/material.dart';

class ContatosListview extends StatefulWidget {
  const ContatosListview({super.key});

  @override
  State<ContatosListview> createState() => _ContatosListviewState();
}

class _ContatosListviewState extends State<ContatosListview> {
  Future<List<Contato>>? future;

  @override
  void initState() {
    super.initState();

    future = ContatosService.getContatos();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        List<Contato> contatos = snapshot.data ?? [];

        return contatos.length > 0
            ? ListView.builder(
                itemCount: contatos.length,
                itemBuilder: (context, index) {
                  Contato contato = contatos[index];

                  return Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                    margin: EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueGrey[50],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${contato.nome}'),
                            Text('${contato.telefone}'),
                          ],
                        ),
                        PopupMenuButton(
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                value: 0,
                                child: Text('Editar'),
                              ),
                              PopupMenuItem(
                                value: 1,
                                child: Text('Excluir'),
                              ),
                            ];
                          },
                          onSelected: (value) {
                            if (value == 0) {
                              _onClickEditar(contato);
                            } else if (value == 1) {
                              _onClickExcluir(contato);
                            }
                          },
                        )
                      ],
                    ),
                  );
                },
              )
            : Center(
                child: Container(child: Text('Adicione novos contatos!')),
              );
      },
    );
  }

  void _onClickEditar(contato) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ContatoFormPage(contato: contato,)));
  }

  void _onClickExcluir(contato) async {
    await ContatosService.delete(contato);

    setState(() {
      future = ContatosService.getContatos();
    });
  }
}
