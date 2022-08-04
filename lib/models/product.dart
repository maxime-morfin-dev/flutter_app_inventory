import 'package:flutter/foundation.dart';

@immutable
class Product {
  final String nom;
  final int quantite;

  const Product({
    required this.nom,
    required this.quantite
  });

  Product copyWith({
    String? nom,
    int? quantite
  }){
    return Product(
      nom: nom ?? this.nom,
      quantite: quantite ?? this.quantite
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          nom == other.nom &&
          quantite == other.quantite;

  @override
  int get hashCode => nom.hashCode ^ quantite.hashCode;
}