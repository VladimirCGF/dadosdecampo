class Projeto {
  int? idProjeto;
  String titulo;

  Projeto({this.idProjeto, required this.titulo});

  Map<String, dynamic> toMap() {
    return {'idProjeto': idProjeto, 'titulo': titulo};
  }

  factory Projeto.fromMap(Map<String, dynamic> mapa) {
    return Projeto(idProjeto: mapa['idProjeto'], titulo: mapa['titulo']);
  }
}
