import 'package:flutter/material.dart';
import '../models/character.dart';
import '../services/characters_api.dart';

class CharactersList extends StatefulWidget {
  final String filter;

  const CharactersList({super.key, required this.filter});

  @override
  State<CharactersList> createState() => _CharactersListState();
}

class _CharactersListState extends State<CharactersList> {
  CharactersApi api = CharactersApi();

  late List<Character> _characters;
  late List<Character> _charactersFiltered;

  @override
  void initState() {
    super.initState();
    _fetchCharacters();
  }

  Future<List<Character>> _fetchCharacters() async {
    _characters = await api.fetchCharacters();
    _charactersFiltered = _characters;
    return _characters;
  }

  @override
  void didUpdateWidget(covariant CharactersList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.filter != widget.filter) {
      _filterCharacters(widget.filter);
    }
  }

  _filterCharacters(String filter) {
    setState(() {
      _charactersFiltered = _characters
          .where((item) => item.name.toLowerCase().contains(filter.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Character>>(
      future: api.fetchCharacters(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Duas colunas
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75, // Manter a altura proporcional ao tamanho
                ),
                itemCount: _charactersFiltered.length,
                itemBuilder: (context, index) {
                  var character = _charactersFiltered[index];

                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Stack(
                        children: [
                          // Imagem como fundo
                          Positioned.fill(
                            child: Image.network(
                              character.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Texto sobre a imagem
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              color: Colors.black.withOpacity(0.6), // Fundo semitransparente
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    character.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,

                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Espécie: ${character.species}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Status: ${character.status}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: character.status == "Alive"
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }

        return const Center(child: Text('Erro ao carregar os dados.'));
      },
    );
  }
}
