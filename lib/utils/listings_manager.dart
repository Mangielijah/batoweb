
import 'package:bato_test/models/listing.dart';
import 'package:bato_test/widgets/listing_card.dart';
import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as WebFirebase;
import 'package:firebase/firestore.dart' as WebFirestore;

WebFirestore.Firestore webFirestore = WebFirebase.firestore();
///navigate to Listing
navigateToListing(BuildContext context, String listingId) {
  Navigator.of(context).pushNamed("/viewListing", arguments: listingId);
}

showListings(String collectionName) {
  return Column(
    children: <Widget>[
      Expanded(
        child: StreamBuilder(
            stream: webFirestore.collection(collectionName).get().asStream(),
            builder:
                (BuildContext context, AsyncSnapshot<WebFirestore.QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.active &&
                  !snapshot.hasData) return Text("loading");
              return new GridView.count(
                crossAxisCount: 2,
                scrollDirection: Axis.vertical,
                children: snapshot.data.docs.map((document) {
                  return new ListingCard(
                    listing: Listing.fromJSON(document),
                  );
                }).toList(),
              );
            }),
      ),
    ],
  );
}

///display listings from databse
displayListingsInGrid(AsyncSnapshot<WebFirestore.QuerySnapshot> snapshot) {
  return new GridView.count(
    crossAxisCount: 2,
    childAspectRatio: (9 / 10),
    scrollDirection: Axis.vertical,
    children: snapshot.data.docs.map((document) {
      return new ListingCard(
        listing: Listing.fromJSON(document),
      );
    }).toList(),
  );
}
