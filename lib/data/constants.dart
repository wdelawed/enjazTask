class Urls {
  static String newsUrl(int page, int size, String langCode) =>
      "http://rapidapi.com/news?count=$size&offset=${size * page}&setLang=$langCode&safeSearch=Off&textFormat=Raw";
  static final headers = {
    "X-Bingapis-Sdk": "true",
    "X-Rapidapi-Host": "bing-news-search1.p.rapidapi.com",
    "X-Rapidapi-Key": "f687dab62fmshc171d898406e172p109811jsn83513c078041",
    "Host": "bing-news-search1.p.rapidapi.com"
  };
}
