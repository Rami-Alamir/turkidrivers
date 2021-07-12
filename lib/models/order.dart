class OrderData {
  List<Order>? order;
  int? orderCount;
  int? remainingOrders;
  OrderData({this.order, this.orderCount, this.remainingOrders});

  OrderData.fromJson(Map<String, dynamic> json) {
    if (json['order'] != null) {
      order = <Order>[];
      json['order'].forEach((v) {
        order?.add(new Order.fromJson(v));
      });
    }
    orderCount = json['Order Count'];
    remainingOrders = json['Delivery in progress'];
  }
}

class Order {
  int? id;
  int? orderTime;
  double? total;
  int? quantity;
  User? user;
  DeliveryAddress? deliveryAddress;
  OrderStatus? orderStatus;
  Payment? payment;
  // FoodOrders? foodOrders;
  Order(
      {this.id,
      this.orderTime,
      this.total,
      this.quantity,
      this.user,
      this.payment,
      // this.foodOrders,
      this.deliveryAddress,
      this.orderStatus});

  Order.fromJson(Map<String, dynamic> json) {
    print(json.toString());
    id = json['id'];
    orderTime = json['order_time'];
    total = double.parse(
        ((json['total'] ?? 0.0) == 0 ? 0.0 : json['total']).toString());
    quantity = json['quantity'] ?? 0;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    payment =
        json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
    // foodOrders = json['food_orders'] != null
    //     ? new FoodOrders.fromJson(json['food_orders'])
    //     : null;
    deliveryAddress = json['delivery_address'] != null
        ? new DeliveryAddress.fromJson(json['delivery_address'])
        : DeliveryAddress(
            distance: 0.00, latitude: 0, longitude: 0, address: '');
    orderStatus = json['order_status'] != null
        ? new OrderStatus.fromJson(json['order_status'])
        : null;
  }
}

class User {
  String? name;
  String? email;

  User({
    this.name,
    this.email,
  });

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
  }
}

class DeliveryAddress {
  String? address;
  double? latitude;
  double? longitude;
  double? distance;

  DeliveryAddress({this.address, this.latitude, this.longitude, this.distance});

  DeliveryAddress.fromJson(Map<String, dynamic> json) {
    address = json['address'] ?? "";
    // latitude = 24.74361792792893;
    // longitude = 46.65843833594841;
    latitude = (json['latitude'] ?? 1.0) == 0 ? 1.0 : json['latitude'] * 1.0;
    longitude = (json['longitude'] ?? 1.0) == 0 ? 1.0 : json['longitude'] * 1.0;
    distance = 0;
  }
}

class OrderStatus {
  int? id;

  OrderStatus({
    this.id,
  });

  OrderStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }
}

class Payment {
  double? price;
  double? paid;
  double? amountDisc;
  double? discount;

  Payment({
    this.price,
    this.paid,
    this.amountDisc,
    this.discount,
  });

  Payment.fromJson(Map<String, dynamic> json) {
    price = (json['price'] ?? 0.0) * 1.0;
    paid = (json['paid'] ?? 0.0) * 1.0;
    amountDisc = (json['amount_disc'] ?? 0.0) * 1.0;
    discount = (json['discount'] ?? 0.0) * 1.0;
  }
}
//
// class FoodOrders {
//   FoodExtra? foodExtra;
//
//   FoodOrders({
//     this.foodExtra,
//   });
//
//   FoodOrders.fromJson(Map<String, dynamic> json) {
//     foodExtra = json['food_extra'] != null
//         ? new FoodExtra.fromJson(json['food_extra'])
//         : null;
//   }
// }
//
// class FoodExtra {
//   Extra? extra;
//
//   FoodExtra({this.extra});
//
//   FoodExtra.fromJson(Map<String, dynamic> json) {
//     extra = json['extra'] != null ? new Extra.fromJson(json['extra']) : null;
//   }
// }
//
// class Extra {
//   double? price;
//
//   Extra({
//     this.price,
//   });
//   Extra.fromJson(Map<String, dynamic> json) {
//     price = (json['price'] ?? 0.0) * 1.0;
//   }
// }
