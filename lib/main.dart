import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interviewtask/presentation/bloc/news_article_bloc.dart';
import 'injection.dart' as di;

import 'presentation/pages/articles_list_page.dart';

void main() async {
  di.init();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        path: 'assets/translations',
        useOnlyLangCode: true,
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsArticleBloc>(
      create: (_) => di.locator<NewsArticleBloc>(),
      child: MaterialApp(
        title: 'InterView Task',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ArticlesListPage(
          languageCode: context.deviceLocale.languageCode,
        ),
      ),
    );
  }
}
