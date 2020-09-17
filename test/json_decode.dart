import 'dart:convert';

import 'package:drops/entities/story.dart';

var jsonStr = """[{"endpoint":"drops/stories","recordId":"a5a27a37-a117-4ca9-9905-723a074dcd74","data":{"title":"One day, far far away...","description":"It was a bright and sunny day."}},{"endpoint":"drops/stories","recordId":"c3537024-d49f-40b8-87c7-fe9d7dfab98f","data":{"title":"The Day Owl","description":"About the owl who couldnt sleep."}}]""";

var jwt = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhcHBsaWNhdGlvblZlcnNpb24iOiIwLjAuMiIsInN1YiI6IjEtRVp2d2lcL09ldnZxU2hxbkRcLzAzU2FyY1Q5QUdidE1UQjk0a1wvdE5JYmF6VExmUlBPNllnTDkrWWJIZm42MW8rSnE3MVdxNVZ5T05QOHJ6NjlTZkhKRGY1RDRDYU9LVnlhUDRVRFJsaHN5RTBVSzZGZ29vcldtUT09IiwiYXBwbGljYXRpb24iOiJsaXR0bGUtZHJvcHMtZGV2IiwiaXNzIjoidGVycnlsZWVoY2ZkZXYuaHViYXQubmV0IiwiZXhwIjoxNjAyNjQwNDQ1LCJpYXQiOjE2MDAwNDg0NDUsImp0aSI6ImI5MTgwYmIyYjU4ODA3YWIwZDVkZTM1ZmFlODk1MmM0NDM2N2VjMzE4NmZhMjczMmEyMjM2OTBhYTFkODRmZDMxZjFlMTRlNjBlM2YzZjdlZWMzMTVlYTk3OGI4NTg0MTIwYWFiMTU0ZjA1NTVhMWZlMTRiNmViMTI4Nzg1M2Y5ZGI0YjhmODMxZWViOTYyOGM4YTM4ZGI1NmQzNzFjNzQ0ZmMzYTE4ZWVkMTU3OWRkMmRkMzU2YzUxYzhiNTA0YmM3MTJkMjg4OWVhNmUxYWZmY2M2ZmZhNGZhNDUxYjlmZTgwOGNhMzFmYTdjZWRjZGM3NjhjZDlkZWY5MzFjZDMifQ.ajzni7DosH8vKdonWSSvo-8DF9UJ3CMQDwVI5H5z6X65qODgKir_F6YjXP29c5Spv8lLeLT_zZUQwck9cdDOM-IRNYbY4PMxqstvIAy185-TvpkYNrGmGEyumJiw5zWsp9f-IJdn3xkGjBO6LCrwrM1Sw-UgbAt0iJV51dg3O6eSVTrvhCDzbyoLeWlbj3CfU0qhGbWw5A5lbMjj9889MjZr8RWxES5o0ltsxKMTkUEsr2odMIhrhHjdxVHCTxeWwW7UKjCH0Hi-y98RPWLokSe';
void main() {
  Iterable jsonStories = json.decode(jsonStr);

  //print(jwt.split(".").length);
  //jwt.split(".").forEach((element) {print('$element');});
  List<Story> stories = jsonStories.map((e) => Story.fromJson(e)).toList();
  print(stories);
}