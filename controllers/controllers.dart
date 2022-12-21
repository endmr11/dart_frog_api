import 'login_controllers/login_controllers.dart';
import 'orders_controllers/orders_controllers.dart';
import 'products_controllers/products_controllers.dart';
import 'user_controllers/user_controllers.dart';

class Controllers {
  //LOGIN
  final loginControllers = LoginControllers();

  //ORDERS
  final ordersControllers = OrdersControllers();

  //PRODUCTS
  final productControllers = ProductControllers();

  //USERS
  final userControllers = UsersControllers();
}
