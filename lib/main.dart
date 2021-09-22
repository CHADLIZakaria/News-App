import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc_observer.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/statless.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

import 'layout/home_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBool(key: "isDark") ?? false;

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()
            ..getSportData()
            ..getScienceData()
            ..getBusinessData()
            ..toggleTheme(fromShared: isDark),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) => {},
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Color(0xffefefef),
            appBarTheme: AppBarTheme(
              textTheme: TextTheme(
                title: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
              iconTheme: IconThemeData(
                color: Colors.black,
                size: 23,
              ),
              backgroundColor: Color(0xffd3d3d3),
              centerTitle: false,
              elevation: 40,
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Color(0xffefefef),
              selectedItemColor: Colors.black87,
              unselectedItemColor: Colors.grey,
              elevation: 20,
            ),
            textTheme: TextTheme(
              headline4: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              headline6: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          darkTheme: ThemeData(
            scaffoldBackgroundColor: Color(0xff1f1f1f),
            appBarTheme: AppBarTheme(
                backgroundColor: Color(0xff3f3f3f),
                centerTitle: false,
                elevation: 40,
                textTheme: TextTheme(
                  title: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                )),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Color(0xff3f3f3f),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
            ),
            textTheme: TextTheme(
              headline4: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              headline6: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          themeMode:
              AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          home: HomeLayout(),
        ),
      ),
    );
  }
}
