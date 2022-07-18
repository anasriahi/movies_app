import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/repositories/data_repository.dart';
import 'package:movies_app/ui/widgets/movie_card.dart';
import 'package:movies_app/ui/widgets/movie_category.dart';
import 'package:movies_app/utils/constant.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: Image.asset('assets/images/netflix_logo_2.png'),
      ),
      body: ListView(
        children: [
          SizedBox(
              height: 500,
              child: MovieCard(movie: dataProvider.popularMovieList.first)
          ),
          MovieCategory(
              imageHeight: 160,
              imageWidth: 110,
              label: 'Tendances Actuelles',
              movieList: dataProvider.popularMovieList
          ),
          MovieCategory(
              imageHeight: 320,
              imageWidth: 220,
              label: 'Actuellement au cinéma',
              movieList: dataProvider.popularMovieList
          ),
          MovieCategory(
              imageHeight: 160,
              imageWidth: 110,
              label: 'Ils arrivent bientôt',
              movieList: dataProvider.popularMovieList
          ),
        ],
      ),
    );
  }
}
