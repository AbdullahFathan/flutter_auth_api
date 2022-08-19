import 'package:login_api/models/quotes.dart';
import 'package:http/http.dart' as http;

class QuotesServices {
  final _client = http.Client();

  Future getListRandom() async {
    var uri = Uri.parse('https://animechan.vercel.app/api/quotes');

    try {
      var response = await _client.get(uri);
      if (response.statusCode == 200) {
        var data = quotesFromJson(response.body);
        return data;
      } else {
        print("response getListRandom fail [quotes_repository.dart]");
      }
    } catch (eror) {
      throw Exception(eror.toString());
    }
    return null;
  }
}
