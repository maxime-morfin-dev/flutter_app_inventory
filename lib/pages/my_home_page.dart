import 'package:flutter/material.dart';
import 'package:inventaire_flutter_app/models/inventory.dart';
import 'package:inventaire_flutter_app/pages/inventory_product_page.dart';
import 'package:inventaire_flutter_app/utils/addInventoryDialog.dart';

import '../main.dart';

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePage();

}

class _MyHomePage extends State<MyHomePage>  {

  final List<Inventory> _inventoryList = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Stock',
                  style: TextStyle(
                      fontSize: 40
                  ),
                )
              ],
            ),
          ),
         ListView.builder(
           scrollDirection: Axis.vertical,
           shrinkWrap: true,
           itemCount: _inventoryList.length,
           itemBuilder: (BuildContext context, int index){
             return Card(
               margin: const EdgeInsets.only(top: 10, bottom: 10),
               elevation: 5,
               shape: Border(
                 left: BorderSide(
                   width: 5,
                   color: randomMaterialColor(),
                 )
               ),
               child: InkWell(
                 onTap: (){
                   _goToInventoryProductPage(context, _inventoryList[index]);
                 },
                 child: Padding(
                   padding: const EdgeInsets.all(20),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Row(
                         children: [
                           Padding(
                             padding: const EdgeInsets.all(12),
                             child: Text(
                               '#${index+1}',
                               style: const TextStyle(
                                 color: Colors.grey,
                                 fontSize: 20,
                               ),
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.all(12),
                             child: Text(
                              _inventoryList[index].nom,
                               style: const TextStyle(
                                 color: Colors.black87,
                                 fontSize: 20,
                               ),
                             ),
                           )
                         ],
                       ),
                       Column(
                         children: const [
                           Icon(Icons.keyboard_arrow_right)
                         ],
                       )
                     ],
                   ),
                 ),
               ),
             );
           }
         ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 50,
        height: 70,
        child: FloatingActionButton(
          heroTag: 'addInventoryActionBtn',
          onPressed: _showInventoryDialog,
          shape: const ContinuousRectangleBorder(
              side: BorderSide.none
          ),
          child:  const Icon(
            Icons.add,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  void _addInventoryData(String name){
    Inventory inventoryToAdd = Inventory(nom: name, produits: const []);
    setState(() {
      _inventoryList.add(inventoryToAdd);
    });
  }

  void removeInventoryData(Inventory inventory){
    setState(() {
      _inventoryList.remove(inventory);
    });
  }

  void _majOfInventoryList(Inventory newInventory, Inventory inventory){
    final index = _inventoryList.indexOf(inventory);

    if(index != -1) {
      setState(() {
        _inventoryList[index] = _inventoryList[index].copyWith(
          nom: newInventory.nom,
          produits: newInventory.produits
        );
      });
    }
  }


  Future<void> _showInventoryDialog() async{
    final result = await showDialog<String>(context: context, builder: (_){
      return const AlertDialog(
        content: AddInventoryDialog(null),
      );
    });

    if(result == null) return;

    _addInventoryData(result);
  }

  Future<void> _goToInventoryProductPage(BuildContext context, Inventory inventory) async {
     final result = await Navigator.of(context).push<Inventory>(
      MaterialPageRoute<Inventory>(
        builder: (context) => InventoryProductPage(inventory: inventory, onRemove: removeInventoryData)
      )
    );

     if(result == null) return;

     _majOfInventoryList(result, inventory);
  }
}
