// ignore_for_file: file_names, avoid_function_literals_in_foreach_calls

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/models/MovieModel.dart';
import 'package:movieapp/API/API.dart';
import 'package:movieapp/API/endPoints.dart';
import 'package:movieapp/states/homeStates.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeIntialState());
  static HomeCubit get(context) => BlocProvider.of(context);
  MovieSliderModel? sliderModel;
  MovieDiscoverModel? discoverModel;
  MovieDiscoverModel? topModel;
  MovieDiscoverModel? popularModel;
  MovieDiscoverModel? upComingModel;
  GenerModel? generModel;
  String traile = '';
  CastModel? cast;

  void getHomeData() {
    emit(HomeLoadingState());

    DioHelper.getDate(url: DISCOVER).then((value) {
      discoverModel = MovieDiscoverModel.fromJson(value.data);
    });

    DioHelper.getDate(
      url: TRENDING,
    ).then((value) {
      sliderModel = MovieSliderModel.fromJson(value.data);
    });

    DioHelper.getDate(url: TOPMOVIES).then((value) {
      topModel = MovieDiscoverModel.fromJson(value.data);
    });

    DioHelper.getDate(url: POPULAR).then((value) {
      popularModel = MovieDiscoverModel.fromJson(value.data);
    });

    DioHelper.getDate(url: UPCOMING).then((value) {
      upComingModel = MovieDiscoverModel.fromJson(value.data);
      emit(HomeSuccessState());
    }).catchError((error) {
      emit(HomeErrorState());
    });
  }

  getTraileFromYoutubByID(int id) {
    DioHelper.getDate(url: 'movie/$id/videos').then((value) {
      traile = value.data['results'][0]['key'].toString();
    }).catchError((error) {
      print(error);
    });
  }

  getCastByID(int id) {
    emit(CastLoadingState());
    DioHelper.getDate(url: 'movie/$id/credits').then((value) {
      cast = CastModel.fromJson(value.data);
      emit(CastSuccessState());
    }).catchError((error) {
      print(error);
    });
  }

  getGenerBy(id) {
    emit(GenersLoadingState());
    DioHelper.getDate(url: 'movie/$id').then((value) {
      generModel = GenerModel.fromJson(value.data);
      emit(GenersSuccessState());
    }).catchError((onError) {
      print(onError.toString());
    });
  }
}
