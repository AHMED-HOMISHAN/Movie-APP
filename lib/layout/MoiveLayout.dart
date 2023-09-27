// ignore_for_file: file_names, prefer_is_empty

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/components/components.dart';
import 'package:movieapp/components/constants.dart';
import 'package:movieapp/cubit/homeCubit.dart';
import 'package:movieapp/states/homeStates.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MovieLayout extends StatelessWidget {
  const MovieLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var sliderModel = HomeCubit.get(context).sliderModel;
          var discoverModel = HomeCubit.get(context).discoverModel;
          var topModel = HomeCubit.get(context).topModel;
          var upComingModel = HomeCubit.get(context).upComingModel;
          var popularModel = HomeCubit.get(context).popularModel;

          return Scaffold(
              appBar: AppBar(
                title: const Text('Movie APP'),
              ),
              backgroundColor: darkColor,
              body: ConditionalBuilder(
                  condition: (state is! HomeLoadingState &&
                      sliderModel?.banners.length != null),
                  builder: (context) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          verticalSpacing,
                          SizedBox(
                              height: 280,
                              child: CarouselSlider(
                                items: sliderModel!.banners
                                    .map(
                                      (e) => movieCard(
                                        image: e.image,
                                        date: e.date,
                                        overview: e.overview,
                                        id: e.id,
                                        rating: e.voteAverage.toString(),
                                        name: e.name,
                                        context: context,
                                      ),
                                    )
                                    .toList(),
                                options: CarouselOptions(
                                    height: 280.0,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    viewportFraction: 0.54,
                                    autoPlay: true,
                                    autoPlayInterval:
                                        const Duration(seconds: 6),
                                    autoPlayAnimationDuration:
                                        const Duration(seconds: 2),
                                    aspectRatio: 2.0,
                                    enlargeCenterPage: true,
                                    enlargeStrategy:
                                        CenterPageEnlargeStrategy.height,
                                    scrollDirection: Axis.horizontal),
                              )),
                          verticalSpacing,
                          movieList(
                              title: 'Top Rated',
                              data: discoverModel!.discover,
                              context: context),
                          verticalSpacing,
                          movieList(
                              title: 'Lateset Movies',
                              data: topModel!.discover,
                              context: context),
                          verticalSpacing,
                          movieList(
                              title: 'Popular Movies',
                              data: popularModel!.discover,
                              context: context),
                          verticalSpacing,
                          movieList(
                              title: 'Upcoming Movies',
                              data: upComingModel!.discover,
                              context: context),
                          verticalSpacing,
                          verticalSpacing,
                        ],
                      ),
                    );
                  },
                  fallback: (context) =>
                      const Center(child: CircularProgressIndicator())));
        });
  }
}
