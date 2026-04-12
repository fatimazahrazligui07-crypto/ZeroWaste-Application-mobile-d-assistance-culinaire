# Guide : Tester votre application Flutter sur votre téléphone

Ce guide vous explique comment tester votre application **ZeroWaste** directement sur votre smartphone physique en mode développeur.

## 1. Préparer votre téléphone (Android)

1.  Allez dans les **Paramètres** de votre téléphone.
2.  Allez dans **À propos du téléphone**.
3.  Appuyez **7 fois** sur le **Numéro de build** (ou Version MIUI/EMUI selon votre marque) jusqu'à ce que le message "Vous êtes maintenant développeur" apparaisse.
4.  Revenez en arrière et cherchez **Options pour les développeurs** (souvent dans *Système* ou *Paramètres supplémentaires*).
5.  Activez l'option **Débogage USB**.

## 2. Connecter le téléphone à l'ordinateur

1.  Branchez votre téléphone à votre ordinateur via un câble USB de bonne qualité.
2.  Sur votre téléphone, une fenêtre peut apparaître demandant "Autoriser le débogage USB ?". Cochez "Toujours autoriser" et validez.
3.  Dans votre terminal (sur votre PC), tapez la commande suivante pour vérifier que le téléphone est bien reconnu :
    ```bash
    flutter devices
    ```
    Vous devriez voir le nom de votre téléphone dans la liste.

## 3. Lancer l'application

Une fois le téléphone détecté, vous pouvez lancer l'application avec :
```bash
flutter run
```
*Si vous avez plusieurs appareils connectés, utilisez `flutter run -d <device_id>`.*

## 4. Configuration importante pour le Backend (Laravel)

Puisque vous utilisez un téléphone physique, l'adresse `127.0.0.1` ou `10.0.2.2` ne fonctionnera pas pour contacter votre serveur Laravel.

1.  Assurez-vous que votre PC et votre téléphone sont sur le **même réseau Wi-Fi**.
2.  Trouvez l'adresse IP locale de votre PC (tapez `ipconfig` sur Windows ou `ifconfig` sur Mac/Linux). Exemple : `192.168.1.15`.
3.  Dans votre code Flutter (`lib/services/home_service.dart` et autres services), remplacez `10.0.2.2` par l'IP de votre PC :
    ```dart
    static const String _base = 'http://192.168.1.15:8000/api';
    ```
4.  Lancez votre serveur Laravel sur toutes les interfaces :
    ```bash
    php artisan serve --host=0.0.0.0
    ```

## 5. Astuces de test
- **Hot Reload** : Tapez `r` dans le terminal pour voir vos modifications instantanément sans redémarrer l'app.
- **Hot Restart** : Tapez `R` pour redémarrer l'application complètement.
- **Debug Paint** : Tapez `p` pour voir les bordures des widgets et déboguer votre mise en page.
