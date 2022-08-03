import 'package:flutter/material.dart';
import 'package:inventaire_flutter_app/models/product.dart';

class Inventory {
  String nom;
  List<Product> produits;

  Inventory(this.nom, this.produits);
}