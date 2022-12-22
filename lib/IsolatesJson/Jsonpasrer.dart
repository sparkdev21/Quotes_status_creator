// class UserModelParser{
// final String encodeJson;
// UserModelParser({required this.encodeJson});

// Future<List<UserModel>> fetchInBackground(String encodeJson)async{
//  final port = ReceivePort();
//  await Isolate.spawn(_parseListOfJson,port.sendPort);
//  return await port.first;
// }

// List<void> _parseListOfJson(SendPort port){
//   final json = jsonDecode(encodeJson);
//   final result = json['data'] as List<dynamic>;
//   final listOfResults = result.map((data)=>UserModel.fromJson(data)).toList();
//   Isolate.exit(port,listOfResults);
//  }
// }


// class APIServices{
// Future<List<UserModel>> downloadAndParseJson()async{
//   final response = await http.get(Uri.parse(GET_URL));
//   if(response.statusCode == 200){
//     final userModelParser = UserModelParser();
//     return userModelParser.fetchInBackground(response.body);
//   }
//   else{
//     throw Exception('Failed to fetch data from the API');
//   }
//  }
// }