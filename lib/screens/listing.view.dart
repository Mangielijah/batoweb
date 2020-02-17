import 'package:bato_test/models/listing.dart';
import 'package:bato_test/navbar/navbar.dart';
import 'package:bato_test/navbar/navbar.menu.dart';
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
  const ListingView({Key key, this.listingId, this.posterId}) : super(key: key);

  @override
  _ListingViewState createState() => _ListingViewState();
}

class _ListingViewState extends State<ListingView> {
  Listing listing;
  User seller;
  @override
  void initState() {
    super.initState();
    _loadListing();
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
                    : Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 150, vertical: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            _buildBreadCrumb(),
                            _listingDetailCard(),
                            SizedBox(height: 16,),
                            _showOtherListing()
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
      padding: EdgeInsets.all(24),
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
            style: Theme.of(context).textTheme.display1,
          ),
          SizedBox(
            height: 14,
          ),
          _buildStatusSection(),
          SizedBox(height: 8,),
          Text("Description", style: TextStyle(
            fontSize: 20
          ),),
          SizedBox(height: 8,),
          Divider(
            thickness: 1,
            height: 1.0,
          ),
          SizedBox(height: 8.0,),
          Text(
            listing.desc,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300
            ),
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
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300),
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
              SizedBox(width: 4,),
              (listing.listingLikes > 0)
                  ? Text(
                      listing.listingLikes.toString(),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                    )
                  : Text("0 Likes", style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w300

                  ),),
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
                      childAspectRatio:
                          (MediaQuery.of(context).size.width / 4) / 530,
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
}
