import 'package:flutter/material.dart';
import 'package:inventaire_flutter_app/models/inventory.dart';
import 'package:inventaire_flutter_app/utils/addInventoryDialog.dart';

import '../main.dart';

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePage();

}

class _MyHomePage extends State<MyHomePage>  {

  List<Inventory> inventoryList = [];

  void addInventoryData(String name){
    setState(() {
      inventoryList.add(Inventory(name, []));
    });
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context, Inventory inventory) async {
    final result = await Navigator.pushNamed(
      context,
      '/inventoryProducts',
      arguments: inventory
    );

    if(!mounted) return;

    setState(() {
      inventoryList.remove(result);
    });
  }




  @override
  Widget build(BuildContext context) {

    void showInventoryDialog() async{
      final result = await showDialog(context: context, builder: (_){
        return const AlertDialog(
          content: AddInventoryDialog(null),
        );
      });

      if(!mounted) return;

      setState(() {
        inventoryList.add(Inventory(result, []));
      });
    }

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
           itemCount: inventoryList.length,
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
                   _navigateAndDisplaySelection(context, inventoryList[index]);
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
                              inventoryList[index].nom,
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
          onPressed: showInventoryDialog,
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
}
