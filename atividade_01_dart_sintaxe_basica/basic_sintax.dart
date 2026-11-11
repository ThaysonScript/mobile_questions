enum Classificacao { semAvaliacoes, baixa, regular, alta }

void main() {
  const notaMinima = 1;
  const notaMaxima = 5;
  const notaPositiva = 4;

  // Todas as notas recebidas representam números inteiros.
  // Algumas estão fora do intervalo permitido.
  final Map<String, List<String>> notasRecebidas = {
    'Agenda UFAPE': ['5', '4', '5', '0', '3', '6'],
    'Biblioteca Digital': ['3', '2', '4', '1'],
    'Mapa do Campus': [],
    'Restaurante Universitário': ['5', '5', '4', '4', '5'],
    'Transporte Universitário': ['0', '6', '-1'],
  };

  final Map<String, String> categoriasPorApp = {
    'Agenda UFAPE': 'Organização',
    'Biblioteca Digital': 'Serviços',
    'Mapa do Campus': 'Localização',
    'Restaurante Universitário': 'Serviços',
    'Transporte Universitário': 'Serviços',
  };

  final Map<String, String?> contatosPorApp = {
    'Agenda UFAPE': 'agenda@exemplo.com',
    'Biblioteca Digital': null,
    'Mapa do Campus': 'mapa@exemplo.com',
    'Restaurante Universitário': 'ru@exemplo.com',
    // Transporte Universitário não possui chave neste mapa.
  };

  final notasValidasPorApp = <String, List<int>>{};
  final descartadasPorApp = <String, int>{};
  final categoriasUnicas = <String>{};

  // QUESTÃO 1 — PREPARAÇÃO DOS DADOS
  // TODO: percorra todos os aplicativos e converta as notas para int.      check
  // Guarde notas de 1 a 5 em notasValidasPorApp,                           check
  // conte as demais em descartadasPorApp                                   check
  // reúna as categorias em categoriasUnicas.
  // Inclua no resultado também os aplicativos sem notas válidas.

  for (final String app in notasRecebidas.keys) {
    final List<int> notas_validas = [];
    int descartadas = 0;

    for (final String notaStr in notasRecebidas[app]!) {

      final int? nota = int.tryParse(notaStr);

      if (nota != null && nota >= notaMinima && nota <= notaMaxima) {
        notas_validas.add(nota);
      } else {
        descartadas += 1;
      }
    }
    notasValidasPorApp[app] = notas_validas;

    descartadasPorApp[app] = descartadas;


    final String? categoria = categoriasPorApp[app];

    if (categoria != null) {
      categoriasUnicas.add(categoria);
    }
  }

  // QUESTÃO 2 — RELATÓRIO
  print('RELATÓRIO DE AVALIAÇÕES');
  print('======================');

  // TODO: para cada aplicativo, mostre categoria, contato, quantidade de
  // notas válidas e descartadas, média, porcentagem de notas positivas
  // (maiores ou iguais a notaPositiva) e classificação.
  // Use o enum Classificacao e switch para o texto da classificação.
  // Trate a ausência de contato e evite divisão por zero.

  for (final app in notasRecebidas.keys) {
    final notas = notasValidasPorApp[app]!;
    final descartadas = descartadasPorApp[app]!;

    final categoria = categoriasPorApp[app];
    final contato = contatosPorApp[app];

    final quantidade = notas.length;

    final soma = notas.fold<int>(0, (total, nota) => total + nota);

    final media = quantidade > 0 ? soma / quantidade : 0.0;

    final positivas = notas.where((nota) => nota >= notaPositiva).length;

    final porcentagemPositivas = quantidade > 0
        ? (positivas / quantidade) * 100
        : 0.0;

    final Classificacao classificacao;

    if (quantidade == 0) {
      classificacao = Classificacao.semAvaliacoes;
    } else if (media < 2.5) {
      classificacao = Classificacao.baixa;
    } else if (media < 4.0) {
      classificacao = Classificacao.regular;
    } else {
      classificacao = Classificacao.alta;
    }

    final textoClassificacao = switch (classificacao) {
      Classificacao.semAvaliacoes => 'Sem avaliações',
      Classificacao.baixa => 'Baixa',
      Classificacao.regular => 'Regular',
      Classificacao.alta => 'Alta',
    };

    print('\nAplicativo: $app');
    print('Categoria: $categoria');
    print('Contato: $contato');
    print('Notas válidas: $quantidade');
    print('Notas descartadas: $descartadas');
    print('Média: ${media.toStringAsFixed(2)}');
    print('Notas positivas: ${porcentagemPositivas.toStringAsFixed(2)}%');
    print('Classificação: $textoClassificacao');
  }

  print('\nCATEGORIAS ENCONTRADAS');
  // TODO: exiba as categorias sem repetições.

  for (final categoria in categoriasUnicas) {
    print('- $categoria');
  }
}
