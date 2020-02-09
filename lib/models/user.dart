import 'package:firebase/firestore.dart' as WebFirestore;
import 'package:firebase/firebase.dart' as WebFirebase;
import 'package:flutter/material.dart';

WebFirestore.Firestore webFirestore = WebFirebase.firestore();

///model of User
class User {
  String userId;
  String username;
  String phone;
  String profileImg;
  bool idVerified;
  dynamic dateJoined;
  double reviewsAvg;
  int reviewsCount;

  ///user account level
  ///1 - Bronze Member
  ///2 - Silver Member
  ///3 - Gold Member
  int userAccountLevel;

  User(
      {this.idVerified,
      this.dateJoined,
      this.reviewsAvg,
      this.reviewsCount,
      this.userId,
      this.username,
      this.phone,
      this.profileImg,
      this.userAccountLevel});

  User.fromMap(Map<dynamic, dynamic> data, String id)
      : this(
            userId: id,
            phone: data["phone"],
            dateJoined: data["joinedDate"],
            profileImg: data["profileImg"],
            username: data["username"],
            reviewsAvg: data["reviewsAvg"].toDouble(),
            reviewsCount: data["reviewsCount"],
            idVerified: data["idVerified"]);

  User.fromSnapshot(WebFirestore.DocumentSnapshot data)
      : this(
            userId: data.id, // data.documentID,
            dateJoined: data.get("dateJoined"), //data["dateJoined"],
            phone: data.get("phone"), //data["phone"],
            profileImg: data.get("profilImg"), //data["profilImg"],
            username: data.get("username"), //data["username"],
            reviewsAvg: data.get("reviewsAvg"), //data["reviewsAvg"],
            reviewsCount: data.get("reviewsCount"), //data["reviewsCount"],
            idVerified: data.get("idVerified"), //data["idVerified"],
            userAccountLevel: data.get("userAccountLevel"), //data["userAccountLevel"]
            );

  ///get User from an AsyncSnapshot response

  User.fromAsyncSnapShot(AsyncSnapshot snapShot)
      : this(
            userId: snapShot.data.documentID,
            dateJoined: snapShot.data["dateJoined"],
            phone: snapShot.data["phone"],
            profileImg: snapShot.data["profilImg"],
            username: snapShot.data["username"],
            reviewsAvg: snapShot.data["reviewsAvg"].toDouble(),
            reviewsCount: snapShot.data["reviewsCount"],
            userAccountLevel: snapShot.data["userAccountLevel"],
            idVerified: snapShot.data["idVerified"]);

//convert User to JSon
  Map<String, dynamic> toJson() => {
        'username': username,
        'phone': phone,
        'profilImg': "",
        'idVerified': idVerified,
        'dateJoined': dateJoined,
        'reviewsAvg': reviewsAvg,
        'reviewsCount': reviewsCount,
        'userAccountLevel': userAccountLevel,
      };

  ///create new User
  /*User.newUser(String username)
      : this(
            username: username,
            profileImg: "",
            idVerified: false,
            reviewsAvg: 0,
            reviewsCount: 0,
            dateJoined: FieldValue.serverTimestamp(),
            userAccountLevel: 1);*/

  @override
  String toString() {
    return 'User{userId: $userId, username: $username, phone: $phone, profileImg: $profileImg, idVerified: $idVerified, dateJoined: $dateJoined, reviewsAvg: $reviewsAvg, reviewsCount: $reviewsCount, userAccountLevel: $userAccountLevel}';
  }
}

///get user details
getUserDetails(String userId) async {
  final snapShot =
      await webFirestore.collection('users').doc(userId).get();

  return User.fromSnapshot(snapShot);
}
