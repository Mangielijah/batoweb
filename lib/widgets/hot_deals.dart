import 'package:bato_test/DOA/listing_samples.dart';
import 'package:bato_test/models/listing.dart';
import 'package:bato_test/utils/text_manager.dart';
import 'package:bato_test/widgets/listing_card.dart';
import 'package:firebase/firestore.dart' as WebFirestore;
import 'package:firebase/firebase.dart' as WebFirebase;
import 'package:flutter/material.dart';

//CloudFireStore
WebFirestore.Firestore webFirestore = WebFirebase.firestore();

class HotDealsScreen extends StatefulWidget {
  @override
  _HotDealsScreenState createState() => _HotDealsScreenState();
}

class _HotDealsScreenState extends State<HotDealsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 30),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0.1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: <Widget>[
              titleRow(context, "Fresh Finds", iconData: Icons.whatshot),
              Flexible(
                fit: FlexFit.loose,
                child: GridView.count(
                  crossAxisCount: 4,
                   childAspectRatio: (9/10),
                      shrinkWrap: true,
                      mainAxisSpacing: 12.0,
                      crossAxisSpacing: 8.0,
                      scrollDirection: Axis.vertical,
                      children: sampleListings().map((listing) {
                        return new ListingCard(
                          listing: listing,
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/*
new StreamBuilder(
                stream: webFirestore
                    .collection('listings')
                    .get()
                    .asStream(), //Firestore.instance.collection('listings').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<WebFirestore.QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return new Text('Loading...');
                  return new GridView.count(
                    crossAxisCount: 4,
                    childAspectRatio: (9/10),
                    shrinkWrap: true,
                    mainAxisSpacing: 12.0,
                    crossAxisSpacing: 8.0,
                    scrollDirection: Axis.vertical,
                    children: snapshot.data.docs.map((document) {
                      print(document.data().toString());
                      return new ListingCard(
                        listing: Listing.fromJSON(document),
                      );
                    }).toList(),
                  );
                },
              )
*/