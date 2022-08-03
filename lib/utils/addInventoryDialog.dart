import 'package:flutter/material.dart';

class AddInventoryDialog extends StatefulWidget {

  final String? inventoryName;

  const AddInventoryDialog(this.inventoryName, {super.key});

  @override
  State<AddInventoryDialog> createState() => _AddInventoryDialogState();

}

class _AddInventoryDialogState extends State<AddInventoryDialog> {

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.inventoryName);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      height: 300,
      width: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:  [
          const Text(
            'Nom de l\'inventaire',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 24
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Nom'
            ),
            controller: _controller,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black87
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text('Annuler'),
              ),
              ElevatedButton(
                onPressed: (){
                  Navigator.pop(context, _controller.text);
                },
                style: ElevatedButton.styleFrom(
                  shape: const ContinuousRectangleBorder(side: BorderSide.none)
                ),
                child: const Text('Ok'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
