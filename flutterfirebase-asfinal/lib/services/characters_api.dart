import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projetoflutterapi/models/character.dart';

class CharactersApi {
  Future<List<Character>> fetchCharacters() async {
    final response = await http.get(Uri.parse('https://rickandmortyapi.com/api/character'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)["results"];
      return jsonResponse.map((item) => Character.fromJson(item)).toList(); // Usando fromJson
    } else {
      throw Exception("Erro na busca");
    }
  }
}
