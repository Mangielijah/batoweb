import 'package:bato_test/models/listing.dart';
import 'package:bato_test/navbar/navbar.dart';
import 'package:bato_test/navbar/navbar.menu.dart';
import 'package:bato_test/utils/listings_manager.dart';
import 'package:bato_test/utils/locator.dart';
import 'package:bato_test/utils/navigation_service.dart';
import 'package:bato_test/utils/route_name.dart';
import 'package:firebase/firebase.dart' as WebFirebase;
import 'package:firebase/firestore.dart' as WebFirestore;
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

final NavigationService _navigationService = locator<NavigationService>();
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

  _loadListing() async {
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
                child: (listing == null)
                    ? Container(
                        padding: EdgeInsets.symmetric(vertical: 100),
                        child: Center(
                          child: Image.asset("assets/images/searching.gif"),
                        ),
                      )
                    : Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 100, vertical: 25),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            _buildBreadCrumb(),
                            _listingDetailCard()
                          ],
                        ),
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
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: <Widget>[
          _buildBreadCrumbItem("Home"),
          Text(
            ">",
            style: TextStyle(color: Colors.grey, fontSize: 14.0),
          ),
          _buildBreadCrumbItem(listing.mainCategory),
          Text(
            ">",
            style: TextStyle(color: Colors.grey, fontSize: 14.0),
          ),
          _buildBreadCrumbItem(listing.subCategory)
        ],
      ),
    );
  }

  _buildBreadCrumbItem(String category) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GestureDetector(
        onTap: () {
          if (category == "Home") {
            _navigationService.navigateTo(HomeRoute);
          }
        },
        child: Text(category,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 14,
            )),
      ),
    );
  }

  _listingDetailCard() {
    return Card(
      elevation: 1.0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: <Widget>[_showCarousel()],
        ),
      ),
    );
  }

  _showImage(String url) {
    // return ClipRRect(
    //     borderRadius: BorderRadius.circular(8.0),
    //     child: Image.network(widget.listing.displayImage));
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: AssetImage("assets/images/loading.gif"),
        ),
      ),
      constraints: BoxConstraints(maxWidth: 400),
      child: Center(
        child: Image.network(
          url,
          fit: BoxFit.fitHeight,
          height: 450,
        ),
      ),
    );
  }

  _showCarousel() {
    print(listing.listingImages);
    return Container(
      constraints: BoxConstraints(maxWidth: 500),
      height: 500,
      child: (listing.listingImages == null || listing.listingImages.length == 1) ? _showImage(listing.displayImage) : Swiper(
        itemCount: listing.listingImages.length,
        itemHeight: 500,
        itemWidth: 450,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return _showImage(listing.listingImages[index]);
        },
        index: 0,
        pagination: SwiperPagination(
          builder: SwiperPagination.dots,
          alignment: Alignment.center,
        ),
        outer: true,
        control: SwiperControl(),
      ),
    );
  }
}
