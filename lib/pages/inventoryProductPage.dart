import 'package:flutter/material.dart';
import 'package:inventaire_flutter_app/main.dart';
import 'package:inventaire_flutter_app/models/inventory.dart';
import 'package:inventaire_flutter_app/utils/addProductDialog.dart';

import '../models/product.dart';
import '../utils/addInventoryDialog.dart';

class InventoryProductPage extends StatefulWidget {
  const InventoryProductPage({Key? key, required this.inventory}) : super(key: key);

  final Inventory inventory;

  final Function() onRemove;

  @override
  State<InventoryProductPage> createState() => _InventoryProductPageState();
}

class _InventoryProductPageState extends State<InventoryProductPage> {

  late Inventory _inventory;
  List<Product> _productList = [];

  @override
  void initState() {
    super.initState();
    _inventory = widget.inventory;
  }

  @override
  void didUpdateWidget(covariant InventoryProductPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    final args = ModalRoute.of(context)!.settings.arguments as Inventory;
    _inventory = args;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(
            Icons.arrow_back
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Center(
              child:
                Text(
                  _inventory.nom,
                  style: const TextStyle(
                      fontSize: 40
                  ),
                )
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: FloatingActionButton(
                    backgroundColor: randomMaterialColor(),
                    onPressed: _showInventoryDialog,
                    child: const Icon(Icons.edit),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: FloatingActionButton(
                    backgroundColor: randomMaterialColor(),
                    onPressed: (){
                      Navigator.pop(context, _inventory);
                    },
                    child: const Icon(Icons.delete),
                  ),
                )
              ],
            ),
            GridView.count(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              padding: const EdgeInsets.only(top:20),
              children: _inventory.produits.map((product) => Card(
                elevation: 5,
                shape: Border(
                  top: BorderSide(
                  width: 5,
                  color: randomMaterialColor(),
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top:20, bottom: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          product.nom,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      Text(
                        "Quantité : ${product.quantite}",
                        style: const TextStyle(
                          fontSize: 18
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed:(){
                                if(product.quantite == 1){
                                  setState(() {
                                    _inventory.produits.remove(product);
                                  });
                                }else{
                                  setState(() {
                                    _inventory = _inventory.copyWith(
                                      produits: [
                                        for (final item in _inventory.produits) 
                                          if (item.nom == product.nom) 
                                            item.copyWith(quantite: item.quantite - 1)
                                          else 
                                            item
                                      ]
                                    );
                                  });
                                }
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            IconButton(
                              onPressed: (){
                                final productToModify = inventory!.produits.firstWhere((item) => item.nom == product.nom);
                                setState(() => productToModify.quantite += 1);
                              },
                              icon: const Icon(Icons.add),
                            ),
                            IconButton(
                              onPressed: (){
                                _showProductDialog(product.nom);
                              },
                              icon: const Icon(Icons.edit),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              )).toList(),
            )
          ],
        ),
      floatingActionButton: SizedBox(
        width: 50,
        height: 70,
        child:  FloatingActionButton(
          heroTag: "fbtn1",
          onPressed: (){
            _showProductDialog(null);
          },
          shape: const ContinuousRectangleBorder(side: BorderSide.none),
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }


    void _showInventoryDialog() async{
      final result = await showDialog<String?>(context: context, builder: (_){
        return AlertDialog(
          content: AddInventoryDialog(inventory?.nom),
        );
      });

      if (result == null) return;

      setState(() {
        inventory = inventory?.copyWith(
          nom: result
        );
      });
    }

    void _showProductDialog(String? name) async{
      final result = await showDialog<String?>(context: context, builder: (_){
        return AlertDialog(
          content: AddProductDialog(name),
        );
      });

      if (result == null) return;

      if(name != null){
        final productToModify = inventory?.produits.firstWhere((item) => item.nom == name);
        setState(() => productToModify!.nom = result);
      }else{
        setState(() {
          inventory?.produits.add(Product(result, 1));
        });
      }
    }

}
