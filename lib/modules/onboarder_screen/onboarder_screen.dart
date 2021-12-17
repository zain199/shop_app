import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/loginscreen/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/Cache_Helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onBoarderScreen extends StatefulWidget {
  @override
  _onBoarderScreenState createState() => _onBoarderScreenState();
}

class _onBoarderScreenState extends State<onBoarderScreen> {
  List titles = ['Choose Your Product', 'Add To Cart', 'Pay By Card'];

  List subTitles = [
    'There Are More Than 1000 Brands Of Men\'s and Women\'s shoes and Clothing in the catalog',
    'Just Add Some Items To Your Cart To Buy',
    'You Can Pay By Card For All Proucts'
  ];

  List images = ['onboard_1.jpg', 'onboard_2.jpg', 'onboard_3.jpg'];

  var pageViewController = PageController();
  bool isLast = false;

  void submitted ()
  {
    Cache_Helper.setData('onBoarding', true);
    NavigatorToAndKill(context, LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: submitted,
              child: Text('SKIP'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if (index == titles.length - 1)
                    isLast = true;
                  else
                    isLast = false;
                },
                controller: pageViewController,
                itemBuilder: (context, index) => pageViewItem(
                    context, titles[index], subTitles[index], images[index]),
                itemCount: titles.length,
              ),
            ),

            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageViewController,
                  effect: ExpandingDotsEffect(
                    expansionFactor: 2.0,
                      activeDotColor: defColor,
                      dotHeight: 5.0,
                      strokeWidth: 5.0,

                  ),
                  count: titles.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submitted();
                    } else {
                      pageViewController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_outlined),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget pageViewItem(context, String title, String subtitle, String image) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18.0)),
            ),
            child: Image(
              image: AssetImage(
                'assets/images/${image}',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Center(
          child: Text(
            '${title} ',
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(color: Colors.black),
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Center(
          child: Text(
            '${subtitle}',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.grey, fontSize: 18.0),
          ),
        ),
        SizedBox(
          height: 15.0,
        ),

      ],
    );
  }
}
