import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/products.dart';
import './add.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import './FadeAnimation.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BodyLogin(),
    );
  }
}

class BodyLogin extends StatefulWidget {
  @override
  _BodyLoginState createState() => _BodyLoginState();
}

class _BodyLoginState extends State<BodyLogin> {
  int number;
  List<Product> list = new List<Product>();

  TextEditingController productcount = TextEditingController();

  TextEditingController seacher_controller = new TextEditingController();

  SharedPreferences sharedPreferences;
  Widget __mycard(
      Product item, String name, String numberproduct, String image) {
    saveData();
    if (list.length == 0 || list.length == null) {
      return Container(
        height: 185,
        padding: EdgeInsets.only(left: 12, right: 12, top: 20),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 12, right: 12, top: 10),
              width: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyappTwo()),
                      );
                    },
                    child: Container(
                      color: Colors.blueGrey,
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'Add One',
                        style: GoogleFonts.roboto(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("You shop is empty",
                      style: GoogleFonts.roboto(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: Colors.black45)),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyappTwo()),
                );
              },
              child: Container(
                margin: EdgeInsets.only(left: 200, top: 17),
                width: 150.0,
                height: 130.0,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[300],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(left: 12, right: 12, top: 20),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 12, right: 12, top: 10),
              width: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                    ),
                    padding: EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () {
                        showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: AlertDialog(
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: [
                                        GestureDetector(
                                          child: __buyproduct(
                                              item, numberproduct, image, name),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Text(
                        'Sell The Product',
                        style: GoogleFonts.roboto(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: [
                                    GestureDetector(
                                      child: __addproduct(item),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5)),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Buy The Product',
                        style: GoogleFonts.roboto(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.done_all,
                        color: Colors.black45,
                        size: 17,
                      ),
                      SizedBox(width: 6),
                      Text(
                        "${numberproduct} Product",
                        style: GoogleFonts.roboto(
                            color: Colors.black45, fontSize: 12),
                      )
                    ],
                  )
                ],
              ),
            ),
            // image chnage
            image == null
                ? Container(
                    margin: EdgeInsets.only(left: 200, top: 17),
                    width: 150.0,
                    height: 130.0,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[300],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(child: Text('No Image')),
                  )
                : Container(
                    margin: EdgeInsets.only(left: 200, top: 17),
                    width: 150.0,
                    height: 130.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover, image: FileImage(File(image))),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  )
          ],
        ),
      );
    }
  }

  Widget __howmanyicreasse(Product item) {
    saveData();
    if (item.name.length != 0) {
      item.buyone = int.parse(item.price) * item.producticreas;
      item.profit = (int.parse(item.price) * item.boughtnumber) -
          (int.parse(item.oneproductcost) * item.boughtnumber);

      saveData();
      if (item.boughtnumber <= 0) {
        item.isitbuyinsop = false;

        saveData();
      }

      saveData();
    }
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12, top: 20),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 12, right: 12, top: 10),
            width: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name,
                    style: GoogleFonts.roboto(
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                        color: Colors.black)),
                SizedBox(
                  height: 10,
                ),
                Container(
                    child: Text('Revolutionary',
                        style: GoogleFonts.roboto(
                            fontSize: 13, color: Colors.black38))),
                SizedBox(
                  height: 10,
                ),
                Container(
                    child: Text('Readers like to feel appreciated.',
                        style: GoogleFonts.roboto(
                            fontSize: 13, color: Colors.black38))),
                SizedBox(
                  height: 10,
                ),
                Divider(color: Colors.black38),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      '${int.parse(item.price) * item.producticreas} Frw',
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Container(
                      color: Colors.black38,
                      padding: EdgeInsets.only(left: 12, right: 12),
                      child: Text(
                        "${item.producticreas}",
                        style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w300),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 22,
                ),
              ],
            ),
          ),
          item.image == null
              ? Container(
                  margin: EdgeInsets.only(left: 200, top: 17),
                  width: 150.0,
                  height: 130.0,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[300],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(child: Text('No Image')),
                )
              : Container(
                  margin: EdgeInsets.only(left: 200, top: 17),
                  width: 150.0,
                  height: 130.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: FileImage(File(item.image))),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
        ],
      ),
    );
  }

  Widget __bestbuy(Product item) {
    saveData();
    if (item.name.length != 0) {
      item.buyone = int.parse(item.price) * item.producticreas;
      item.profit = (int.parse(item.oneproductcost) * item.boughtnumber) -
          (int.parse(item.price) * item.boughtnumber);
      saveData();
      if (item.boughtnumber <= 0) {
        item.isbought = false;
        saveData();
      }
      saveData();
      var jjjjjj = list
          .where((i) => i.isbought)
          .toList()
          .map((e) => json.encode(e.toMap()));
      print(jjjjjj);
    }
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12, top: 20),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 12, right: 12, top: 10),
            width: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name,
                    style: GoogleFonts.roboto(
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                        color: Colors.black)),
                SizedBox(
                  height: 10,
                ),
                Container(
                    child: Text('Revolutionary',
                        style: GoogleFonts.roboto(
                            fontSize: 13, color: Colors.black38))),
                SizedBox(
                  height: 10,
                ),
                Container(
                    child: Text('Readers like to feel appreciated.',
                        style: GoogleFonts.roboto(
                            fontSize: 13, color: Colors.black38))),
                SizedBox(
                  height: 10,
                ),
                Divider(color: Colors.black38),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      '${int.parse(item.oneproductcost) * item.boughtnumber} Frw',
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Container(
                      color: Colors.black38,
                      padding: EdgeInsets.only(left: 12, right: 12),
                      child: Text(
                        "${item.boughtnumber}",
                        style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w300),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 22,
                ),
              ],
            ),
          ),
          item.image == null
              ? Container(
                  margin: EdgeInsets.only(left: 200, top: 17),
                  width: 150.0,
                  height: 130.0,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[300],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(child: Text('No Image')),
                )
              : Container(
                  margin: EdgeInsets.only(left: 200, top: 17),
                  width: 150.0,
                  height: 130.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: FileImage(File(item.image))),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
        ],
      ),
    );
  }

  Widget __buyproduct(
      Product item, String numberproduct, String image, String name) {
    saveData();
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                child: Text('How many product',
                    style: GoogleFonts.roboto(
                        fontSize: 15, fontWeight: FontWeight.w600)),
              ),
              Container(
                  child: TextField(
                keyboardType: TextInputType.number,
                controller: productcount,
                maxLength: 5,
                textAlign: TextAlign.center,
                autofocus: true,
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              )),
            ],
          ),
        ),
        SizedBox(
          width: 8,
        ),
        item.image == null
            ? Expanded(
                child: Container(
                  width: 90.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[300],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                      child: Text('No Image',
                          style: GoogleFonts.roboto(fontSize: 13))),
                ),
              )
            : Expanded(
                child: Container(
                  width: 90.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: FileImage(File(image))),
                  ),
                ),
              ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  name,
                  style: GoogleFonts.roboto(
                      fontSize: 15, fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: () {
                    buyproduct(item, item.isbought, item.boughtnumber);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => super.widget));
                    saveData();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Center(
                      child: Text(
                        'Sell',
                        style: GoogleFonts.roboto(
                            color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget __addproduct(Product item) {
    saveData();
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                child: Text('How many product',
                    style: GoogleFonts.roboto(
                        fontSize: 15, fontWeight: FontWeight.w600)),
              ),
              Container(
                  child: TextField(
                keyboardType: TextInputType.number,
                controller: productcount,
                maxLength: 5,
                textAlign: TextAlign.center,
                autofocus: true,
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              )),
            ],
          ),
        ),
        SizedBox(
          width: 8,
        ),
        item.image == null
            ? Expanded(
                child: Container(
                  width: 90.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[300],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                      child: Text('No Image',
                          style: GoogleFonts.roboto(fontSize: 13))),
                ),
              )
            : Expanded(
                child: Container(
                  width: 90.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: FileImage(File(item.image))),
                  ),
                ),
              ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  item.name,
                  style: GoogleFonts.roboto(fontSize: 15),
                ),
                InkWell(
                  onTap: () {
                    increaseproduct(item);

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => super.widget));
                    saveData();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Center(
                      child: Text(
                        'Buy',
                        style: GoogleFonts.roboto(
                            color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget __homeCode() {
    List<Product> bestproductbuy = list.where((i) => i.isbought).toList();
    List<Product> bestproductbuyshoud =
        list.where((i) => i.isncreasingProduct).toList();
    int ishtrap;
    int moneyyoush;
    if (bestproductbuy.map<int>((m) => m.profit).isNotEmpty) {
      saveData();
      ishtrap =
          bestproductbuy.map<int>((m) => m.profit).reduce((a, b) => a + b);

      saveData();
    }
    if (bestproductbuyshoud.map<int>((m) => m.buyone).isNotEmpty) {
      moneyyoush =
          bestproductbuyshoud.map<int>((m) => m.buyone).reduce((a, b) => a + b);

      saveData();
    }
    print(moneyyoush);
    return SafeArea(
      child: Stack(
        children: [
          Container(
              padding: EdgeInsets.only(left: 12, right: 12, top: 10),
              color: Colors.blueGrey,
              height: 250,
              child: Column(
                children: [
                  FadeAnimation(
                      1.2,
                      Row(
                        children: [
                          Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new NetworkImage(
                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT87Hk5mDHP1vnGzZ_rDwvkkKsN4Nvxahw3yA&usqp=CAU")))),
                          Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hi, Mum',
                                    style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  list.length == null
                                      ? Text(
                                          "You have 0 product in your shop",
                                          style: GoogleFonts.roboto(
                                              color: Colors.white24,
                                              fontSize: 11),
                                        )
                                      : Text(
                                          "You have ${list.length} product in your shop",
                                          style: GoogleFonts.roboto(
                                              color: Colors.white24,
                                              fontSize: 11),
                                        )
                                ],
                              )),
                          SizedBox(
                            width: 100,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          super.widget));
                            },
                            child: Container(
                              child: Icon(Icons.repeat, color: Colors.white),
                            ),
                          )
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                      1.3,
                      Container(
                        padding: EdgeInsets.only(left: 12, right: 12),
                        decoration: BoxDecoration(
                            color: Colors.blueGrey[400],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          children: [
                            Container(
                                width: 280,
                                child: TextField(
                                    controller: seacher_controller,
                                    onChanged: onSearchTextChanged,
                                    autocorrect: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Search',
                                        hintStyle: GoogleFonts.roboto(
                                            color: Colors.white24)))),
                            Container(
                              child: Icon(
                                Icons.search,
                                color: Colors.white24,
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              )),
          FadeAnimation(
              1.5,
              Container(
                  margin: EdgeInsets.only(top: 150),
                  child: PageView(
                    children: [
                      Container(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.white70, width: 0))),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: Container(
                                      child: Center(
                                          child: Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.white,
                                                    width: 2))),
                                        child: Text('All Product',
                                            style: GoogleFonts.roboto(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15)),
                                      )),
                                    )),
                                    Expanded(
                                        child: Container(
                                      child: Center(
                                          child: Text('Sell Product',
                                              style: GoogleFonts.roboto(
                                                  color: Colors.white30,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15))),
                                    )),
                                    Expanded(
                                        child: Container(
                                      child: Center(
                                          child: Text('Should Buy',
                                              style: GoogleFonts.roboto(
                                                  color: Colors.white30,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15))),
                                    )),
                                  ],
                                ),
                              ),
                              _searchResult.length != 0 ||
                                      seacher_controller.text.isNotEmpty
                                  ? Container(
                                      width: 400,
                                      height: 380,
                                      child: ListView.builder(
                                          itemCount: _searchResult.length,
                                          itemBuilder: (context, index) {
                                            final item = _searchResult[index];
                                            return __mycard(item, item.name,
                                                item.numberproduct, item.image);
                                          }),
                                    )
                                  : Container(
                                      width: 400,
                                      height: 380,
                                      child: ListView.builder(
                                          itemCount: list.length,
                                          itemBuilder: (context, index) {
                                            final item = list[index];
                                            return __mycard(item, item.name,
                                                item.numberproduct, item.image);
                                          }),
                                    )
                            ],
                          ),
                        ),
                      ),
                      //Buy
                      Container(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.white70, width: 0))),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: Container(
                                      child: Center(
                                          child: Container(
                                        child: Text('All Product',
                                            style: GoogleFonts.roboto(
                                                color: Colors.white30,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15)),
                                      )),
                                    )),
                                    Expanded(
                                        child: Container(
                                      child: Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.white,
                                                    width: 2))),
                                        child: Center(
                                            child: Text('Sell Product',
                                                style: GoogleFonts.roboto(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15))),
                                      ),
                                    )),
                                    Expanded(
                                        child: Container(
                                      child: Center(
                                          child: Text('Should Buy',
                                              style: GoogleFonts.roboto(
                                                  color: Colors.white30,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15))),
                                    )),
                                  ],
                                ),
                              ),
                              _searchResult.length != 0 ||
                                      seacher_controller.text.isNotEmpty
                                  ? Container(
                                      width: 400,
                                      height: 380,
                                      child: ListView.builder(
                                          itemCount: _searchResult.length,
                                          itemBuilder: (context, index) {
                                            final item = _searchResult[index];
                                            return __mycard(item, item.name,
                                                item.numberproduct, item.image);
                                          }),
                                    )
                                  : bestproductbuy.length == null
                                      ? null
                                      : Container(
                                          width: 400,
                                          height: 380,
                                          child: ListView.builder(
                                              itemCount: bestproductbuy.length,
                                              itemBuilder: (context, index) {
                                                final item =
                                                    bestproductbuy[index];

                                                return __bestbuy(item);
                                              }),
                                        ),
                              bestproductbuy.length == null
                                  ? null
                                  : Container(
                                      padding: EdgeInsets.only(
                                          left: 12, right: 12, top: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Profit',
                                            style: GoogleFonts.roboto(
                                                color: Colors.black45,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                            width: 147,
                                          ),
                                          ishtrap == null
                                              ? Text(
                                                  '0 Frw',
                                                  style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 15),
                                                )
                                              : ishtrap < 0
                                                  ? Text(
                                                      '$ishtrap Frw',
                                                      style: GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.red,
                                                          fontSize: 15),
                                                    )
                                                  : Text(
                                                      '$ishtrap Frw',
                                                      style: GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 15),
                                                    )
                                        ],
                                      ))
                            ],
                          ),
                        ),
                      ),
                      // Sell
                      Container(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.white70, width: 0))),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: Container(
                                      child: Center(
                                          child: Container(
                                        child: Text('All Product',
                                            style: GoogleFonts.roboto(
                                                color: Colors.white30,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15)),
                                      )),
                                    )),
                                    Expanded(
                                        child: Container(
                                      child: Container(
                                        child: Center(
                                            child: Text('Sell Product',
                                                style: GoogleFonts.roboto(
                                                    color: Colors.white30,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15))),
                                      ),
                                    )),
                                    Expanded(
                                        child: Container(
                                      child: Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.white,
                                                    width: 2))),
                                        child: Center(
                                            child: Text('Should Buy',
                                                style: GoogleFonts.roboto(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15))),
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                              _searchResult.length != 0 ||
                                      seacher_controller.text.isNotEmpty
                                  ? Container(
                                      width: 400,
                                      height: 380,
                                      child: ListView.builder(
                                          itemCount: _searchResult.length,
                                          itemBuilder: (context, index) {
                                            final item = _searchResult[index];
                                            return __mycard(item, item.name,
                                                item.numberproduct, item.image);
                                          }),
                                    )
                                  : bestproductbuyshoud.length == null
                                      ? null
                                      : Container(
                                          width: 400,
                                          height: 380,
                                          child: ListView.builder(
                                              itemCount:
                                                  bestproductbuyshoud.length,
                                              itemBuilder: (context, index) {
                                                final item =
                                                    bestproductbuyshoud[index];

                                                return __howmanyicreasse(item);
                                              }),
                                        ),
                              bestproductbuyshoud.length == null
                                  ? null
                                  : Container(
                                      padding: EdgeInsets.only(
                                          left: 12, right: 12, top: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Money',
                                            style: GoogleFonts.roboto(
                                                color: Colors.black45,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                            width: 147,
                                          ),
                                          moneyyoush == null
                                              ? Text(
                                                  '0 Frw',
                                                  style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 15),
                                                )
                                              : moneyyoush < 0
                                                  ? Text(
                                                      '$moneyyoush Frw',
                                                      style: GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.red,
                                                          fontSize: 15),
                                                    )
                                                  : Text(
                                                      '$moneyyoush Frw',
                                                      style: GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 15),
                                                    )
                                        ],
                                      ),
                                    )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )))
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: __homeCode(),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyappTwo()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  void addItem(Product item) {
    // Insert an item into the top of our list, on index zero
    list.insert(0, item);
    saveData();
  }

  void buyproduct(Product item, bool isbought, int boughtnumber) {
    item.isbought = true;
    item.isitbuyinsop = true;
    howmayproduct(item);
    saveData();
  }

  void increaseproduct(Product item) {
    increasingproduct(item);
    saveData();
  }

  void removeItem(Product item) {
    list.remove(item);
    saveData();
  }

  void loadData() {
    List<String> listString = sharedPreferences.getStringList('list');
    if (listString != null) {
      list =
          listString.map((item) => Product.fromMap(json.decode(item))).toList();
      setState(() {});
    }
  }

  @override
  void initState() {
    loadSharedPreferencesAndData();
    super.initState();
  }

  void loadSharedPreferencesAndData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  void loadingmoney(Product item) {}

  void saveData() {
    List<String> stringList =
        list.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList('list', stringList);
  }

  void howmayproduct(Product item) {
    if (productcount.text != null) {
      item.boughtnumber = item.boughtnumber + int.parse(productcount.text);
      if (int.parse(item.numberproduct) > 0) {
        var miz = int.parse(item.numberproduct) - int.parse(productcount.text);
        item.numberproduct = miz.toString();
      } else {
        final snackBar = SnackBar(
            content: Text('You Need Buy New Product or All Field Required'),
            action: SnackBarAction(
              label: 'Close',
              onPressed: () {
                // Some code to undo the change.
              },
            ));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  void increasingproduct(Product item) {
    saveData();
    if (productcount.text != null) {
      // item.boughtnumber = int.parse(productcount.text);
      var numberprod = int.parse(item.numberproduct);
      var sum = numberprod + int.parse(productcount.text);
      item.producticreas = item.producticreas + int.parse(productcount.text);
      item.boughtnumber = item.boughtnumber - int.parse(productcount.text);
      item.numberproduct = sum.toString();
      item.isncreasingProduct = true;
      saveData();
      // item.isbought = false;
    } else {
      final snackBar = SnackBar(
          content: Text('All Field Required'),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Some code to undo the change.
            },
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    list.forEach((userDetail) {
      if (userDetail.name.contains(text)) _searchResult.add(userDetail);
    });

    setState(() {});
  }

  List<Product> _searchResult = [];
}
