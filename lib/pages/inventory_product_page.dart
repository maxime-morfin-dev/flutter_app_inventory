import 'package:flutter/material.dart';
import 'package:inventaire_flutter_app/main.dart';
import 'package:inventaire_flutter_app/models/inventory.dart';
import 'package:inventaire_flutter_app/utils/addProductDialog.dart';

import '../models/product.dart';
import '../utils/addInventoryDialog.dart';

class InventoryProductPage extends StatefulWidget {
  const InventoryProductPage({Key? key, required this.inventory, required this.onRemove}) : super(key: key);

  final Inventory inventory;
  final Function(Inventory inventory) onRemove;

  @override
  State<InventoryProductPage> createState() => _InventoryProductPageState();
}

class _InventoryProductPageState extends State<InventoryProductPage> {

  late Inventory _inventory;

  @override
  void initState() {
    _inventory = widget.inventory;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant InventoryProductPage oldWidget) {
    _inventory = widget.inventory;
    super.didUpdateWidget(oldWidget);
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
            Navigator.pop(context, _inventory);
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
                    heroTag: 'editInventoryActionBtn',
                    backgroundColor: randomMaterialColor(),
                    onPressed: _showInventoryDialog,
                    child: const Icon(Icons.edit),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: FloatingActionButton(
                    heroTag: 'deleteInventoryActionBtn',
                    backgroundColor: randomMaterialColor(),
                    onPressed: (){
                      widget.onRemove(_inventory);
                      Navigator.pop(context);
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
                        padding: const EdgeInsets.only(bottom: 10),
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
                                  _removeProductFromList(product);
                                }else{
                                  _decrementProduct(product);
                                }
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            IconButton(
                              onPressed: (){
                                _incrementProduct(product);
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
          heroTag: 'addProductActionBtn',
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

  Future<void> _showInventoryDialog() async{
    final result = await showDialog<String>(context: context, builder: (_){
      return AlertDialog(
        content: AddInventoryDialog(_inventory.nom),
      );
    });

    if(result == null) return;

    setState(() {
      _inventory = _inventory.copyWith(
        nom: result
      );
    });
  }

  Future<void> _showProductDialog(String? name) async{
    final result = await showDialog<String>(context: context, builder: (_){
      return AlertDialog(
        content: AddProductDialog(name),
      );
    });

    if(result == null) return;

    if(name != null){
      _modifyProductName(name, result);
    }else{
      _addProductToList(result);
    }
  }

  void _addProductToList(String name){
    setState(() {
      Product produitToAdd = Product(nom: name, quantite: 1);
      _inventory = _inventory.copyWith(
          produits: [..._inventory.produits, produitToAdd]
      );
    });
  }

  void _removeProductFromList(Product product){
    setState(() {
      _inventory.produits.remove(product);
    });
  }

  void _decrementProduct(Product product){
    setState((){
      _inventory = _inventory.copyWith(
          produits: [
            for(final item in _inventory.produits)
              if(item.nom == product.nom)
                item.copyWith(
                    quantite: item.quantite - 1
                )
              else(
                  item
              )
          ]
      );
    });
  }

  void _incrementProduct(Product product){
    setState(() {
      _inventory = _inventory.copyWith(
          produits: [
            for(final item in _inventory.produits)
              if(item.nom == product.nom)
                item.copyWith(
                    quantite: item.quantite +1
                )
              else(
                  item
              )
          ]
      );
    });
  }

  void _modifyProductName(String name, String newName){
    setState((){
      _inventory = _inventory.copyWith(
          produits: [
            for(final item in _inventory.produits)
              if(item.nom == name)
                item.copyWith(
                    nom: newName
                )else
                item
          ]
      );
    });
  }
}
