import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/statless.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('News'),
            actions: [
              IconButton(
                icon: Icon(Icons.brightness_4_outlined),
                onPressed: () {
                  cubit.toggleTheme();
                },
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          body: cubit.list_screens[cubit.index_screen],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottomScreen(index);
            },
            currentIndex: AppCubit.get(context).index_screen,
            items: cubit.navigationItems,
          ),
        );
      },
    );
  }
}
