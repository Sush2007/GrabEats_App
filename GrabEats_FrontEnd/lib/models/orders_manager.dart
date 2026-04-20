import 'package:flutter/foundation.dart';

class Order {
  final String restaurantName;
  final String grabType;
  final int guestCount;
  final DateTime timestamp;

  Order({
    required this.restaurantName,
    required this.grabType,
    required this.guestCount,
    required this.timestamp,
  });
}

class OrdersManager {
  static final OrdersManager _instance = OrdersManager._internal();

  factory OrdersManager() {
    return _instance;
  }

  OrdersManager._internal();

  final ValueNotifier<List<Order>> ordersNotifier = ValueNotifier<List<Order>>([]);

  void addOrder(Order order) {
    ordersNotifier.value = List.from(ordersNotifier.value)..add(order);
  }
}
