import 'package:flutter/material.dart';
import '../../Utils/color.dart';
import '../../widgets/bootom_navigation_bar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return ContentWithBottomNavigationBar(
      appbarTitle: 'Map',
      body: SingleChildScrollView(
          child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: kGrey, blurRadius: 3.0)]),
                child: const ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/kMap.jpeg'))),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 4.2,
                    right: MediaQuery.of(context).size.width / 4.2,
                    top: MediaQuery.of(context).size.height * 0.26),
                // margin: EdgeInsets.symmetric(
                //     horizontal: MediaQuery.of(context).size.width / 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: kSkyBlue),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          '20',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: kWhite),
                        ),
                        Text(
                          'COUNTRIES VISITED',
                          style: TextStyle(fontSize: 8, color: kWhite),
                        ),
                      ],
                    ),
                    Container(
                      color: kWhite,
                      height: 40,
                      width: 2,
                    ),
                    Column(
                      children: [
                        RichText(
                            text: TextSpan(
                                text: '9%',
                                style: TextStyle(fontSize: 30),
                                children: [
                              TextSpan(
                                  text: 'of', style: TextStyle(fontSize: 10))
                            ])),
                        Text(
                          'THE WORLD',
                          style: TextStyle(fontSize: 10, color: kWhite),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.6,
                margin: const EdgeInsets.only(left: 20, right: 6),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 20, right: 0, bottom: 6),
                height: MediaQuery.of(context).size.height * 0.04,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade300),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.search,
                        size: 16,
                      ),
                      border: InputBorder.none,
                      hintText: 'ENTER THE COUNTRY YOU HAVE VISITED',
                      hintStyle: TextStyle(color: kGrey, fontSize: 10)),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: kSkyBlue,
                  ),
                  child: Icon(
                    Icons.share,
                    color: kWhite,
                    size: 16,
                  )),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              const Image(
                  height: 24,
                  width: 24,
                  image: AssetImage('assets/images/fb.jpeg')),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              const Image(
                  height: 24,
                  width: 24,
                  image: AssetImage('assets/images/instagram.jpeg')),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          worldName('AFRICA'),
          Divider(
            height: 1,
            color: kWhite,
          ),
          worldName('ASIA'),
          Divider(
            height: 1,
            color: kWhite,
          ),
          worldName('AUSTRALIA AND OCEANIA'),
          Divider(
            height: 1,
            color: kWhite,
          ),
          worldName('EUROPE'),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              name(
                  'https://cdn.britannica.com/00/6200-004-42B7690E/Flag-Albania.jpg',
                  'ALBANIA'),
              name(
                  'https://cdn.britannica.com/83/5583-050-2F48FD32/Flag-Andorra.jpg',
                  'ANDORRA'),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              name('https://flagpedia.net/data/flags/w1600/at.png', 'AUSTRIA'),
              name(
                  'https://cdn.britannica.com/01/6401-050-0540EE12/Flag-Belarus.jpg?w=400&h=235&c=crop',
                  'BELARUS'),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              name(
                  'https://cdn.britannica.com/08/6408-004-405E272F/Flag-Belgium.jpg',
                  'BELGIUM'),
              name(
                  'https://image.shutterstock.com/image-vector/vector-flag-bulgaria-color-symbol-260nw-1933664291.jpg',
                  'BULGARIA'),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              name(
                  'https://cdn.britannica.com/82/682-004-F0B47FCB/Flag-France.jpg',
                  'FRANCE'),
              name(
                  'https://cdn.britannica.com/97/897-004-232BDF01/Flag-Germany.jpg',
                  'GERMANY'),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              name(
                  'https://cdn.britannica.com/07/8007-004-8CF0B1A9/Flag-Denmark.jpg',
                  'DENMARK'),
              name(
                  'https://cdn.britannica.com/79/579-004-0EA4217C/Flag-Finland.jpg',
                  'FINLAND'),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          worldName('NORTH AND CENTRAL AMERICA'),
          Divider(
            height: 1,
            color: kWhite,
          ),
          worldName('SOUTH AMERICA'),
          Divider(
            height: 1,
            color: kWhite,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
        ],
      )),
    );
  }

  Widget worldName(String name) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 6, 10, 6),
      width: MediaQuery.of(context).size.width,
      color: kSkyBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(color: kWhite),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            size: 20,
            color: kWhite,
          )
        ],
      ),
    );
  }

  Widget name(String image, String name) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.2,
      //  margin: EdgeInsets.only(left: 10, right: 10),
      padding: const EdgeInsets.only(left: 10, top: 6, bottom: 6, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: kWhite,
          boxShadow: [BoxShadow(color: kGrey, blurRadius: 2.0)]),
      child: Row(
        children: [
          CircleAvatar(
              radius: 20, backgroundImage: NetworkImage(image.toString())),
          // Image(image: NetworkImage(image)),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Text(name)
        ],
      ),
    );
  }
}
