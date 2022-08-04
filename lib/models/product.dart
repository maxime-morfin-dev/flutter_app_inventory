import 'package:flutter/material.dart';

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
  }) {
    return Product(
      nom: nom ?? this.nom,
      quantite: quantite ?? this.quantite
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
  }
}