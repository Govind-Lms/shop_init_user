import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  bool? isFavorite;
  bool? isDiscounted;
  bool? isFeatured;
  String? id;
  String? name;
  String? desc;
  String? category;
  int? stocks;
  int? popularity;
  int? price;
  int? discountedPrice;
  String? discountPercent;
  String? imageUrl;
  Timestamp? timestamp;

  List<dynamic>? images;
  List<dynamic>? attributes;

  ItemModel({
    this.isFavorite,
    this.isDiscounted,
    this.isFeatured,
    this.id,
    this.name,
    this.desc,
    this.category,
    this.stocks,
    this.popularity,
    this.price,
    this.discountedPrice,
    this.discountPercent,
    this.imageUrl,
    this.timestamp,
    this.images,
    this.attributes,
  });

  factory ItemModel.fromJson(Map<String,dynamic> doc){
    return ItemModel(
      isFavorite : doc['isFavorite'],
      isDiscounted : doc['isDiscounted'],
      isFeatured : doc['isFeatured'],
      id : doc['id'],
      name : doc['name'],
      desc : doc['desc'],
      category : doc['category'],
      stocks : doc['stocks'],
      popularity : doc['popularity'],
      price : doc['price'],
      discountedPrice : doc['discountedPrice'],
      discountPercent : doc['discountPercent'],
      imageUrl : doc['imageUrl'],
      timestamp : doc['timestamp'],
      images : doc['images'],
      attributes : doc['attributes'],
    );
  }
}


class AttributeModel {
  String? name;
  List<String>? values;
  AttributeModel({this.name,this.values});


  toJson(){
    return {
      'name': name,
      'values': values,
    };
  }

  factory AttributeModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return AttributeModel();
    return AttributeModel(
      name: data.containsKey('name') ? data['name'] : '',
      values: List<String>. from(data['values'],
    ));
  }
}

// class VariationsModel {
//   String id;
//   String image;
//   int stock;
//   Map<String,String> attr;
//   VariationsModel({required this.id, required this.attr, required this.image, required this.stock});
//    toJson(){
//     return {
//       'attr': attr,
//       'id': id,
//       'image': image,
//       'stock': stock,
//     };
//   }
//   factory VariationsModel.fromJson(Map<String, dynamic> document) {
//     final data = document;
//     if (data.isEmpty) return VariationsModel.empty();
//     return VariationsModel(
//       attr: Map<String, String>. from(data['attr']),
//       id: data['id']?? '',
//       image: data['image'] ?? '',
//       stock: data['stock'] ?? '',
//     );
//   }
  
//   static VariationsModel empty() => VariationsModel(id: '', attr: {}, image: '', stock: 0);
// }




// class ColorModel {
//   final String name;

//   ColorModel({required this.name});
// }