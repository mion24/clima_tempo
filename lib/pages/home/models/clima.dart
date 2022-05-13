class Clima {
  Clima(
      {this.cidade,
      this.climaNaSemana,
      this.data,
      this.descricao,
      this.hora,
      this.temperatura});

  final String? cidade;
  final int? temperatura;
  final String? data;
  final String? hora;
  final String? descricao;
  final List<ClimaNaSemana>? climaNaSemana;
}

class ClimaNaSemana {
  ClimaNaSemana({
    this.data,
    this.descricao,
    this.diaNaSemana,
    this.maxima,
    this.minima,
  });

  final String? data;
  final String? diaNaSemana;
  final int? maxima;
  final int? minima;
  final String? descricao;
}
