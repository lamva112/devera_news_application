import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Utility/utils.dart';
import '../../consts/vars.dart';
import '../../models/news_model.dart';
import '../../provider/news_provider.dart';
import '../../widgets/articles_widget.dart';
import '../../widgets/empty_screen.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/tabs.dart';
import '../../widgets/top_tending.dart';
import '../../widgets/vertical_spacing.dart';

class HomeTabPage extends StatefulWidget {
  static const routeName = "/home-tab-page";

  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  var newsType = NewsType.allNews;
  int currentPageIndex = 1;
  int pageSize = 5;
  String sortBy = SortByEnum.publishedAt.name;

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    final newsProvider = Provider.of<NewsProvider>(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          iconTheme: IconThemeData(color: color),
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: Text(
            'News',
            style: GoogleFonts.lobster(textStyle: TextStyle(color: color, fontSize: 30, letterSpacing: 0.6)),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                IconlyLight.search,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(
              children: [
                const Expanded(
                    child: Text(
                  "All news",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                )),
                IconButton(
                  onPressed: () {
                    _showFilterBottomSheet(context);
                  },
                  icon: const Icon(
                    IconlyLight.filter,
                  ),
                )
              ],
            ),
            const VerticalSpacing(10),
            Align(
              alignment: Alignment.topRight,
              child: Material(
                color: Theme.of(context).cardColor,
                child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: Container()),
              ),
            ),
            FutureBuilder<List<NewsModel>>(
                future: newsProvider.fetchAllNews(pageIndex: currentPageIndex, sortBy: sortBy, pageSize: pageSize),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingWidget(newsType: newsType);
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
                  return Expanded(
                    child: ListView.builder(
                        controller: _scrollController,
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (ctx, index) {
                          return ChangeNotifierProvider.value(
                            value: snapshot.data?[index],
                            child:  ArticlesWidget(),
                          );
                        }),
                  );
                })),
          ]),
        ),
      ),
    );
  }


  Widget paginationButtons({required Function function, required String text}) {
    return ElevatedButton(
      onPressed: () {
        function();
      },
      child: Text(text),
      style: ElevatedButton.styleFrom(
          primary: Colors.blue, padding: EdgeInsets.all(6), textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
        side: BorderSide(color: Colors.grey, width: 1.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(
            height: 12,
          ),
          ...List.generate(
            SortByEnum.values.length,
            (index) => Material(
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    sortBy = SortByEnum.values[index].name;
                  });
                },
                child: Ink(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(16),
                    child: Text(toBeginningOfSentenceCase(SortByEnum.values[index].name)??""),
                  ),
                ),
              ),
            ),
          ),
        ]);
      },
    );
  }
}
