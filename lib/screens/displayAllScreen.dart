import 'package:flutter/material.dart';
import 'package:movieapp/components/components.dart';
import 'package:movieapp/components/constants.dart';

class DisplayAllMovieScreen extends StatefulWidget {
  final String title;
  final List data;
  const DisplayAllMovieScreen(
      {super.key, required this.title, required this.data});

  @override
  State<DisplayAllMovieScreen> createState() => _DisplayAllMovieScreenState();
}

class _DisplayAllMovieScreenState extends State<DisplayAllMovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      appBar: AppBar(
        title: Text(widget.title.toString()),
        leading: Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: const Color.fromARGB(74, 224, 224, 224),
                borderRadius: BorderRadius.circular(20)),
            child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                )),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.count(
          mainAxisSpacing: 30,
          childAspectRatio: 0.7,
          crossAxisCount: 3,
          children: [
            for (var i = 0; i <= widget.data.length - 1; ++i) ...{
              movieCard(
                  image: widget.data[i].image,
                  context: context,
                  id: widget.data[i].id,
                  name: widget.data[i].name,
                  overview: widget.data[i].overview,
                  date: widget.data[i].date,
                  rating: widget.data[i].voteAverage.toString())
            }
          ],
        ),
      ),
    );
  }
}
