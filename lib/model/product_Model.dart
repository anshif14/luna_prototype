class ProductModel{
  String productname;
  List image;
  String description;
  String category;
  double price;
  String sellername;
  String address;
  String phonenumber;
  String id;
  String userid;
  List favUser;


  ProductModel({

    required this.productname,
    required this.image,
    required this.description,
    required this.category,
    required this.price,
    required this.sellername,
    required this.address,
    required this.phonenumber,
    required this.id,
    required this.userid,
    required this.favUser

});

  Map<String,dynamic> toMap(){
    return {
      "productname": this.productname,
      "image": this.image,
      "description": this.description,
      "category": this.category,
      "price": this.price,
      "sellername":this.sellername,
      "address": this.address,
      "phonenumber": this.phonenumber,
      "id": this.id,
      "userid":this.userid,
      "favUser":this.favUser
    };
  }

  factory ProductModel.fromMap(Map<String,dynamic>Map){
    return ProductModel(
      productname: Map["productname"] ?? "",
      image: Map["image"] ?? [],
      description: Map["description"] ?? "",
      category: Map["category"] ?? "",
      price: Map["price"] ?? "",
      sellername: Map["sellername"] ?? "",
      address: Map["address"] ?? "",
      phonenumber: Map["phonenumber"] ?? "",
      id: Map["id"]?? "",
      userid: Map["user id"]??"",
      favUser: Map["favUser"]??[]
    );
  }

  ProductModel copyWith({
    String? productname,
    List? image,
    String? description,
    String? category,
    double? price,
    String? sellername,
    String? address,
    String? phonenumber,
    String? id,
    String? userid,
    List? favUser
}){
    return ProductModel(
      productname: productname ?? this.productname,
      image: image ?? this.image,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
      sellername: sellername ?? this.sellername,
      address: address ?? this.address,
      phonenumber: phonenumber ?? this.phonenumber,
      id: id ?? this.id,
      userid: userid ?? this.userid,
      favUser: favUser??this.favUser
    );
  }

}
