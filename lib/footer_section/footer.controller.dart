import 'package:bato_test/footer_section/footer.mobile.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          //desktop View
          return FooterMobile();
        } else if (constraints.maxWidth > 800 && constraints.maxWidth < 1200) {
          // Tablet View

          return FooterMobile();
        } else {
          // mobile view of website

          return FooterMobile();
        }
      },
    );
  }
}
