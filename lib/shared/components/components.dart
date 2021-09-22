import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/modules/web_view/webview_screen.dart';

Widget build_list_articles({required List articles}) => ListView.separated(
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(3.0),
        child: Divider(
          color: Colors.grey,
        ),
      ),
      itemCount: articles.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebViewScreen(
                url: articles[index]['url'],
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    articles[index]['urlToImage'] ??
                        'https://www.kenyons.com/wp-content/uploads/2017/04/default-image-720x530.jpg',
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            articles[index]['title'].toString(),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(
                                articles[index]['publishedAt'])) ??
                            '',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
