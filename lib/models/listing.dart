import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';

class Listing {
  String listingID;
  String posterID;
  String posterNames;
  String type;
  String title;
  String desc;
  int price;
  String displayImage;
  dynamic postedTime;
  int listingLikes;
  String mainCategory;
  String subCategory;
  String location;
  List<String> listingImages;
  bool deliveryAvailable;

  Listing({
    this.listingID,
    this.posterID,
    this.posterNames,
    this.type,
    this.title,
    this.desc,
    this.price,
    this.location,
    this.displayImage,
    this.postedTime,
    this.listingLikes,
    this.mainCategory,
    this.subCategory,
    this.listingImages,
    this.deliveryAvailable,
  });

  Listing.fromSnapShot(AsyncSnapshot snapshot)
      : this(
            listingID: snapshot.data["listingID"],
            posterID: snapshot.data["posterID"],
            posterNames: snapshot.data["name"],
            type: snapshot.data["type"],
            title: snapshot.data["title"],
            desc: snapshot.data["desc"],
            price: snapshot.data["price"],
            location: snapshot.data["location"],
            displayImage: snapshot.data["displayImage"],
            postedTime: snapshot.data["postedTime"],
            listingLikes: snapshot.data["listingLikes"],
            mainCategory: snapshot.data["mainCategory"],
            subCategory: snapshot.data["subCategory"],
            listingImages: snapshot.data["listingImages"].cast<String>(),
            deliveryAvailable: snapshot.data["deliveryAvailable"]);

  Listing.fromJSON(DocumentSnapshot data)
      : this(
            listingID: data.get("listingID"), //data["listingID"],
            posterID: data.get("posterID"), // data["posterID"],
            posterNames: data.get("name"), //data["name"],
            type: data.get("type"),//data["type"],
            title: data.get("title"),//data["title"],
            desc: data.get("desc"),//data["desc"],
            price: data.get("price"),//data["price"],
            location: data.get("location"),//data["location"],
            displayImage: data.get("displayImage"),//data["displayImage"],
            postedTime: data.get("postedTime"),//data["postedTime"],
            listingLikes: data.get("listingLikes"),//data["listingLikes"],
            mainCategory: data.get("mainCategory"),//data["mainCategory"],
            subCategory: data.get("subCategory"),//data["subCategory"],
            listingImages: data.data()["listingImages"].cast<String>(),//data["listingImages"].cast<String>(),
            deliveryAvailable: data.get("deliveryAvailable")//data["deliveryAvailable"]
            
            );

  ///convert listing to Json
  Map<String, dynamic> toJson() => {
        "listingID": listingID,
        "posterID": posterID,
        "name": posterNames,
        "type": type,
        "title": title,
        "desc": desc,
        "price": price,
        "location": location,
        "displayImage": displayImage,
        "postedTime": postedTime,
        "listingLikes": listingLikes,
        "mainCategory": mainCategory,
        "subCategory": subCategory,
        "listingImages": listingImages,
        "deliveryAvailable": deliveryAvailable
      };

  ///format price to FCFA
  String get getFormattedPrice {
    ///TODO fix formatted price
//    FlutterMoneyFormatter price = FlutterMoneyFormatter(
//      amount: this.price.toDouble(),
//    );
//    String formattedPrice = price.output.withoutFractionDigits + " FCFA";
//    return formattedPrice;
    return this.price.toString();
  }

  @override
  String toString() {
    return 'Listing{listingID: $listingID, posterID: $posterID, name: $posterNames, type: $type, title: $title, desc: $desc, price: $price, displayImage: $displayImage, postedTime: $postedTime, listingLikes: $listingLikes, mainCategory: $mainCategory, subCategory: $subCategory, location: $location, listingImages: $listingImages, deliveryAvailable: $deliveryAvailable}';
  }
}
