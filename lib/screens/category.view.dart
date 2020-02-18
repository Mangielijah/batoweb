import 'package:bato_test/category_section/category_view.dart';
import 'package:bato_test/models/listing.dart';
import 'package:bato_test/navbar/navbar.dart';
import 'package:bato_test/navbar/navbar.menu.dart';
import 'package:bato_test/utils/categories.dart';
import 'package:bato_test/utils/listings_manager.dart';
import 'package:bato_test/utils/locator.dart';
import 'package:bato_test/utils/navigation_service.dart';
import 'package:bato_test/utils/route_name.dart';
import 'package:bato_test/utils/text_manager.dart';
import 'package:bato_test/widgets/listing_card.dart';
import 'package:firebase/firebase.dart' as WebFirebase;
import 'package:firebase/firestore.dart' as WebFirestore;
import 'package:flutter/material.dart';
import 'package:bato_test/models/user.dart';

final NavigationService _navigationService = locator<NavigationService>();
WebFirestore.Firestore webFirestore = WebFirebase.firestore();

class CategoryView extends StatefulWidget {
  final String mainCategory;
  final String subCategory;
  const CategoryView({Key key, this.mainCategory, this.subCategory})
      : super(key: key);

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  var listingsDocRef;
  User seller;
  int limit = 24;
  @override
  void initState() {
    super.initState();
    _loadListing();
  }

  _loadListing() async {
    var listingDocRef;
    if (widget.mainCategory != null && widget.subCategory != null) {
      listingDocRef = webFirestore
          .collection("listings")
          .where("mainCategory", "==", widget.mainCategory)
          .where("subCategory", "==", widget.subCategory)
          .limit(limit);
    } else {
      listingDocRef = webFirestore
          .collection("listings")
          .where("mainCategory", "==", widget.mainCategory)
          .limit(limit);
    }
    // /var listingDocRef =
    //     webFirestore.collection("listings").doc(widget.listingId);
    //final listingDoc = await listingDocRef.get();
    setState(() {
      this.listingsDocRef = listingDocRef;
      // for (var listing in listingDoc) {
      //   this.listings.add(Listing.fromJSON(listing));
      // }
      // this.listings = Listing.fromJSON(listingDoc);
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
                child: LayoutBuilder(builder: (context, constraints) {
                  if (constraints.maxWidth > 1200) {
                    //desktop View
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 110),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 150, vertical: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _buildBreadCrumb(),
                            _showOtherListing()
                          ],
                        ),
                      ),
                    );
                  } else if (constraints.maxWidth > 800 &&
                      constraints.maxWidth < 1200) {
                    // Tablet View

                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildBreadCrumb(),
                          _showOtherListing()
                        ],
                      ),
                    );
                  } else {
                    // mobile view of website

                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildBreadCrumbMobile(),
                          _buildCategories(context),
                          _showOtherListingMobile(),
                        ],
                      ),
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

  //Build BreadCrumbs

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
          _buildBreadCrumbItem(widget.mainCategory),
          (widget.subCategory == null)
              ? Text("")
              : () => {
                    Text(
                      ">",
                      style: TextStyle(color: Colors.grey, fontSize: 14.0),
                    ),
                    _buildBreadCrumbItem(widget.subCategory)
                  }
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
          _buildBreadCrumbItem(widget.mainCategory),
          (widget.subCategory == null)
              ? Text("")
              : Row(
                  children: <Widget>[
                    Text(
                      ">",
                      style: TextStyle(color: Colors.grey, fontSize: 12.0),
                    ),
                    _buildBreadCrumbItem(widget.subCategory),
                  ],
                )
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
          } else if (category == widget.mainCategory) {
            navigateToCategoryView(context, mainCategory: widget.mainCategory);
          } else if (category == widget.subCategory) {
            navigateToCategoryView(context,
                mainCategory: widget.mainCategory,
                subCategory: widget.subCategory);
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
            titleRow(context, widget.mainCategory, iconData: Icons.whatshot),
            Flexible(
              fit: FlexFit.loose,
              child: new StreamBuilder(
                stream: listingsDocRef
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            titleRow(context, "You may also like", iconData: Icons.whatshot),
            Flexible(
              fit: FlexFit.loose,
              child: new StreamBuilder(
                stream: listingsDocRef
                    .get()
                    .asStream(), //Firestore.instance.collection('listings').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<WebFirestore.QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return new Text('Loading...');
                  return (snapshot.data.empty) ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text("No Product Available for this Category")),
                  ) :new GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      mainAxisSpacing: 6.0,
                      primary: false,
                      childAspectRatio:
                          (MediaQuery.of(context).size.width / 2) / 500,
                      crossAxisSpacing: 2.0,
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

  //SubCategory Display Horizontal List
  _buildCategories(BuildContext context) => Padding(
        padding: EdgeInsets.zero,
        child: buildCategoryIcons(context),
      );

  Widget buildCategoryIcons(BuildContext context) {
    List<Category> allCategories;
    CategoryIcon categoryIcon;
    for (Category category in getCategories()) {
      if (category.categoryName == widget.mainCategory) {
        categoryIcon = category.categoryIcon;
        allCategories = category.subCategories;
      }
    }

    return Container(
      child: (allCategories == null)
          ? Text("")
          : Container(
              height: 120,
              child: new ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 4),
                children: allCategories.map((i) {
                  return new Container(
                    margin: EdgeInsets.only(right: 18),
                    child: new Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new RawMaterialButton(
                          onPressed: () => navigateToCategoryView(context, mainCategory: widget.mainCategory, subCategory: i.categoryName),
                          child: categoryIcon,
                          shape: new CircleBorder(),
                          elevation: 0,
                          fillColor: Colors.grey[100],
                          padding: const EdgeInsets.all(15.0),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 1.0, horizontal: 1.0),
                            child: Text(
                              i.categoryName,
                              style: TextStyle(fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }
}
