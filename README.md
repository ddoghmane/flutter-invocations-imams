📿 Invocations des Imams
Application Flutter permettant de consulter des invocations spirituelles de plusieurs imams et cheikhs.

L'application propose les invocations en arabe, en phonétique et en français à travers une interface sombre inspirée de l'univers spirituel et mystique.

✨ Fonctionnalités
✅ Liste de plusieurs imams

✅ Consultation des invocations

✅ Texte arabe

✅ Transcription phonétique

✅ Traduction française

✅ Interface sombre personnalisée

✅ Navigation entre les différentes pages

🛠 Technologies utilisées
Frontend
Flutter
Dart
Material Design
Backend
Node.js
Express.js
Base de données
MongoDB

📂 Structure des données
Chaque invocation est stockée sous la forme suivante :

{
  "imam": "Nom de l'imam",
  "arabe": "النص العربي",
  "phonetique": "Texte phonétique",
  "francais": "Traduction française"
}

🔄 Architecture du projet
Flutter
    ↓
API Node.js / Express
    ↓
MongoDB
Flutter affiche les données.
Node.js fournit l'API.
MongoDB stocke les invocations.

🚀 Installation
Cloner le projet
git clone https://github.com/ddoghmane/flutter-invocations-imams.git
Frontend Flutter
flutter pub get
flutter run
Backend Node.js
npm install
npm start

📸 Captures d'écran
Accueil
Ajouter une capture d'écran ici

Liste des invocations
Ajouter une capture d'écran ici

🎯 Objectifs du projet
Ce projet m'a permis de découvrir :

Flutter
Dart
MongoDB
Node.js
Git et GitHub
Le développement mobile multiplateforme

👨‍💻 Auteur
Daoud Doghmane

Projet personnel réalisé dans le cadre de l'apprentissage du développement mobile et du développement full stack.

GitHub : https://github.com/ddoghmane

📜 Licence
Projet éducatif à but non commercial.
