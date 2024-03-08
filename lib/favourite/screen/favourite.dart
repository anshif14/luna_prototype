import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/model/product_Model.dart';
import 'package:luna_demo/model/user_Model.dart';

import '../../commons/color constansts.dart';
import '../../commons/widgets.dart';
import '../../features/product/screens/productSingle.dart';
import '../../main.dart';

class favourite extends StatefulWidget {
  const favourite({super.key});

  @override
  State<favourite> createState() => _favouriteState();
}

class _favouriteState extends State<favourite> {
  List pets = [
    {'name': 'pet', "image": imageConstants.pet1, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet2, "price": 1250},
    {'name': 'pet', "image": imageConstants.pet3, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet4, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet5, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet6, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet7, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet8, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet9, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet10, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet11, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet12, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet13, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet14, "price": 1000},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Pallette.white,
        elevation: 0,
        toolbarHeight: height*0.01,
      ),
        body: Padding(
      padding:  EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: height * 0.08,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.search),
                      ),
                      Text(
                        "Search",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  height: height * 0.06,
                  decoration: BoxDecoration(
                      color: Pallette.grey,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            gap,
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: currentUserModel!.favourites.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.8, crossAxisCount: 2),
              itemBuilder: (context, index) {
                return       StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance.collection('product').doc(currentUserModel!.favourites[index]).snapshots(),
                  builder: (context, snapshot) {
                    if(!snapshot.hasData){
                      return Center(child: CircularProgressIndicator(color: Pallette.primaryColor),);
                    }
                    ProductModel product  = ProductModel.fromMap(snapshot.data!.data() as Map<String , dynamic>);
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProducctSingleScreen(
                                id: product.id,
                                tag: product.image[0],
                              ),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Hero(
                                  tag: product.productname,
                                  child: Container(
                                    height: width * 0.4,
                                    width: width * 0.4,
                                    decoration: BoxDecoration(
                                        color: Pallette.secondaryBrown,
                                        image: DecorationImage(
                                            image: NetworkImage(product.image[0]),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.circular(15)),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white.withOpacity(0.5)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: FavoriteButton(
                                          isFavorite: true,
                                          iconSize: 25,
                                          valueChanged: (_isFavorite) async {
                                            var data=await FirebaseFirestore.instance.collection("users").doc(currentUserEmail).get();
                                            currentUserModel = userModel.fromMap(data.data()!);
                                            List fav=currentUserModel!.favourites;
                                            print(fav);
                                            if(fav.contains(product.id)){
                                              fav.remove(product.id);
                                            }else{
                                              fav.add(product.id);
                                            }
                                            FirebaseFirestore.instance.collection("users").doc(currentUserEmail).update({
                                              "favourites": fav
                                            });
                                            var data1=await FirebaseFirestore.instance.collection("users").doc(currentUserEmail).get();
                                            currentUserModel = userModel.fromMap(data1.data()!);
                                            setState(() {

                                            });
                                            print('Is Favorite $_isFavorite)');
                                            print('Is Favorite $_isFavorite)');
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    product.productname,
                                    style: TextStyle(fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('₹ ' + product.price.toString()),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                );

              },
            )
          ],
        ),
      ),
    ));
  }
}

class petTile extends StatefulWidget {
  final int index;
  const petTile({super.key, required this.index});

  @override
  State<petTile> createState() => _petTileState();
}

class _petTileState extends State<petTile> {
  List pets = [
    {'name': 'pet', "image": imageConstants.pet1, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet2, "price": 1250},
    {'name': 'pet', "image": imageConstants.pet3, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet4, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet5, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet6, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet7, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet8, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet9, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet10, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet11, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet12, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet13, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet14, "price": 1000},
  ];

  int index = 0;

  @override
  void initState() {
    index = widget.index;
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return
      InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProducctSingleScreen(
                id: "",
                tag: pets[index]['image'],
              ),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: pets[index]['image'],
                  child: Container(
                    height: width * 0.4,
                    width: width * 0.4,
                    decoration: BoxDecoration(
                        color: Pallette.secondaryBrown,
                        image: DecorationImage(
                            image: AssetImage(pets[index]['image']),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.5)),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: FavoriteButton(
                          isFavorite: true,
                          iconSize: 25,
                          valueChanged: (_isFavorite) {
                            print('Is Favorite $_isFavorite)');
                          },
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    pets[index]['name'],
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('₹ ' + pets[index]['price'].toDouble().toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
