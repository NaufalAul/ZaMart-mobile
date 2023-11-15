import 'package:flutter/material.dart';
import 'package:zamart/screens/item_form.dart';
import 'package:zamart/screens/item_list.dart';
class ShopItem {
  final String name;
  final IconData icon;
  final Color color;

  ShopItem(this.name, this.icon, this.color);
}


class Item {
  final String name;
  final String category;
  final int amount;
  final int price;
  final String description;

  Item({
    required this.name,
    required this.category,
    required this.amount,
    required this.price,
    required this.description,
  });
}

class ShopCard extends StatelessWidget {
  final ShopItem item;

  const ShopCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color, // Menggunakan warna dari variabel buttonColor
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));
          
          if (item.name == "Lihat Item") {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ItemListPage(),
                ));
          }

          if (item.name == "Tambah Item") {
            Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShopFormPage(),
                  ));
          }
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}