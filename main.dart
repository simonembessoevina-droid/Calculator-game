import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const CalculatorGameApp());

const gold = Color(0xFFFFC928);
const ink = Color(0xFF101114);

class CalculatorGameApp extends StatelessWidget {
  const CalculatorGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CALCULATOR GAME',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF090A0D),
        colorScheme: ColorScheme.fromSeed(seedColor: gold, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: const GameShell(),
    );
  }
}

class GameShell extends StatefulWidget {
  const GameShell({super.key});
  @override
  State<GameShell> createState() => _GameShellState();
}

class _GameShellState extends State<GameShell> {
  int tab = 0;
  int wins = 0;
  int losses = 0;
  int coins = 750;
  String result = '— — —';
  int seconds = 30;
  Timer? timer;
  bool turnActive = false;
  final random = Random.secure();

  final pages = const ['Accueil', 'Jouer', 'Salons privés', 'Classement', 'Discussion', 'Mon profil', 'Paramètres'];

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTurn() {
    timer?.cancel();
    setState(() {
      seconds = 30;
      turnActive = true;
      result = 'En attente…';
    });
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds <= 1) {
        t.cancel();
        setState(() {
          seconds = 0;
          turnActive = false;
          result = 'Temps écoulé';
        });
      } else {
        setState(() => seconds--);
      }
    });
  }

  void drawNumber() {
    if (!turnActive) return;
    timer?.cancel();
    final value = random.nextInt(1000);
    setState(() {
      result = '0.${value.toString().padLeft(3, '0')}';
      turnActive = false;
      seconds = 30;
    });
  }

  Widget panel({required Widget child}) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: ink,
      border: Border.all(color: gold.withOpacity(.8), width: 1.3),
      borderRadius: BorderRadius.circular(18),
    ),
    child: child,
  );

  Widget action(String label, IconData icon, VoidCallback onTap) => SizedBox(
    width: double.infinity,
    child: FilledButton.icon(
      style: FilledButton.styleFrom(
        backgroundColor: gold,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 15),
      ),
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    ),
  );

  Widget homePage() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('CALCULATOR GAME', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900, color: gold)),
    const Text('Calculate. Compete. Win.', style: TextStyle(color: Colors.white70)),
    const SizedBox(height: 20),
    panel(child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Bienvenue dans l’arène !', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Joue à tour de rôle, obtiens le meilleur résultat et remporte la partie.'),
    ])),
    const SizedBox(height: 16),
    ...[
      ('JOUER', Icons.play_arrow, 1),
      ('SALONS PRIVÉS', Icons.groups, 2),
      ('CLASSEMENT', Icons.emoji_events, 3),
      ('DISCUSSION', Icons.chat, 4),
      ('MON PROFIL', Icons.person, 5),
    ].map((item) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: action(item.$1, item.$2, () => setState(() => tab = item.$3)),
    )),
  ]);

  Widget gamePage() => Column(children: [
    panel(child: Column(children: [
      const Text('PARTIE EN COURS', style: TextStyle(color: gold, fontSize: 20, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      const Text('Joueur actuel : GastonEvina'),
      const SizedBox(height: 8),
      Text('$seconds secondes', style: const TextStyle(fontSize: 25, color: gold, fontWeight: FontWeight.bold)),
      const SizedBox(height: 12),
      Text(result, style: const TextStyle(fontSize: 38, fontWeight: FontWeight.w900)),
      const SizedBox(height: 12),
      action('Commencer mon tour (30 s)', Icons.timer, startTurn),
      const SizedBox(height: 8),
      action('SECONDE FONCTION + POINT', Icons.calculate, drawNumber),
      const SizedBox(height: 8),
      const Text('Démo locale : le tirage est aléatoire entre 0,000 et 0,999.', style: TextStyle(color: Colors.white60)),
    ])),
    const SizedBox(height: 14),
    panel(child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Joueurs', style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 18)),
      ListTile(leading: CircleAvatar(child: Text('G')), title: Text('GastonEvina'), subtitle: Text('À son tour')),
      ListTile(leading: CircleAvatar(child: Text('A')), title: Text('AstroGame'), subtitle: Text('En attente')),
    ])),
  ]);

  Widget genericPage() {
    final content = switch (tab) {
      2 => ('Salons privés', 'Créer un salon ou rejoindre une partie avec un code. Le créateur choisit 2 à 5 joueurs et un seuil minimum de CALCOINS. Les CC ne sont pas débités à l’entrée.'),
      3 => ('Classement général', 'Le classement général est basé uniquement sur le nombre de victoires.'),
      4 => ('Discussion générale', 'Les joueurs pourront échanger et partager des codes de salons. Les outils de signalement et de modération seront nécessaires.'),
      5 => ('Mon profil', 'Pseudo : GastonEvina\nVictoires : $wins\nDéfaites : $losses\nCALCOINS : $coins CC'),
      6 => ('Paramètres', 'Langue : Français / English\nApparence : Clair / Sombre\nSon, notifications, confidentialité et sécurité.'),
      _ => ('Accueil', 'Bienvenue dans CALCULATOR GAME.'),
    };
    return panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(content.$1, style: const TextStyle(fontSize: 23, color: gold, fontWeight: FontWeight.bold)),
      const SizedBox(height: 14),
      Text(content.$2, style: const TextStyle(fontSize: 16, height: 1.5)),
      if (tab == 2) ...[
        const SizedBox(height: 18),
        action('Créer un salon (démo)', Icons.add, () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('La création en ligne sera connectée au serveur.')))),
        const SizedBox(height: 8),
        action('Rejoindre avec un code', Icons.login, () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('La vérification du code sera connectée au serveur.')))),
      ],
    ]));
  }

  @override
  Widget build(BuildContext context) {
    final body = tab == 0 ? homePage() : tab == 1 ? gamePage() : genericPage();
    return Scaffold(
      appBar: AppBar(
        title: const Text('CALCULATOR GAME', style: TextStyle(fontWeight: FontWeight.w900, color: gold)),
        actions: [Padding(padding: const EdgeInsets.only(right: 16), child: Center(child: Text('$coins CC')))],
      ),
      drawer: Drawer(
        child: ListView(children: [
          const DrawerHeader(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [
            Text('CALCULATOR GAME', style: TextStyle(color: gold, fontSize: 22, fontWeight: FontWeight.bold)),
            Text('Calculate. Compete. Win.'),
          ])),
          for (var i = 0; i < pages.length; i++)
            ListTile(
              leading: Icon([Icons.home, Icons.play_arrow, Icons.groups, Icons.emoji_events, Icons.chat, Icons.person, Icons.settings][i]),
              title: Text(pages[i]),
              selected: tab == i,
              onTap: () { setState(() => tab = i); Navigator.pop(context); },
            ),
        ]),
      ),
      body: SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.all(16), child: body)),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab > 4 ? 0 : tab,
        onDestinationSelected: (i) => setState(() => tab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Accueil'),
          NavigationDestination(icon: Icon(Icons.play_arrow), label: 'Jouer'),
          NavigationDestination(icon: Icon(Icons.groups), label: 'Salons'),
          NavigationDestination(icon: Icon(Icons.emoji_events), label: 'Rang'),
          NavigationDestination(icon: Icon(Icons.chat), label: 'Chat'),
        ],
      ),
    );
  }
}
