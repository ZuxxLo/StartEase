import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class Languages implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en": {
          "english": "English",
          "francais": "French",
          "continue": "Continue",
          "noConnection": "There is no internet Connection",
          "login": "Login",
          "forgotYourPassword?": "Forgot your password ?",
          "reset": "Reset",
          "password": "Password",
          "weWillSendUReset": "No worries we will send you reset instructions.",
          "sendEmail": "Send email",
          "enterNewPassword": "Please enter your new password",
          "passwordsNoMatch": "Passwords do not match",
          "enterAnEmail": "Please enter an email",
          "enterValidEmail": "Please enter a valid email",
          "enterPassword": "Please enter your password",
          "password<8": "Password can't be smaller than 8 letter",
          "password>20": "Password can't be larger than 20 letter",
          "enterCodePIN": "Please enter the Code PIN",
          "verifyCode": "Verify code",
          "email": "Email",
          "phoneNumber": "Phone number",
          "birthday": "Birthday",
          "birthplace": "Birthplace",
          'weakPassword': "The password provided is too weak.",
          "emailInUse": "The account already exists for that email.",
          "emailNotFound": "No user found for that email.",
          "wrongPassword": "Wrong password provided for that user.",
          "resetPasswordEmail": "A secret code has just been sent to ",
          "resendSecretCodeEmail": "Resend secret code",
          "changeEmail": "Change email",
          "invalidEmailOrPassword": "invalid email or password",
          "somethingWentWrong": "something went wrong",
          "Settings": "Settings",
          "Account": "Account",
          "PersonalInformation": "Personal information",
          "Language": "Language",
          "DarkMode": "Dark Mode",
          "signOut": "Sign Out",
        },
        "fr": {
          "english": "Anglais",
          "francais": "Français",
          "continue": "Continuez",
          "noConnection": "Il n'y a pas de connexion Internet",
          "login": "Connexion",
          "forgotYourPassword?": "Mot de passe oublié ?",
          "reset": "Réinitialiser le",
          "password": "Mot de passe",
          "weWillSendUReset":
              "Pas de soucis, nous vous enverrons des instructions de réinitialisation.",
          "sendEmail": "Envoyer un e-mail",
          "enterNewPassword": "Veuillez entrer votre nouveau mot de passe",
          "passwordsNoMatch": "Les mots de passe ne correspondent pas",
          "enterAnEmail": "Entrez un e-mail",
          "enterValidEmail": "entrez une adresse e-mail valide",
          "enterPassword": "s'il vous plait entrez votre mot de passe",
          "password<8":
              "le mot de passe ne peut pas être inférieur à 8 lettres",
          "password>20": "le mot de passe ne peut pas dépasser 20 lettres",
          "enterCodePIN": "Veuillez entrer le code PIN",
          "verifyCode": "Vérifier le code",
          "email": "Email",
          "phoneNumber": "Numéro de téléphone",
          "birthday": "Date de naissance",
          "birthplace": "Lieu de naissance",
          'weakPassword': "Le mot de passe fourni est trop faible.",
          "emailInUse": "Le compte existe déjà pour cet e-mail.",
          "emailNotFound": "Aucun utilisateur trouvé pour cet e-mail.",
          "wrongPassword": "Mauvais mot de passe fourni pour cet utilisateur.",
          "resetPasswordEmail": "Un code secret vient d'être envoyé à",
          "resendSecretCodeEmail": "Renvoyer le code secret",
          "changeEmail": "Changer l'e-mail",
          "invalidEmailOrPassword": "email ou mot de passe invalide",
          "somethingWentWrong": "quelque chose s'est mal passé",
          "Settings": "Paramètres",
          "Account": "Compte",
          "PersonalInformation": "Informations personnelles",
          "Language": "Langue",
          "DarkMode": "Mode sombre",
          "signOut": "Se déconnecter",
        }
      };

  static Locale initLang() {
    if (MainFunctions.sharredPrefs!.getString("codeLang") == null) {
      return Get.deviceLocale!;
    } else {
      return Locale(MainFunctions.sharredPrefs!.getString("codeLang")!);
    }
  }
}
