import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/products.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import './FadeAnimation.dart';
import 'main.dart';

void main() {
  runApp(MyappTwo());
}

class MyappTwo extends StatelessWidget {
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
  File _image;
  final picker = ImagePicker();
  TextEditingController productname = TextEditingController();
  TextEditingController productnumber = TextEditingController();
  TextEditingController productprice = TextEditingController();
  TextEditingController productpricebuy = TextEditingController();
  List<Product> list = new List<Product>();
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    loadSharedPreferencesAndData();
    super.initState();
  }

  void loadSharedPreferencesAndData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  _openGallary() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    this.setState(() {
      _image = File(pickedFile.path);
    });
  }

  Widget _decideImageViews() {
    if (_image == null) {
      return InkWell(
        onTap: () {
          _openGallary();
        },
        child: Icon(
          Icons.add_a_photo,
          color: Colors.blueGrey,
        ),
      );
    } else {
      return Center(child: Image.file(_image));
    }
  }

  Widget __homeCode() {
    return FadeAnimation(
        1.5,
        SafeArea(
            child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Buy Your Product',
                  style: GoogleFonts.roboto(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 30),
                Container(
                  width: 250,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueGrey,
                      width: 2,
                    ),
                  ),
                  child: _decideImageViews(),
                ),
                SizedBox(height: 20),
                TextField(
                    controller: productname,
                    autocorrect: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey)),
                        hintText: 'Name of Product',
                        hintStyle: GoogleFonts.roboto(color: Colors.black26))),
                SizedBox(height: 20),
                TextField(
                    controller: productnumber,
                    autocorrect: true,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey)),
                        hintText: 'How many number of your product',
                        hintStyle: GoogleFonts.roboto(color: Colors.black26))),
                SizedBox(height: 20),
                TextField(
                    controller: productprice,
                    autocorrect: true,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey)),
                        hintText: 'The Price To Buy One Of The Product ',
                        hintStyle: GoogleFonts.roboto(color: Colors.black26))),
                SizedBox(height: 20),
                TextField(
                    controller: productpricebuy,
                    autocorrect: true,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey)),
                        hintText: 'The Price To Sell One Of The Product ',
                        hintStyle: GoogleFonts.roboto(color: Colors.black26))),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    goToNewItemView();
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
                    child: Text(
                      'Add The Product',
                      style:
                          GoogleFonts.roboto(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: __homeCode(),
      backgroundColor: Colors.white,
    );
  }

  // void saveData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String> stringList =
  //       list.map((item) => json.encode(item.toMap())).toList();
  //   prefs.setStringList('list', stringList);
  // }
  void saveData() {
    List<String> stringList =
        list.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList('list', stringList);
  }

  void addItem(Product item) {
    // Insert an item into the top of our list, on index zero
    list.insert(0, item);
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

  void goToNewItemView() {
    if (productname != null ||
        productnumber != null ||
        productprice != null ||
        productpricebuy != null) {
      if (_image == null || _image.path == null) {
        if (productname.text.isEmpty ||
            productnumber.text.isEmpty ||
            productprice.text.isEmpty ||
            productpricebuy.text.isEmpty) {
          final snackBar = SnackBar(
              content: Text('All Fields Are Required *'),
              action: SnackBarAction(
                label: 'Close',
                onPressed: () {
                  // Some code to undo the change.
                },
              ));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          addItem(Product(
              image: null,
              name: productname.text,
              price: productprice.text,
              oneproductcost: productpricebuy.text,
              numberproduct: productnumber.text));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Myapp()),
          );
        }
      } else {
        if (productname.text.isEmpty ||
            productnumber.text.isEmpty ||
            productprice.text.isEmpty) {
          final snackBar = SnackBar(
              content: Text('All Fields Are Required *'),
              action: SnackBarAction(
                label: 'Close',
                onPressed: () {
                  // Some code to undo the change.
                },
              ));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          addItem(Product(
              image: _image.path,
              name: productname.text,
              price: productprice.text,
              oneproductcost: productpricebuy.text,
              numberproduct: productnumber.text));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Myapp()),
          );
        }
      }
    } else {
      final snackBar = SnackBar(
          content: Text('All Fields Are Required *'),
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
