abstract class Livro {
  final String codigo;
  String _titulo;
  final String? autor;

  Livro({required this.codigo, required String titulo, this.autor})
    : _titulo = titulo.trim();

  String get titulo => _titulo;

  set titulo(String novoTitulo) {
    if (novoTitulo.isNotEmpty) {
      _titulo = novoTitulo.trim();
    }
  }

  String descricao();
}

extension ReferenciaLivro on Livro {
  String get referencia {
    return '$titulo - ${autor ?? "Autor desconhecido"}';
  }
}

class LivroFisico extends Livro {
  final int numeroPaginas;

  LivroFisico({
    required super.codigo,
    required super.titulo,
    super.autor,
    required this.numeroPaginas,
  });

  @override
  String descricao() {
    return '''
        codigo: $codigo
        titulo: $titulo
        autor: ${autor ?? "Autor desconhecido"}
        numero paginas: $numeroPaginas
        referencia: $referencia
    ''';
  }
}

class LivroDigital extends Livro {
  final double tamanhoMB;

  LivroDigital({
    required super.codigo,
    required super.titulo,
    super.autor,
    required this.tamanhoMB,
  });

  @override
  String descricao() {
    return '''
        codigo: $codigo
        titulo: $titulo
        autor: ${autor ?? "Autor desconhecido"}
        tamanho: $tamanhoMB MB
        referencia: $referencia
    ''';
  }
}

void exibirCatalogo(List<Livro> catalogo) {
  print('========== CATALOGO DA BIBLIOTECA ==========');

  for (var livro in catalogo) {
    print(livro.descricao());
    print('-------------------------------------------');
  }
}

void main() {
  // livros fisicos
  LivroFisico livro1 = LivroFisico(
    codigo: 'F001',
    titulo: '  Dom Casmurro  ',
    autor: 'Machado de Assis',
    numeroPaginas: 256,
  );

  LivroFisico livro2 = LivroFisico(
    codigo: 'F002',
    titulo: 'O Pequeno Príncipe',
    numeroPaginas: 96,
  );

  // livros digitais
  LivroDigital livro3 = LivroDigital(
    codigo: 'D001',
    titulo: 'Clean Code',
    autor: 'Robert C. Martin',
    tamanhoMB: 5.5,
  );

  LivroDigital livro4 = LivroDigital(
    codigo: 'D002',
    titulo: 'Dart para Iniciantes',
    tamanhoMB: 2.3,
  );

  print('Catalogo inicial sem alteracoes:');
  exibirCatalogo([
    livro1,
    livro2,
    livro3,
    livro4
  ]);

  livro1.titulo = '  Memórias Póstumas de Brás Cubas  ';
  print('\nApos alteracao do titulo do livro 1 com espacos e texto:');
  exibirCatalogo([
    livro1,
    livro2,
    livro3,
    livro4
  ]);

  livro1.titulo = '   ';
  print('\nApos tentativa de alteracao do titulo do livro 1 com apenas espacos:');
  exibirCatalogo([
    livro1,
    livro2,
    livro3,
    livro4
  ]);
}
