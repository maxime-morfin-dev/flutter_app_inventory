import 'package:flutter/foundation.dart';
import 'package:inventaire_flutter_app/models/product.dart';

@immutable
class Inventory {
  final String nom;
  final List<Product> produits;

  const Inventory({
    required this.nom, 
    required this.produits
  });

  Inventory copyWith({
    String? nom,
    List<Product>? produits
  }) {
    return Inventory(
      nom: nom ?? this.nom, 
      produits: produits ?? this.produits
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;

    return other is Inventory &&
      other.nom == nom &&
      other.produits == produits;
  }

  @override
  int get hashCode => nom.hashCode ^
                      produits.hashCode;
}