import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/statless.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var articles = AppCubit.get(context).list_search;
        return Scaffold(
          appBar: AppBar(
            title: Text('Search'),
          ),
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'search key should be not empty';
                    }
                    return null;
                  },
                  onChanged: (String? value) {
                    //  searchController.text = value;
                    AppCubit.get(context).getSearchData(value!);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    labelText: 'Search',
                  ),
                ),
                Expanded(
                  child: build_list_articles(
                    articles: articles,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
