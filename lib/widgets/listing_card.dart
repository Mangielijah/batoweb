
//import 'package:bato/utils/listings_manager.dart';
import 'package:bato_test/models/listing.dart';
import 'package:flutter/material.dart';

///An instance of a listing card
///

class ListingCard extends StatefulWidget {
  final Listing listing;

  const ListingCard({Key key, this.listing}) : super(key: key);

  @override
  _ListingCardState createState() => _ListingCardState();
}

class _ListingCardState extends State<ListingCard> {
  /// arguments for listing

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){}, //=> navigateToListing(context, widget.listing.listingID),
      child: Container(
        //height: 400,
        //width: 200,
        child: Card(
          elevation: 0.2,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(child: _buildTop(context)),
                  Flexible(child: _buildTitleAndFavorite()),
                  Flexible(child: _buildListingPrice()),
//                Padding(
//                  padding: const EdgeInsets.only(top: 8.0),
//                  child: Row(
//                    children: <Widget>[
//                      CircleAvatar(
//                        radius: 10,
//                        backgroundImage: NetworkImage(poster.profileImg),
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.only(left: 8.0),
//                        child: Text(
//                          poster.names,
//                          style:
//                              TextStyle(color: Colors.blueGrey, fontSize: 14),
//                        ),
//                      )
//                    ],
//                  ),
//                )
                ]),
          ),
        ),
      ),
    );
  }

  Padding _buildTitleAndFavorite() {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 9,
            child: _buildListingTitle(),
          ),
          Expanded(
            flex: 1,
            child: buildFavoriteButton(false),
          )
        ],
      ),
    );
  }

  Row buildListingOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ///@todo load isFavorite from User favorites list.
        buildOptionsButton()
      ],
    );
  }

  ///format and display listing price
  Text _buildListingPrice() {
    return Text(
      "F " + widget.listing.getFormattedPrice,
      style: TextStyle(color: Colors.lightBlue[500]),
    );
  }

  _buildListingTitle() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Text(
        widget.listing.title,
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  Widget _buildTop(BuildContext context) {
    return Container(
      height: 150,
      child: Stack(
        children: <Widget>[
          _showImage(),
          _showTimeAgo(),
        ],
      ),
    );
  }

  ///show how long ago ad was posted
  Positioned _showTimeAgo() {
    return Positioned.fill(
      top: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.center)),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 4.0),
          child: Text(
            "2 days",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  ClipRRect _showImage() {
    return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(widget.listing.displayImage));
  }

  ///build heart button on images
  ///@todo add onclick method for favorite
  Widget buildFavoriteButton(bool isFavorite) {
    return GestureDetector(
      onTap: () => print("favorite " + widget.listing.listingID),
      child: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.lightBlue,
        size: 20,
      ),
    );
  }

  Widget buildOptionsButton() {
    return GestureDetector(
      onTap: () => print("options " + widget.listing.listingID),
      child: Icon(
        Icons.keyboard_arrow_down,
        color: Colors.lightBlue,
        size: 25,
      ),
    );
  }
}
