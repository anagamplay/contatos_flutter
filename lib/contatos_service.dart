import 'dart:convert';

import 'package:contatos_flutter/contato.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContatosService {
  static Future<void> _updatePrefs(List<Contato> list) async {
    final _prefs = await SharedPreferences.getInstance();
    List<String> contatos = list.map((contato) => jsonEncode(contato.toJson())).toList();
    await _prefs.setStringList('contatos', contatos);
  }

  static Future<List<Contato>> getContatos() async {
    final _prefs = await SharedPreferences.getInstance();
    List<String>? json = _prefs.getStringList('contatos');
    return json?.map((json) => Contato.fromJson(jsonDecode(json))).toList() ?? [];
  }

  static Future<void> save(Contato c) async {
    List<Contato> list = await getContatos();
    list.add(c);
    _updatePrefs(list);
  }

  static Future<void> edit(Contato c) async {
    List<Contato> list = await getContatos();
    int contatoIdx = list.indexWhere((contato) => contato.id == c.id);
    list[contatoIdx] = c;
    _updatePrefs(list);
  }

  static Future<void> delete(Contato c) async {
    List<Contato> list = await getContatos();
    list.removeWhere((contato) => contato.id == c.id);
    _updatePrefs(list);
  }

  static Future<int> generateID() async {
    final _prefs = await SharedPreferences.getInstance();
    int idConter = _prefs.getInt('idCounter') ?? 0;
    idConter++;
    _prefs.setInt('idCounter', idConter);
    return idConter;
  }
}
