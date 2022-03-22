class Orders {
  List<Order>? data;

  Orders({this.data});

  Orders.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Order>[];
      json['data'].forEach((v) {
        data!.add(new Order.fromJson(v));
      });
    }
  }
}

class Order {
  double distance = 1000000.0;
  String? salesOrderId;
  String? tranId;
  String? phone;
  String? phone2;
  String? customerName;
  String? address;
  String? description;
  String? longitude;
  String? latitude;
  String? city;
  String? cityId;
  String? downPayment;
  String? deliveryDate;
  String? deliveryTime;
  String? status;
  String? statusId;
  String? notes;
  List<Fulfill>? fulfill;

  Order(
      {this.salesOrderId,
      this.phone,
      this.tranId,
      this.phone2,
      this.customerName,
      this.address,
      this.description,
      this.longitude,
      this.latitude,
      this.city,
      this.cityId,
      this.downPayment,
      this.deliveryDate,
      this.deliveryTime,
      this.status,
      this.statusId,
      this.notes,
      this.fulfill});

  Order.fromJson(Map<String, dynamic> json) {
    salesOrderId = json['salesOrderId'];
    tranId = json['tranid'];
    phone = json['phone'];
    phone2 = json['phone2'] ?? "";
    customerName = json['customername'] ?? "";
    address = json['address'] ?? "";
    description = json['description'] ?? "";
    longitude = json['longitude'] ?? "0.0";
    longitude = longitude?.length == 0 ? "0.0" : longitude;
    latitude = json['latitude'] ?? "0.0";
    latitude = latitude?.length == 0 ? "0.0" : latitude;

    city = json['city'] ?? "" ?? "";
    cityId = json['cityid'];
    downPayment = json['down_payment'] ?? "";
    deliveryDate = json['delivery_date'] ?? "";
    deliveryTime = json['delivery_time'] ?? "";
    status = json['status'] ?? "";
    statusId = json['statusid'] ?? "";
    notes = json['Notes'] ?? "";
    if (json['fulfill'] != null) {
      fulfill = <Fulfill>[];
      json['fulfill'].forEach((v) {
        fulfill!.add(new Fulfill.fromJson(v));
      });
    }
  }
}

class Fulfill {
  double? remaining;
  List<Items>? items;

  Fulfill({this.remaining, this.items});

  Fulfill.fromJson(Map<String, dynamic> json) {
    remaining = json['Remaining'] * 1.0;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }
}

class Items {
  String? item;
  String? quantity;
  int? boxesNumber;

  Items({this.item, this.quantity, this.boxesNumber});

  Items.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    quantity = json['quantity'];
    boxesNumber = json['boxes_number'];
  }
}
