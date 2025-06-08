import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/coin_datasource.dart';
import 'repository/coin_repository.dart';
import 'viewmodel/coin_viewmodel.dart';
import 'view/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CoinViewModel(CoinRepository(CoinDataSource())),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
