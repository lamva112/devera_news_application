import 'package:card_swiper/card_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/articles_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/top_tending.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Utility/utils.dart';
import '../../consts/vars.dart';
import '../../models/news_model.dart';
import '../../provider/news_provider.dart';
import '../../widgets/empty_screen.dart';

class ExplorePage extends StatefulWidget {
  static const routeName = "/explore-page";

  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  var newsType = NewsType.topTrending;
  int currentPageIndex = 1;
  int pageSize = 5;
  String sortBy = SortByEnum.publishedAt.name;
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    final newsProvider = Provider.of<NewsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color),
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          'Trending',
          style: GoogleFonts.lobster(textStyle: TextStyle(color: color, fontSize: 20, letterSpacing: 0.6)),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<List<NewsModel>>(
            future: newsProvider.fetchTopHeadlines(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                  child: LoadingWidget(newsType: newsType),
                );
              } else if (snapshot.hasError) {
                return Expanded(
                  child: EmptyNewsWidget(
                    text: "an error occured ${snapshot.error}",
                    imagePath: 'assets/images/no_news.png',
                  ),
                );
              } else if (snapshot.data == null) {
                return const Expanded(
                  child: EmptyNewsWidget(
                    text: "No news found",
                    imagePath: 'assets/images/no_news.png',
                  ),
                );
              }
              return Center(
                child: SizedBox(
                        height: size.height * 0.7,
                        child: Swiper(
                          autoplayDelay: 7000,
                          autoplay: true,
                          itemWidth: size.width * 0.9,
                          layout: SwiperLayout.STACK,
                          viewportFraction: 0.9,
                          itemCount: snapshot.data?.length??0,
                          itemBuilder: (context, index) {
                            return ChangeNotifierProvider.value(
                              value: snapshot.data?[index],
                              child: const TopTrendingWidget(
                                  // url: snapshot.data![index].url,
                                  ),
                            );
                          },
                        ),
                      ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
