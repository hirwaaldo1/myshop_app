class Product {
  String image;
  String name;
  String numberproduct;
  String price;
  bool isbought;
  int boughtnumber;
  String oneproductcost;
  int profit;
  int buyone;
  int producticreas;
  bool isitbuyinsop;
  bool isncreasingProduct;

  Product({
    this.image,
    this.name,
    this.price = '0',
    this.numberproduct,
    this.boughtnumber = 0,
    this.isncreasingProduct = false,
    this.oneproductcost = '0',
    this.profit = 0,
    this.buyone = 0,
    this.producticreas = 0,
    this.isitbuyinsop = false,
    this.isbought = false,
  });

  Product.fromMap(Map map)
      : this.image = map['image'],
        this.name = map['name'],
        this.price = map['price'],
        this.numberproduct = map['numberproduct'],
        this.boughtnumber = map['boughtnumber'],
        this.isncreasingProduct = map['isncreasingProduct'],
        this.oneproductcost = map['oneproductcost'],
        this.profit = map['profit'],
        this.buyone = map['buyone'],
        this.producticreas = map['producticreas'],
        this.isitbuyinsop = map['isitbuyinsop'],
        this.isbought = map['isbought'];

  Map toMap() {
    return {
      'image': this.image,
      'name': this.name,
      'price': this.price,
      'numberproduct': this.numberproduct,
      'boughtnumber': this.boughtnumber,
      "isncreasingProduct": this.isncreasingProduct,
      'oneproductcost': this.oneproductcost,
      'profit': this.profit,
      'buyone': this.buyone,
      'producticreas': this.producticreas,
      'isitbuyinsop': this.isitbuyinsop,
      'isbought': this.isbought,
    };
  }
}
