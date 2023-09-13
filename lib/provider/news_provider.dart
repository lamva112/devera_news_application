import 'package:flutter/cupertino.dart';

import '../consts/vars.dart';
import '../models/news_model.dart';
import '../services/news_api.dart';


class NewsProvider with ChangeNotifier {
  List<NewsModel> _newsList = [];
  List<NewsModel> _trendingList = [];

  List<NewsModel> get getNewsList {
    return _newsList;
  }


  Future<List<NewsModel>> fetchAllNews(
      {required int pageIndex, required String sortBy,int pageSize = 5}) async {
    _newsList =
        await NewsAPiServices.getAllNews(page: pageIndex, sortBy: sortBy,pageSize: pageSize);

    return _newsList;
  }


  Future<List<NewsModel>> fetchTopHeadlines() async {
    _trendingList = await NewsAPiServices.getTopHeadlines();
    return _trendingList;
  }

  Future<List<NewsModel>> searchNewsProvider({required String query}) async {
    _newsList = await NewsAPiServices.searchNews(query: query);
    return _newsList;
  }

  NewsModel findByDate({required String? publishedAt})  {
    var combineList = _trendingList + _newsList;
    return  combineList
        .firstWhere((newsModel) => newsModel.publishedAt == publishedAt,orElse: () => _newsList[0]);
  }
}
