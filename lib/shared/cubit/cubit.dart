import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business_news/business_screen.dart';
import 'package:news_app/modules/science_news/science_screen.dart';
import 'package:news_app/modules/sport_news/sport_screen.dart';
import 'package:news_app/shared/cubit/statless.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  List list_screens = [
    SportScreen(),
    ScienceScreen(),
    BusinessScreen(),
  ];
  List titles = ['business', 'sciences', 'sports', 'settings'];
  int index_screen = 0;
  bool isDark = false;

  List<BottomNavigationBarItem> navigationItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Sciences',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
  ];
  void changeBottomScreen(int index) {
    index_screen = index;
    emit(AppChangeBottomNavState());
  }

  var list_sports = [];
  var list_sciences = [];
  var list_business = [];
  var list_search = [];

  getSportData() {
    DioHelper()
      ..getData(url: 'v2/top-headlines', query: {
        'country': 'ma',
        'apiKey': '99b9f8227da74801adea3956154c3254',
        'category': 'sport'
      }).then((value) {
        list_sports = value.data['articles'];
        emit(AppGetSportState());
      });
  }

  getScienceData() {
    DioHelper()
      ..getData(url: 'v2/top-headlines', query: {
        'country': 'ma',
        'apiKey': '99b9f8227da74801adea3956154c3254',
        'category': 'science'
      }).then((value) {
        list_sciences = value.data['articles'];
        emit(AppGetScienceState());
      });
  }

  getBusinessData() {
    DioHelper()
      ..getData(url: 'v2/top-headlines', query: {
        'country': 'ma',
        'apiKey': '99b9f8227da74801adea3956154c3254',
        'category': 'business'
      }).then((value) {
        list_business = value.data['articles'];
        emit(AppGetBusinessState());
      });
  }

  getSearchData(String keyword) {
    DioHelper()
      ..getData(url: 'v2/everything', query: {
        'apiKey': '99b9f8227da74801adea3956154c3254',
        'q': keyword,
      }).then((value) {
        list_search = value.data['articles'];
        emit(AppGetSearchState());
      }).catchError(
        (onError) => emit(
          AppErrorSearchState(),
        ),
      );
  }

  void toggleTheme({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      return;
    }
    isDark = !isDark;
    CacheHelper.putBool(key: 'isDark', value: isDark)
        .then((value) => emit(AppChangeThemeState()));
  }
}
