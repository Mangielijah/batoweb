import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class BannerSectionMobile extends StatelessWidget {
  const BannerSectionMobile({this.screenWidth, this.screenHeight});
  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.screenHeight,
      width: screenWidth,
      child: Column(
        children: <Widget>[
          Center(
            child: buildPromotionSlide(context),
          ),
          SizedBox(
            height: 14.0,
          ),
          buildPromotion2(context),
        ],
      ),
    );
  }

  Expanded buildPromotion2(BuildContext context) {
    return Expanded(
          child: Container(
            height: this.screenHeight / 2 + 50,//(this.screenHeight / 3) + 300,
            width: this.screenWidth - 20,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade400,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Container(
                              height: 44,
                              width: 44,
                              constraints:
                                  BoxConstraints(maxWidth: 44, maxHeight: 44),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/logo_only.png"))),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Text(
                          "Sell in a snap,",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "buy with a chat.",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        MaterialButton(
                          padding: EdgeInsets.only(left: 0),
                          onPressed: (){},
                          child: Image.asset(
                            "assets/images/playstore.png",
                            height: 44,
                            width: 150,
                          ),
                        ),
                        SizedBox(height: 4,),
                        MaterialButton(
                          padding: EdgeInsets.only(left: 0),
                          onPressed: (){},
                          child: Image.asset(
                            "assets/images/appstore.png",
                            fit: BoxFit.fitWidth,
                            height: 45,
                            width: 150,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 55, right: 12),
                    child: Image.asset("assets/images/phone_preview.jpg"),
                  ),
                )
              ],
            ),
          ),
        );
  }

  buildPromotionSlide(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Container(
          height: this.screenHeight / 2 - 50, //(MediaQuery.of(context).size.height / 3),
          width: (this.screenWidth ) - 20,
          child: Center(
            child: new Swiper(
              itemBuilder: (BuildContext context, int index) {
                return new Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://media.karousell.com/media/photos/special-collections/2020/02/05/cm_ctac-SingaMoto-edit_M_(1500,_610).png",
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
              itemCount: 5,
              autoplay: false,
              pagination: new SwiperPagination(),
              control: new SwiperControl(),
              //viewportFraction: 0.8,
              //scale: 0.9,
              index: 0,
            ),
          )),
    );
  }
}
