class Urls {
  static String newsUrl(int page, int size, String langCode) =>
      "https://bing-news-search1.p.rapidapi.com/news&count=$size&offset=${size * page}&setLang=$langCode&safeSearch=Off&textFormat=Raw";
}
