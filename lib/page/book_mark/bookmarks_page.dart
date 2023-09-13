import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Utility/utils.dart';
import '../../consts/vars.dart';
import '../../models/bookmarks_model.dart';
import '../../provider/bookmarks_provider.dart';
import '../../widgets/articles_widget.dart';
import '../../widgets/empty_screen.dart';
import '../../widgets/loading_widget.dart';

class BookmarkPage extends StatefulWidget {
  static const routeName = "/bookmark-page";
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          'Bookmarks',
          style: GoogleFonts.lobster(textStyle: TextStyle(color: color, fontSize: 20, letterSpacing: 0.6)),
        ),
      ),
      body: Column(
        children: [
          FutureBuilder<List<BookmarksModel>>(
            future: Provider.of<BookmarksProvider>(context, listen: false).fetchBookmarks(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingWidget(newsType: NewsType.allNews);
              } else if (snapshot.hasError) {
                return Expanded(
                  child: EmptyNewsWidget(
                    text: "an error occurred ${snapshot.error}",
                    imagePath: 'assets/images/no_news.png',
                  ),
                );
              } else if (!snapshot.hasData) {
                return const EmptyNewsWidget(
                  text: 'You didn\'t add anything yet to your bookmarks',
                  imagePath: "assets/images/bookmark.png",
                );
              }
              return Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (ctx, index) {
                      return ChangeNotifierProvider.value(
                          value: snapshot.data?[index],
                          child: const ArticlesWidget(
                            isBookmark: true,
                          ));
                    }),
              );
            }),
          ),
        ],
      ),
    );
  }
}
