import 'package:http/http.dart' as http;

Future GetChords (url) async {
  print(url);
  String newUrl = url.toString();
  http.Response Response = await http.get(Uri.parse(newUrl));

  return Response.body;

}