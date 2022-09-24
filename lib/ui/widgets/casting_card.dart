import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/services/api.dart';
import '../../models/person.dart';

class CastingCard extends StatelessWidget {
  final Person person;

  const CastingCard({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              imageUrl: API().baseImageURL + person.imageURL!,
              width: 160,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) =>
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(padding: EdgeInsets.only(
                        left: 10, right: 10
                    ),
                    ),
                    SizedBox(
                        height: 240,
                        child:
                        Image.asset('assets/images/profile.png')
                    )
                  ],
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 10,
            ),
            child: SizedBox(
              width: 150,
              child: Text(
                person.name,
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: SizedBox(
              width: 150,
              child: Text(
                person.name,
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
