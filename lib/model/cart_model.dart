

class Cart_Model{
  final int? id;
  final String date ;
  final String item ;
  final String price;
  final String discount;
  final String quantity;
  final String total;

  const Cart_Model({ this.id,required this.date,required this.item, required this.price,required this.discount,required this.quantity,required this.total});

  factory Cart_Model.fromJson(Map<String,dynamic> json) {
    return Cart_Model(
      id: json['id'],
      date: json['date'],
      item: json['item'],
      price: json['price'],
      discount: json['discount'],
      quantity: json['quantity'],
      total: json['total'],
    );
  }

  Map<String,dynamic> toJson() {
    return {
      'id': id,
      'date' : date,
      'item' : item,
      'price': price,
      'discount': discount,
      'quantity': quantity,
      'total': total,
    };
  }
}