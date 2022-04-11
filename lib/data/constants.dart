class Urls {
  static String newsUrl(int page, int size, String langCode) =>
      "http://rapidapi.com/news?count=$size&offset=${size * page}&setLang=$langCode&safeSearch=Off&textFormat=Raw";
}
