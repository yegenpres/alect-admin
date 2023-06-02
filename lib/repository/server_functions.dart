// type Query {
// echo(msg: String): String @function(name: "testApi-${env}")
// }
//
// type Mutation {
// add(number1: Int, number2: Int): Int @function(name: "adding-${env}")
// }

import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';

final class ServerFunction {
  static const _queryes = GraphQLQueryes();

  static Future<String> askGPT({required String text}) async {
    final res = await Amplify.API
        .query(request: GraphQLRequest(document: _queryes.chatGPT(text)))
        .response;
    final {'chatCPTQuery': chatOutput} = jsonDecode(res.data);

    return chatOutput;
  }

  static Future<String> base64soundDK({required String word}) async {
    final res = await Amplify.API
        .query(request: GraphQLRequest(document: _queryes.base64sound(word)))
        .response;

    final {'makeWordSound': output} = jsonDecode(res.data);

    return output;
  }

  static Future<String> saveDKSound(
      {required String text, required String path}) async {
    final res = await Amplify.API
        .query(
            request: GraphQLRequest(document: _queryes.saveSound(text, path)))
        .response;

    final {'makeTextAudio': output} = jsonDecode(res.data);

    return output;
  }
}

base class GraphQLQueryes {
  String chatGPT(String text) => '''
query chatCPTQuery {
  chatCPTQuery(text: "$text")
}
''';

  String base64sound(String word) => '''
   query makeWordSound {
    makeWordSound(word: "$word")
   }
   ''';

  String saveSound(String text, path) => '''
  query makeTextAudio {
    makeTextAudio(text: "$text", path: "$path")
  }
  ''';
  const GraphQLQueryes();
}
