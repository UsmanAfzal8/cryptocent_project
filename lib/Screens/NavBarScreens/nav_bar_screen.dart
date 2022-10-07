import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/color.dart';
import '../Authentication/SignUp/signup_screen.dart';
import 'CartScreen/cart_model_list.dart';
import 'CartScreen/cart_screen.dart';
import 'FavouriteItems/favourite_screen.dart';
import 'Home/DrawerScreens/drawer_screen.dart';
import 'Home/home_screen.dart';
import 'ProfileScreens/profile_screen.dart';
import 'SellProduct/sell_product_screen.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({Key? key}) : super(key: key);

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final List<Widget> _tabItems = [
    const HomeScreen(),
    const FavouriteScreen(),
    const CartScreen(),
    const SellProductScreen(),
    const ProfileScreen()
  ];
  int _activePage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedPrefs();
  }

  SharedPreferences? prefs;
  bool loading = false;
  sharedPrefs() async {
    loading = true;
    setState(() {});
    print('in LoginPage shared prefs');
    prefs = await SharedPreferences.getInstance();
    userToken = (prefs!.getString('userToken'));
    userId = prefs!.getString('userId');
    print("userId in sharedPrefs is = $userId");
    print("token in sharedPrefs is = $userToken");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerScreen(),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 60.0,
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.black54),
          Icon(
            Icons.favorite_outline,
            size: 30,
            color: Colors.black54,
          ),
          Stack(
            children: [
              Icon(
                Icons.shopping_cart,
                size: 30,
                color: Colors.black54,
              ),
             cartItems.length>0 ?
              Positioned(
                  top: 02,
                  left: 15, right: 0,
                  child: Container(
                    height: 20, width: 30,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: Center(child: Text(cartItems.length.toString(), style: TextStyle(color: kWhite, fontSize: 14, fontWeight: FontWeight.bold),)))):
                 Text(""),
            ],
          ),
          Icon(
            CupertinoIcons.camera,
            size: 30,
            color: Colors.black54,
          ),
          Icon(
            Icons.perm_identity,
            size: 30,
            color: Colors.black54,
          ),
        ],
        color: cyanColor,
        buttonBackgroundColor: Colors.white,
        backgroundColor: primarycolor,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _activePage = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: _tabItems[_activePage],
    );
  }
}
