// ignore_for_file: file_names


abstract class HomeStates {}

class HomeIntialState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeSuccessState extends HomeStates {}

class HomeErrorState extends HomeStates {}

// ----------      -------------------
class CastLoadingState extends HomeStates {}

class CastSuccessState extends HomeStates {}

class CastErrorState extends HomeStates {}

// ----------      -------------------
class GenersLoadingState extends HomeStates {}

class GenersSuccessState extends HomeStates {}

class GenersErrorState extends HomeStates {}