import 'package:bato_test/footer_section/footer.controller.dart';
import 'package:bato_test/models/listing.dart';
import 'package:bato_test/navbar/navbar.dart';
import 'package:bato_test/navbar/navbar.menu.dart';
import 'package:bato_test/utils/listings_manager.dart';
import 'package:bato_test/utils/locator.dart';
import 'package:bato_test/utils/navigation_service.dart';
import 'package:bato_test/utils/route_name.dart';
import 'package:bato_test/utils/text_manager.dart';
import 'package:bato_test/widgets/circular_image.dart';
import 'package:bato_test/widgets/listing_card.dart';
import 'package:firebase/firebase.dart' as WebFirebase;
import 'package:firebase/firestore.dart' as WebFirestore;
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:bato_test/models/user.dart';
import 'package:rating_bar/rating_bar.dart';

final NavigationService _navigationService = locator<NavigationService>();
WebFirestore.Firestore webFirestore = WebFirebase.firestore();

class ListingView extends StatefulWidget {
  final String listingId;
  final String posterId;
  final String subCategory;
  const ListingView({Key key, this.listingId, this.posterId, this.subCategory}) : super(key: key);

  @override
  _ListingViewState createState() => _ListingViewState();
}

class _ListingViewState extends State<ListingView> {
  Listing listing;
  User seller;
  
  int perPage = 8;
  bool fLoad = true;
  //int present = 0;
  //int lenghtOfDoc = 9;
  Future<List<WebFirestore.DocumentSnapshot>> listingSnapshot;
  List<WebFirestore.DocumentSnapshot> list = [];
  
  @override
  void initState() {
    super.initState();
    _loadListing();
    listingSnapshot = loadMoreListing();
  }

  _loadListing() async {
    final listingDocRef =
        webFirestore.collection("listings").doc(widget.listingId);
    final userDocRef = webFirestore.collection('users').doc(widget.posterId);
    
    final listingDoc = await listingDocRef.get();
    final userDoc = await userDocRef.get();
    setState(() {
      listing = Listing.fromJSON(listingDoc);
      seller = User.fromSnapshot(userDoc);
    });
    
  }

  //Load other listing
  
  Future<List<WebFirestore.DocumentSnapshot>> loadMoreListing() async {
    print(widget.subCategory);
    if(fLoad){
    final listingsFetched = await webFirestore
        .collection("listings")
        .where("subCategory", "==", widget.subCategory)
        .limit(perPage)
        .get();
        list.addAll(listingsFetched.docs);
        fLoad = false;
        return list;
    }
    else {
      
    final listingsFetched = await webFirestore
        .collection("listings")
        .where("subCategory", "==", widget.subCategory)
        .startAfter(snapshot: list[list.length - 1])
        .limit(perPage)
        .get();
        list.addAll(listingsFetched.docs);
        return list;
    }
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
                child: (listing == null || seller == null)
                    ? Container(
                        padding: EdgeInsets.symmetric(vertical: 100),
                        child: Center(
                          child: Image.asset("assets/images/searching.gif"),
                        ),
                      )
                    : LayoutBuilder(builder: (context, constraints) {
                        if (constraints.maxWidth > 1200) {
                          //desktop View
                          return Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 110),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 150, vertical: 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      _buildBreadCrumb(),
                                      _listingDetailCard(),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      _showOtherListing(),
                                    ],
                                  ),
                                ),
                              ),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Footer(),
                            ],
                          );
                        } else if (constraints.maxWidth > 800 &&
                            constraints.maxWidth < 1200) {
                          // Tablet View

                          return Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    _buildBreadCrumb(),
                                    _listingDetailCard(),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    _showOtherListing(),
                                  ],
                                ),
                              ),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Footer(),
                            ],
                          );
                        } else {
                          // mobile view of website

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    _buildBreadCrumbMobile(),
                                    _listingDetailCardMobile(),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    _showOtherListingMobile(),
                                  ],
                                ),
                              ),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Footer(),
                            ],
                          );
                        }
                      }),
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
  
  _buildBreadCrumbMobile() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildBreadCrumbItem("Home"),
          Text(
            ">",
            style: TextStyle(color: Colors.grey, fontSize: 12.0),
          ),
          _buildBreadCrumbItem(listing.mainCategory),
          Text(
            ">",
            style: TextStyle(color: Colors.grey, fontSize: 12.0),
          ),
          _buildBreadCrumbItem(listing.subCategory)
        ],
      ),
    );
  }

  _buildBreadCrumbItem(String category) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTap: () {
          if (category == "Home") {
            _navigationService.navigateTo(HomeRoute);
          } else if (category == listing.subCategory) {
            navigateToCategoryView(context,
                mainCategory: listing.mainCategory,
                subCategory: listing.subCategory);
          } else if (category == listing.mainCategory) {
            navigateToCategoryView(context, mainCategory: listing.mainCategory);
          } 
        },
        child: Text(category,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 12,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _showCarousel(),
            Expanded(child: _showDetails()),
          ],
        ),
      ),
    );
  }

  //  Mobile Version
    _listingDetailCardMobile() {
    return Container(
      height: 900,//(MediaQuery.of(context).size.height + 160),
      child: Card(
        elevation: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _showCarousel(),
              _showDetailsMobile(),
            ],
          ),
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
      child:
          (listing.listingImages == null || listing.listingImages.length == 1)
              ? _showImage(listing.displayImage)
              : Swiper(
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
                  outer: false,
                  control: SwiperControl(),
                ),
    );
  }

  _showDetails() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildProfileNameRow(
              seller.profileImg, listing.posterNames, seller.username),
          buildUserReviewBar(context, seller.reviewsAvg, seller.reviewsCount),
          SizedBox(
            height: 12,
          ),
          _buildPriceSection(),
          SizedBox(
            height: 5.0,
          ),
          Divider(
            thickness: 1,
            height: 1.0,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            listing.title,
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(
            height: 14,
          ),
          _buildStatusSection(),
          SizedBox(
            height: 8,
          ),
          Text(
            "Description",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            thickness: 1,
            height: 1.0,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            listing.desc,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }

  //MObile Text Details
  
  _showDetailsMobile() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildProfileNameRow(
              seller.profileImg, listing.posterNames, seller.username),
          buildUserReviewBarMobile(context, seller.reviewsAvg, seller.reviewsCount),
          SizedBox(
            height: 8,
          ),
          _buildPriceSection(),
          SizedBox(
            height: 5.0,
          ),
          Divider(
            thickness: 1,
            height: 1.0,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            listing.title,
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(
            height: 8,
          ),
          _buildStatusSection(),
          SizedBox(
            height: 8,
          ),
          Text(
            "Description",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            thickness: 1,
            height: 1.0,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            listing.desc,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }

  _buildStatusSection() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildStatusItem(Icons.location_on, listing.location),
          SizedBox(
            height: 6.0,
          ),
          /*(listing.deliveryAvailable)
              ? _buildStatusItem(Icons.shopping_cart, "Delivery Available")
              : _buildStatusItem(
                  Icons.remove_shopping_cart, "Delivery Not Available"),*/
          SizedBox(
            height: 6.0,
          ),
          (seller.idVerified)
              ? _buildStatusItem(Icons.check_circle_outline, "Seller Verified")
              : _buildStatusItem(Icons.not_interested, "Seller Not Verified"),
        ],
      ),
    );
  }

  Row _buildStatusItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(
          icon,
          size: 23,
          color: Colors.grey,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 18),
        )
      ],
    );
  }

  _buildProfileNameRow(String imgPath, String name, String username) {
    return Container(
      height: 76,
      child: Row(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CircleImage(imgPath, 40),
              SizedBox(
                width: 12,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    "@" + username,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  ///build stars and review bar
  buildUserReviewBar(BuildContext context, double userRating, int reviewCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text("Seller Rating: ", style: TextStyle(fontSize: 16)),
        RatingBar.readOnly(
          initialRating: userRating,
          isHalfAllowed: true,
          halfFilledIcon: Icons.star_half,
          filledIcon: Icons.star,
          filledColor: Colors.amber,
          halfFilledColor: Colors.amberAccent,
          size: 20,
          emptyIcon: Icons.star_border,
        ),
        SizedBox(
          width: 2.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Text(
            reviewCount.toString() + " Reviews",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
          ),
        )
      ],
    );
  }

//Mobile Review Sectionj
buildUserReviewBarMobile(BuildContext context, double userRating, int reviewCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text("Seller Rating: ", style: TextStyle(fontSize: 12)),
        RatingBar.readOnly(
          initialRating: userRating,
          isHalfAllowed: true,
          halfFilledIcon: Icons.star_half,
          filledIcon: Icons.star,
          filledColor: Colors.amber,
          halfFilledColor: Colors.amberAccent,
          size: 16,
          emptyIcon: Icons.star_border,
        ),
        SizedBox(
          width: 2.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Text(
            reviewCount.toString() + " Reviews",
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
          ),
        )
      ],
    );
  }


  _buildPriceSection() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            listing.price.toString() + " FCFA",
            style: TextStyle(fontSize: 25, color: Colors.red),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              buildFavoriteButton(false),
              SizedBox(
                width: 4,
              ),
              (listing.listingLikes > 0)
                  ? Text(
                      listing.listingLikes.toString(),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                    )
                  : Text(
                      "0 Likes",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                    ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildFavoriteButton(bool isFavorite) {
    return GestureDetector(
      onTap: () => print("favorite " + listing.listingID),
      child: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
        size: 20,
      ),
    );
  }

  _showOtherListing() {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0.1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            titleRow(context, "You may also like", iconData: Icons.whatshot),
            Flexible(
              fit: FlexFit.loose,
              child: new StreamBuilder(
                stream: webFirestore
                    .collection('listings')
                    .where('subCategory', "==", listing.subCategory)
                    .limit(12)
                    .get()
                    .asStream(), //Firestore.instance.collection('listings').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<WebFirestore.QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return new Text('Loading...');
                  return new GridView.count(
                      crossAxisCount: 4,
                      shrinkWrap: true,
                      mainAxisSpacing: 8.0,
                      primary: false,
                      childAspectRatio:
                          (MediaQuery.of(context).size.width / 4) / 600,
                      crossAxisSpacing: 4.0,
                      scrollDirection: Axis.vertical,
                      children: snapshot.data.docs.map((document) {
                        //lenghtOfDoc = document.data().length;
                        //print(document.data().toString());
                        return new ListingCard(
                          listing: Listing.fromJSON(document),
                        );
                      }).toList()
                      //.getRange(present, perPage)
                      //.toList(),
                      );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Mobile Version of Show other Listing
  
  _showOtherListingMobile() {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0.1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            titleRow(context, "You may also like", iconData: Icons.whatshot),
            Flexible(
              fit: FlexFit.loose,
              child: new FutureBuilder<List<WebFirestore.DocumentSnapshot>>(
                future: listingSnapshot,//webFirestore
                //     .collection('listings')
                //     .where('subCategory', "==", listing.subCategory)
                //     .limit(12)
                //     .get()
                //     .asStream(), //Firestore.instance.collection('listings').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<WebFirestore.DocumentSnapshot>> snapshots) {
                  if (!snapshots.hasData) return new Text('Loading...');
                  return new GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      mainAxisSpacing: 8.0,
                      primary: false,
                      childAspectRatio:
                          (MediaQuery.of(context).size.width / 2) / 500,
                      crossAxisSpacing: 4.0,
                      scrollDirection: Axis.vertical,
                      children: snapshots.data.map((document) {
                        //lenghtOfDoc = document.data().length;
                        //print(document.data().toString());
                        return new ListingCard(
                          listing: Listing.fromJSON(document),
                        );
                      }).toList()
                      //.getRange(present, perPage)
                      //.toList(),
                      );
                },
              ),
            ),
              Container(
                  child: MaterialButton(
                onPressed: () {
                  //_loadMore(perPage).then((value) => listingSnapshot.addAll(value));
                  setState(() {
                    listingSnapshot = loadMoreListing();
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
    );
  }

}
