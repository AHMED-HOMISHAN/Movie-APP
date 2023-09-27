import 'package:flutter/material.dart';
import 'package:movieapp/components/constants.dart';
import 'package:movieapp/API/endPoints.dart';
import 'package:movieapp/screens/detailScreen.dart';
import 'package:movieapp/screens/displayAllScreen.dart';

Future<dynamic> navigateAndfinished(BuildContext context, Widget screen) {
  return Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => screen));
}

Future<dynamic> navigateTo(BuildContext context, Widget screen) {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => screen));
}

Widget defaultButton(
    {required double width,
    required Function() function,
    required String label,
    Color buttonColor = primaryColorAccent,
    Color textColor = Colors.white,
    double radius = 8.0}) {
  return Container(
      width: width,
      decoration: BoxDecoration(
          color: buttonColor, borderRadius: BorderRadius.circular(radius)),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          label,
          style: TextStyle(
              color: textColor, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ));
}

messanger(
    {required BuildContext context,
    required String message,
    bool status = true}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    behavior: SnackBarBehavior.floating,
    backgroundColor: status ? primaryColor : Colors.redAccent,
  ));
}

Widget movieCard({
  double? width,
  double? height,
  required String image,
  required BuildContext context,
  String? name,
  int? id,
  String? overview,
  String? date,
  String? rating,
  bool isTitle = true,
}) {
  return InkWell(
    onTap: () {
      navigateTo(
          context,
          DetailScreen(
            id: id!,
            image: image,
            title: name!,
            overView: overview!,
            rating: rating,
            date: date!,
          ));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: width ?? 200,
        height: height ?? 280,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  SizedBox(
                    height: 350,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image: NetworkImage(ORIGINALIMAGEPATH + image),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  !isTitle
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                                color: darkColor,
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(10))),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '$rating ',
                                  style: const TextStyle(
                                      color:
                                          Color.fromARGB(255, 255, 242, 202)),
                                ),
                                const Icon(
                                  Icons.star,
                                  color: Color.fromARGB(255, 255, 242, 202),
                                )
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            !isTitle
                ? Text(
                    '$name ',
                    style: const TextStyle(color: Colors.white),
                  )
                : const SizedBox()
          ],
        ),
      ),
    ),
  );
}

Widget movieList({
  required String title,
  required List data,
  required BuildContext context,
}) {
  return Column(
    children: [
      Row(
        children: [
          horizantelSpacing,
          horizantelSpacing,
          Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const Spacer(),
          TextButton(
              onPressed: () {
                navigateTo(
                    context,
                    DisplayAllMovieScreen(
                      title: title,
                      data: data,
                    ));
              },
              child: const Text('See All'))
        ],
      ),
      SizedBox(
          height: 240,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return movieCard(
                    width: 150,
                    height: 250,
                    id: data[index].id,
                    image: data[index].image,
                    date: data[index].date,
                    overview: data[index].overview,
                    name: data[index].name,
                    rating: data[index].voteAverage.toString(),
                    isTitle: false,
                    context: context);
              },
              itemCount: data.length)),
    ],
  );
}

Widget castList({
  required List profileImage,
}) {
  return SizedBox(
    height: 200,
    child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Column(
              children: [
                CircleAvatar(
                  maxRadius: 40,
                  backgroundImage: NetworkImage(
                    ORIGINALIMAGEPATH + profileImage[index].toString(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
        separatorBuilder: (context, index) => const SizedBox(
              width: 15,
            ),
        itemCount: profileImage.length),
  );
}
