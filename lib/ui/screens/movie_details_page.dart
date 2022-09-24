import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/repositories/data_repository.dart';
import 'package:movies_app/ui/widgets/action_button.dart';
import 'package:movies_app/ui/widgets/casting_card.dart';
import 'package:movies_app/ui/widgets/movie_info.dart';
import 'package:movies_app/ui/widgets/my_video_player.dart';
import 'package:movies_app/utils/constant.dart';
import 'package:provider/provider.dart';

import '../widgets/galerie_card.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;

  const MovieDetailsPage({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  Movie? newMovie;

  @override
  void initState() {
    super.initState();
    getMovieDetails();
  }

  void getMovieDetails() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    // Récuperer les details du movie
    Movie _movie = await dataProvider.getMovieDetails(movie: widget.movie);
    setState(() {
      newMovie = _movie;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
        ),
        body: newMovie == null
            ? Center(
                child: SpinKitFadingCircle(
                  color: kPrimaryColor,
                  size: 20,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Container(
                        height: 220,
                        width: MediaQuery.of(context).size.width,
                        child: newMovie!.videos!.isEmpty
                            ? Center(
                                child: Text(
                                  'Pas de videos',
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                              )
                            : MyVideoPlayer(movieId: newMovie!.videos!.first)),
                    MovieInfo(movie: newMovie!),
                    const SizedBox(
                      height: 10,
                    ),
                    ActionButton(
                        label: 'Lecture',
                        icon: Icons.play_arrow,
                        bgColor: Colors.white,
                        textColor: kBackgroundColor),
                    const SizedBox(
                      height: 10,
                    ),
                    ActionButton(
                        label: 'Télécharger la vidéo',
                        icon: Icons.download,
                        bgColor: Colors.grey.withOpacity(0.3),
                        textColor: Colors.white),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      newMovie!.description,
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Casting',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 350,
                      child: ListView.builder(
                          itemCount: newMovie!.casting!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, int index) {
                            return newMovie!.casting![index].imageURL == null
                                ? const Center()
                                : CastingCard(
                                    person: newMovie!.casting![index]);
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Galerie',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                          itemCount: newMovie!.images!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, int index) {
                            return GalerieCard(
                              posterPath: newMovie!.images![index],
                            );
                          }),
                    ),
                  ],
                ),
              ));
  }
}
