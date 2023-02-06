import 'package:flutter/material.dart';
import 'package:my_virtual_pet_collection/game/game_dao.dart';
import '../main.dart';
import 'game/game.dart';

// TODO: sort list alphabetically
// TODO: make it searchable (prefix)
class AddTrackedShellPage extends StatelessWidget {
  final List<Game> games;

  AddTrackedShellPage({super.key}) :
        games = _sortGames(getIt.get<GameDAO>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Game'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: games.length,
          prototypeItem: ListTile(
            title: Text(games.first.names.name())
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Card(
                child: ListTile(
                  title: Text(games[index].names.name()),
                ),
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => _ChooseShellScreen(games[index])
                  )
              ),
            );
          },
        )
      ),
    );
  }

  static List<Game> _sortGames(GameDAO gameDAO) {
    final result = List<Game>.from(gameDAO.gameList.games);
    result.sort((a, b) => a.names.name().compareTo(b.names.name()));
    return result;
  }
}

class _ChooseShellScreen extends StatelessWidget {
  final List<Shell> shells;
  final Game game;

  _ChooseShellScreen(this.game, {super.key}) :
        shells = _sortShells(game);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Shell'),
      ),
      body: Center(
          child: ListView.builder(
            itemCount: shells.length,
            prototypeItem: ListTile(
                title: Text(shells.first.names.name())
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                child: Card(
                  child: ListTile(
                    title: Text(shells[index].names.name()),
                  ),
                ),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => _AddShellDetailsScreen(game, shells[index])
                    )
                ),
              );
            },
          )
      ),
    );
  }

  static List<Shell> _sortShells(Game game) {
    final result = List<Shell>.from(game.shells);
    result.sort((a, b) => a.names.name().compareTo(b.names.name()));
    return result;
  }
}

class _AddShellDetailsScreen extends StatefulWidget {
  final Game game;
  final Shell shell;

  _AddShellDetailsScreen(this.game, this.shell, {super.key});

  @override
  State<StatefulWidget> createState() => _AddShellDetailsState();




}

class _AddShellDetailsState extends State<_AddShellDetailsScreen> {
  final nickController = TextEditingController();
  bool isCurrentlyOwned = true;


  @override
  void initState() {
    super.initState();
    nickController.text = widget.game.names.name();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Shell Details"),
      ),
      body: Column(
        children: [
          Text("Game: ${widget.game.names.name()}"),
          Text("Shell: ${widget.shell.names.name()}"),
          TextFormField(
            controller: nickController,
            decoration: const InputDecoration(
                labelText: "Nickname"
            ),
          ),
          Checkbox(
            value: isCurrentlyOwned,
            onChanged: (bool? value) {
              setState(() {
                isCurrentlyOwned = value!;
              });
            },
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                child: const Text('Save'),
                onPressed: () {/*TODO insert into Hive*/},
              )
            )
          )
        ],
      )
    );
  }

  @override
  void dispose() {
    nickController.dispose();
    super.dispose();
  }


}