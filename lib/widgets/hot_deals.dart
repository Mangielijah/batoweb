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
  int perPage = 4;
  //int present = 0;
  //int lenghtOfDoc = 9;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 40),
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
                  stream: webFirestore
                      .collection('listings').limit(perPage)
                      .get()
                      .asStream(), //Firestore.instance.collection('listings').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<WebFirestore.QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return new Text('Loading...');
                    return new GridView.count(
                      crossAxisCount: 4,
                      shrinkWrap: true,
                      mainAxisSpacing: 8.0,
                      childAspectRatio:
                          (MediaQuery.of(context).size.width / 4) / 500,
                      crossAxisSpacing: 4.0,
                      scrollDirection: Axis.vertical,
                      children: snapshot.data.docs
                          .map((document) {
                            //lenghtOfDoc = document.data().length;
                            //print(document.data().toString());
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
              /*Container(
                  child: (perPage < lenghtOfDoc) ? MaterialButton(
                onPressed: () {
                  setState(() {
                    if((present + perPage) > lenghtOfDoc) {
                      
                    } else {
                      perPage += 12;
                    }
                  });
                },
                elevation: 0.0,
                color: Colors.blue,
                child: Text(
                  "Load More",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ) : null
              )*/
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
