class Amostra {
  int? idAmostra;
  int idProjeto;
  String amostra;
  String codigo;
  double circunferencia;
  double alturaComercial;
  double alturaTotal;
  int qualidadeFuste;

  Amostra({
    this.idAmostra,
    required this.idProjeto,
    required this.amostra,
    required this.codigo,
    required this.circunferencia,
    required this.alturaComercial,
    required this.alturaTotal,
    required this.qualidadeFuste,
  });

  Map<String, dynamic> toMap() {
    return {
      'idAmostra': idAmostra,
      'idProjeto': idProjeto,
      'amostra': amostra,
      'codigo': codigo,
      'circunferencia': circunferencia,
      'alturaComercial': alturaComercial,
      'alturaTotal': alturaTotal,
      'qualidadeFuste': qualidadeFuste,
    };
  }

  factory Amostra.fromMap(Map<String, dynamic> mapa) {
    return Amostra(
      idAmostra: mapa['idAmostra'],
      idProjeto: mapa['idProjeto'],
      amostra: mapa['amostra'],
      codigo: mapa['codigo'],
      circunferencia: mapa['circunferencia'],
      alturaComercial: mapa['alturaComercial'],
      alturaTotal: mapa['alturaTotal'],
      qualidadeFuste: mapa['qualidadeFuste'],
    );
  }
}
