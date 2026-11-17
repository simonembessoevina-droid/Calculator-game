# CALCULATOR GAME — projet Flutter de départ

Ce dossier contient une première base de code Flutter pour CALCULATOR GAME.

## Ce qui fonctionne déjà dans cette version
- Navigation entre les écrans principaux.
- Écran de jeu de démonstration.
- Chronomètre local de 30 secondes.
- Tirage aléatoire local entre 0,000 et 0,999.
- Écrans de départ pour salons, classement, discussion, profil et paramètres.

## Ce qui n'est PAS encore connecté
- Les comptes utilisateurs et authentification.
- Les salons privés réellement synchronisés.
- Le multijoueur en temps réel.
- Le chat en ligne et sa modération.
- La base de données, les sauvegardes et le classement partagé.
- La boutique et les transactions de CALCOINS.

Ces fonctions nécessitent un backend sécurisé (par exemple Firebase), des règles de sécurité et des tests. Les CALCOINS sont conçus comme monnaie virtuelle sans valeur réelle et sans mécanisme de mise ou de retrait.

## Ouvrir le projet
1. Installer Flutter et Android Studio.
2. Décompresser le dossier.
3. Dans un terminal, ouvrir le dossier `calculator_game_flutter`.
4. Exécuter `flutter pub get`.
5. Exécuter `flutter run` pour lancer l'application sur un appareil ou émulateur.

## Générer un APK Android
Dans le terminal :
`flutter build apk --release`

Le fichier APK sera généré dans :
`build/app/outputs/flutter-apk/app-release.apk`

Pour iPhone, une compilation iOS nécessite macOS et Xcode.
Pour le Web : `flutter build web`.

## Important
Ceci est une base de départ compilable, pas encore une version finale publiée ni un service multijoueur opérationnel.
