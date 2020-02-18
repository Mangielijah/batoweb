import 'dart:html';

import 'package:bato_test/models/listing.dart';
import 'package:bato_test/utils/text_manager.dart';
import 'package:bato_test/widgets/listing_card.dart';
import 'package:firebase/firestore.dart' as WebFirestore;
import 'package:firebase/firebase.dart' as WebFirebase;
import 'package:flutter/material.dart';

//CloudFireStore
WebFirestore.Firestore webFirestore = WebFirebase.firestore();

class HotDealsScreenMobile extends StatefulWidget {
  @override
  _HotDealsScreenMobileState createState() => _HotDealsScreenMobileState();
}

class _HotDealsScreenMobileState extends State<HotDealsScreenMobile> {
  int perPage = 4;
  //int present = 0;
  //int lenghtOfDoc = 9;
  WebFirestore.CollectionReference listingDocRef;
  var next;
  WebFirestore.DocumentSnapshot lastDocument;
  @override
  void initState() {
    super.initState();
    listingDocRef = WebFirebase.firestore().collection("listings");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0.1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              titleRow(context, "Fresh Finds", iconData: Icons.whatshot),
              Flexible(
                fit: FlexFit.loose,
                child: new StreamBuilder(
                  stream: (next != null) ? next.limit(perPage).orderBy("listingID").get().asStream():listingDocRef.limit(perPage).orderBy("listingID").get().asStream(), //Firestore.instance.collection('listings').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<WebFirestore.QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return new Text('Loading...');
                    return new GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      mainAxisSpacing: 8.0,
                      primary: false,
                      childAspectRatio:
                          (MediaQuery.of(context).size.width / 2) / 500,
                      crossAxisSpacing: 4.0,
                      scrollDirection: Axis.vertical,
                      children: snapshot.data.docs
                          .map((document) {
                            //lenghtOfDoc = document.data().length;
                            //print(document.data().toString());
                            lastDocument = document;
                            return new ListingCard(
                              listing: Listing.fromJSON(document),
                            );
                          })
                          .toList()
                          //.getRange(present, perPage)
                          //.toList(),
                    );
                  },
                ),
              ),
              Container(
                  child: MaterialButton(
                onPressed: () {
                  setState(() {
                    this.next = WebFirebase.firestore().collection("listings").startAfter(snapshot:lastDocument);
                  });
                },
                elevation: 0.0,
                color: Colors.blue,
                child: Text(
                  "Load More",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              )
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*
GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: (MediaQuery.of(context).size.width / 4) / 500,
                  crossAxisSpacing: 4.0,
                  scrollDirection: Axis.vertical,
                  children: sampleListings().map(
                    (listing) {
                      return new ListingCard(
                        listing: listing,
                      );
                    },
                  ).toList(),
                ),

*/
