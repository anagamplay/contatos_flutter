class Contato {
  int? id;
  String? nome;
  String? telefone;

  Contato({
    this.id,
    this.nome,
    this.telefone,
  });

  Contato.fromJson(json)
      : id = json['id'],
        nome = json['nome'],
        telefone = json['telefone'];

  toJson() => {
        'id': id,
        'nome': nome,
        'telefone': telefone,
      };
}
