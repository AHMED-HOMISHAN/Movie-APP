// ignore_for_file: use_build_context_synchronously

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/components/components.dart';
import 'package:movieapp/components/constants.dart';
import 'package:movieapp/cubit/homeCubit.dart';
import 'package:movieapp/API/endPoints.dart';
import 'package:movieapp/states/homeStates.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  final int id;
  final String image;
  final String title;
  final String overView;
  final dynamic rating;
  final String date;
  const DetailScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.overView,
      required this.rating,
      required this.date,
      required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    HomeCubit.get(context).getTraileFromYoutubByID(widget.id);
    HomeCubit.get(context).getCastByID(widget.id);
    HomeCubit.get(context).getGenerBy(widget.id);
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: darkColor,
            body: SingleChildScrollView(
              child: Column(children: [
                Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: Image.network(
                        ORIGINALIMAGEPATH + widget.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6.0, 50, 2, 2),
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
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[800]),
                          child: Text(
                            '  ${widget.date} ',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        horizantelSpacing,
                        horizantelSpacing,
                        horizantelSpacing,
                        const Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: 20,
                        ),
                        Text(
                          ' ${widget.rating.toString()} ',
                          style: const TextStyle(
                              color: Colors.amber,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                      verticalSpacing,
                      InkWell(
                        onTap: () async {
                          try {
                            await launchUrl(Uri.parse(
                                'https://www.youtube.com/embed/${HomeCubit.get(context).traile.toString()}'));
                          } catch (error) {
                            messanger(
                                context: context,
                                message: 'It is not avaliable',
                                status: false);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.play_arrow_rounded,
                                  color: Colors.white,
                                ),
                                Text('PLAY',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold))
                              ]),
                        ),
                      ),
                      verticalSpacing,
                      Text(widget.overView,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          )),
                      verticalSpacing,
                      ConditionalBuilder(condition: (state is! GenersLoadingState), builder: (context)=>SizedBox(
                        height: 35,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: primaryColorAccent),
                            child: Center(
                              child: Text(
                                '  ${HomeCubit.get(context).generModel!.name[index]} ',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          itemCount:
                              HomeCubit.get(context).generModel!.name.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(
                            width: 10,
                          ),
                        ),
                      ), fallback: (context)=> const Center(child: CircularProgressIndicator())),
                      verticalSpacing,
                      ConditionalBuilder(
                          condition: (state is! CastLoadingState),
                          builder: (context) {
                            return castList(
                                profileImage:
                                    HomeCubit.get(context).cast!.image);
                          },
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()))
                    ],
                  ),
                )
              ]),
            ),
          );
        },
        listener: (context, state) {});
  }
}
