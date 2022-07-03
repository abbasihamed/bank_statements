import 'package:bank_statements/src/presentations/views/card_add/card_add_screen.dart';
import 'package:bank_statements/src/presentations/views/card_detail/card_detail_screen.dart';
import 'package:bank_statements/src/presentations/views/home/home_screen.dart';
import 'package:fluro/fluro.dart';

class AppRoute {
  static final appRoute = FluroRouter();

  static Handler homePage = Handler(handlerFunc: (context, parameters) {
    return const HomeScreen();
  });

  static Handler cardDetailPage = Handler(handlerFunc: (context, parameters) {
    return CardDetailScreen(
      id: parameters['id']![0],
    );
  });

  static Handler cardAddPage = Handler(handlerFunc: (context, parameters) {
    return const CardAddScreen();
  });

  static void defineRoute() {
    appRoute.define('/', handler: homePage);
    appRoute.define('/carddetail/:id', handler: cardDetailPage);
    appRoute.define('/cardadd', handler: cardAddPage);
  }
}
