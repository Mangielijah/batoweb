import 'package:bato_test/Icons/bato_icons.dart';
import 'package:bato_test/category_section/category_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category {
  final List<Category> subCategories;
  final String categoryName;
  final CategoryIcon categoryIcon;

  Category(this.categoryName,
      {this.categoryIcon =
          const CategoryIcon(iconData: FontAwesomeIcons.arrowAltCircleRight),
      this.subCategories = const <Category>[]});
}

List<Category> getCategories() {
  return [
    Category("Following", categoryIcon: CategoryIcon(iconData: Bato.following)),
    Category("Beauty & Health",
        categoryIcon: CategoryIcon(iconData: Bato.beauty_health),
        subCategories: [
          Category("Makeup"),
          Category("Hair Care"),
          Category("Face & Skin Care"),
          Category("Bath & Body"),
          Category("Perfumes & Deodorants"),
          Category("Hand & Foot Care"),
          Category("Men's Grooming"),
        ]),
    Category("Women's Fashion",
        categoryIcon: CategoryIcon(iconData: Bato.womens_fashion),
        subCategories: [
          Category("Women's Watches"),
          Category("Women's Bags and Wallets"),
          Category("Women's Shoes"),
          Category("Women's Accessories"),
          Category("Women's Clothes"),
        ]),
    Category("Men's Fashion",
        categoryIcon: CategoryIcon(iconData: Bato.mens_fashion),
        subCategories: [
          Category("Men's Watches"),
          Category("Men's Bags and Wallets"),
          Category("Men's Shoes"),
          Category("Men's Accessories"),
          Category("Men's Clothes"),
        ]),
    Category("Mobiles",
        categoryIcon: CategoryIcon(iconData: Bato.mobile_phones),
        subCategories: [
          Category("iPhones"),
          Category("Android Phones"),
          Category("Tablets"),
          Category("Other Phones"),
          Category("Phone Accessories"),
        ]),
    Category("Electronics",
        categoryIcon: CategoryIcon(iconData: Bato.television),
        subCategories: [
          Category("Televisions"),
          Category("Sound Systems"),
          Category("Men's Shoes"),
          Category("Men's Accessories"),
          Category("Men's Clothes"),
        ]),
//    Category("Jobs", categoryIcon: CategoryIcon(iconData: Bato.jobs)),
//    Category("Houses & Land", categoryIcon: CategoryIcon(iconData: Bato.house)),
//    Category("Services", categoryIcon: CategoryIcon(iconData: Bato.services)),
    Category("Home & Furniture",
        categoryIcon: CategoryIcon(iconData: Bato.home_furniture)),
    Category("Music & Media", categoryIcon: CategoryIcon(iconData: Bato.music)),
    Category("Food & Drinks",
        categoryIcon: CategoryIcon(iconData: Bato.food_drinks)),
    Category("Babies & Kids", categoryIcon: CategoryIcon(iconData: Bato.kids)),
    Category("Kitchen Appliances",
        categoryIcon: CategoryIcon(iconData: Bato.kitchen)),
    Category("Books & Stationery",
        categoryIcon: CategoryIcon(iconData: Bato.books)),
    Category("Cameras & Photography",
        categoryIcon: CategoryIcon(iconData: Bato.camera)),
    Category("Tickets & Vouchers",
        categoryIcon: CategoryIcon(iconData: Bato.ticket)),
    Category("Sports", categoryIcon: CategoryIcon(iconData: Bato.sports)),
    Category("Video Gaming",
        categoryIcon: CategoryIcon(iconData: Bato.video_games)),
    Category("Looking For",
        categoryIcon: CategoryIcon(iconData: Bato.looking_for)),
    Category("Everything Else",
        categoryIcon: CategoryIcon(iconData: FontAwesomeIcons.ellipsisH)),
  ];
}

