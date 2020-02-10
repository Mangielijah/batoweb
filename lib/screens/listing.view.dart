import 'package:bato_test/models/listing.dart';
import 'package:bato_test/navbar/navbar.dart';
import 'package:bato_test/navbar/navbar.menu.dart';
import 'package:firebase/firebase.dart' as WebFirebase;
import 'package:firebase/firestore.dart' as WebFirestore;
import 'package:flutter/material.dart';


WebFirestore.Firestore webFirestore = WebFirebase.firestore();
class ListingView extends StatefulWidget {
  final String listingId;
  const ListingView({Key key, this.listingId}) : super(key: key);

  @override
  _ListingViewState createState() => _ListingViewState();
}

class _ListingViewState extends State<ListingView> {
  Listing listing;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadListing();
  }
  _loadListing() async{
    final docRef = webFirestore.collection("listings").doc(widget.listingId);
    final doc = await docRef.get();
    setState(() {
      listing = Listing.fromJSON(doc);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            NavBar(),
            Divider(
              thickness: 0.85,
              height: 1.0,
            ),
            NavBarMenu(),
            Divider(
              thickness: 0.85,
              height: 1.0,
            ),
            Container(
              height: MediaQuery.of(context).size.height - 107,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: (listing == null) ? Container(
                  padding: EdgeInsets.symmetric(vertical: 100),
                  child: Center(child: Image.asset("assets/images/searching.gif"),),
                ) :Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _buildBreadCrumb(),
                    _listingDetailCard()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildBreadCrumb() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 100, vertical: 40),
      child: Row(
        children: <Widget>[
          _buildBreadCrumbItem(listing.mainCategory),
          Text(
            ">",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14.0
            ),
          ),
          _buildBreadCrumbItem(listing.subCategory)
        ],
      ),
    );
  }

  _buildBreadCrumbItem(String category){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GestureDetector(
        onTap: (){},
        child: Text(
          category,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 14,
          )
        ),
      ),
    );
  }

  _listingDetailCard(){
    return Card(
      
    );
  }
}
