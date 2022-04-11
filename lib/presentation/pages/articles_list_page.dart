import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interviewtask/domain/enitities/news_article.dart';
import 'package:interviewtask/presentation/bloc/news_article_bloc.dart';
import 'package:interviewtask/presentation/bloc/news_article_event.dart';
import 'package:interviewtask/presentation/bloc/news_article_state.dart';
import 'package:interviewtask/presentation/pages/article_details_page.dart';
import 'package:easy_localization/easy_localization.dart';

class ArticlesListPage extends StatefulWidget {
  final String languageCode;
  const ArticlesListPage({Key? key, required this.languageCode})
      : super(key: key);

  @override
  State<ArticlesListPage> createState() => _ArticlesListPageState();
}

class _ArticlesListPageState extends State<ArticlesListPage> {
  bool showLoading = false;
  ScrollController controller = ScrollController();
  List<NewsArticle> articles = [];

  // The key of the list
  final GlobalKey<AnimatedListState> _key = GlobalKey();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller.addListener(() {
      if (controller.position.atEdge) {
        if (controller.position.pixels != 0.0) {
          //controller is at bottom
          setState(() {
            showLoading = true;
            BlocProvider.of<NewsArticleBloc>(context)
                .add(const OnLoadNextPage());
          });
        }
      }
    });
    BlocProvider.of<NewsArticleBloc>(context).add(OnLoadNewsPage(
        pageNo: 0, pageSize: 12, languageCode: widget.languageCode));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewsArticleBloc, NewsArticlesState>(
      listener: (_, state) async {
        if (state is NewsArticlesHasData) {
          for (int i = 0; i < state.articles.length; i++) {
            await Future.delayed(const Duration(milliseconds: 100));
            articles.add(state.articles[i]);
            _key.currentState!
                .insertItem(i, duration: const Duration(milliseconds: 100));
          }
          setState(() {
            showLoading = false;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.deviceLocale.languageCode == "ar"
              ? "عناوين الاخبار"
              : "News Articles"),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  child: BlocBuilder<NewsArticleBloc, NewsArticlesState>(
                    buildWhen: (prev, next) =>
                        next is! NewsArticlesLoadingNextPageState,
                    builder: (_, state) {
                      if (state is NewsArticlesErrorState) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else if (state is NewsArticlesHasData) {
                        return AnimatedList(
                          key: _key,
                          controller: controller,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (_, index, animation) => InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ArticleDetails(
                                          article: articles[index])));
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.only(top: 16, bottom: 16),
                              child: ListTile(
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(40),
                                    ),
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(.5),
                                    ),
                                  ),
                                  child: Center(
                                    child: FittedBox(
                                      child: Text("$index"),
                                    ),
                                  ),
                                ),
                                title: Text(articles[index].name),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              Visibility(
                visible: showLoading,
                child: const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                    strokeWidth: 1,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
