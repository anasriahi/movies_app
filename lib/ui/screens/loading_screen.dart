import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movies_app/repositories/data_repository.dart';
import 'package:movies_app/ui/screens/home_screen.dart';
import 'package:movies_app/utils/constant.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    // On initialise nos differentes listes de movies
    await dataProvider.initData();
    // ensuite on va sur HomeScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const HomeScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/netflix_logo_1.png'),
          SpinKitFadingCircle(
            color: kPrimaryColor,
            size: 20,
          )
        ],
      ),
    );
  }
}
