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
  int perPage = 6;
  bool fLoad = true;
  //int present = 0;
  //int lenghtOfDoc = 9;
  Future<List<WebFirestore.DocumentSnapshot>> listingSnapshot;
  List<WebFirestore.DocumentSnapshot> list = [];

  @override
  void initState() {
    super.initState();
    listingSnapshot = loadMore();
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
                child: new FutureBuilder<List<WebFirestore.DocumentSnapshot>>(
                  future:
                      listingSnapshot, //Firestore.instance.collection('listings').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<WebFirestore.DocumentSnapshot>>
                          snapshots) {
                    if (!snapshots.hasData) return new Text('Loading...');
                    //listingSnapshot.addAll(snapshot.data.docs);
                    return buildGridView(context, snapshots.data);
                  },
                ),
              ),
              Container(
                  child: MaterialButton(
                onPressed: () {
                  //_loadMore(perPage).then((value) => listingSnapshot.addAll(value));
                  setState(() {
                    listingSnapshot = loadMore();
                  });
                },
                elevation: 0.0,
                color: Colors.blue,
                child: Text(
                  "Load More",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Future<List<WebFirestore.DocumentSnapshot>> loadMore() async {
    if(fLoad){
    final listingsFetched = await webFirestore
        .collection("listings")
        .orderBy("listingID", "desc")
        .limit(perPage)
        .get();
        list.addAll(listingsFetched.docs);
        fLoad = false;
        return list;
    }
    else {
      
    final listingsFetched = await webFirestore
        .collection("listings")
        .orderBy("listingID", "desc")
        .startAfter(snapshot: list[list.length - 1])
        .limit(perPage)
        .get();
        list.addAll(listingsFetched.docs);
        return list;
    }
  }

  GridView buildGridView(
      BuildContext context, List<WebFirestore.DocumentSnapshot> snapList) {
    return new GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        mainAxisSpacing: 8.0,
        primary: false,
        childAspectRatio: (MediaQuery.of(context).size.width / 2) / 500,
        crossAxisSpacing: 4.0,
        scrollDirection: Axis.vertical,
        children: snapList.map((document) {
          //lenghtOfDoc = document.data().length;
          return new ListingCard(
            listing: Listing.fromJSON(document),
          );
        }).toList()
        //.getRange(present, perPage)
        //.toList(),
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
