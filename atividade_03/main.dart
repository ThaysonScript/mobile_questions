import 'package:material_ui/material_ui.dart';

class Produto {
  final String nome;
  final double preco;
  final IconData icone;

  const Produto({required this.nome, required this.preco, required this.icone});
}

class ProdutoCard extends StatelessWidget {
  final List<Produto> produtos;

  const ProdutoCard({super.key, required this.produtos});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (Produto produto in produtos)
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                Card(
                  elevation: 3,
                  color: Colors.indigoAccent.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Icon(produto.icone),
                        SizedBox(width: 30),
                        Expanded(child: Text(produto.nome)),
                        Text('R\$ ${produto.preco}'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
      ],
    );
  }
}

class ItemCard extends StatelessWidget {
  final IconData icon;
  final String titulo;

  const ItemCard({super.key, required this.icon, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () => {},
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Row(children: [Icon(icon), Text(titulo)]),
          ),
        ),
      ],
    );
  }
}

class MenuBar extends StatelessWidget {
  const MenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Menu Caixa'),
            SizedBox(height: 30),
            ItemCard(icon: Icons.add_shopping_cart, titulo: 'Novo pedido'),
            ItemCard(icon: Icons.history, titulo: 'Histórico'),
            ItemCard(icon: Icons.settings, titulo: 'Configurações'),
          ],
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  static const List<Produto> _produtos = [
    Produto(
      nome: 'Pizza de calabresa com cebola e azeitonas',
      preco: 45.00,
      icone: Icons.local_pizza,
    ),
    Produto(nome: 'Suco de laranja', preco: 12.00, icone: Icons.local_cafe),
    Produto(nome: 'Hambúrguer duplo', preco: 32.00, icone: Icons.lunch_dining),
    Produto(nome: 'Pão de queijo', preco: 8.00, icone: Icons.bakery_dining),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pedido Flash')),
      drawer: MenuBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, top: 20, bottom: 10),
            child: Text('Cardápio Rápido'),
          ),
          ProdutoCard(produtos: _produtos),
        ],
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}

void main() {
  runApp(const MainApp());
}
