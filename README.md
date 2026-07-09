# FPS-Test-Formation - Guide d'Apprentissage Godot Engine

[![Godot](https://img.shields.io/badge/Godot-4.7-%23478cbf)](https://godotengine.org/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

Un projet complet pour apprendre les bases de **Godot Engine** dans le but de créer des applications 3D interactives. Ce projet combine un personnage à la première personne, des objets physiques manipulables et une interface utilisateur réactive pour illustrer les concepts essentiels du développement de jeux vidéo.

## 🎯 Objectifs du Projet

Cette application sert de bac à sable éducatif pour apprendre :
- **Les contrôles à la première personne** : Regarder autour de soi avec la souris et se déplacer au clavier.
- **L'interaction avec des objets 3D** : Manipulation physique (déplacement/saisie) d'objets.
- **Les boutons interactifs** : Détection du survol (hover) et clics avec retour visuel.
- **Les systèmes de raycasting** : Détection spatiale et ciblage utilisateur.
- **La gestion des ressources** : Utilisation de matériaux personnalisés et de scènes.

## 📋 Fonctionnalités

### Déplacements et Contrôles
- **Clavier** : touches ZQSD / Flèches / Joystick pour se déplacer.
- **Souris** : Regarder autour de soi en vue à la première personne (FPC).
- **Barre Espace** : Saut (basé sur la physique).
- **ESC** : Quitter l'application.

### Systèmes Interactifs
- **Détection de Survol (Hover)** : Système basé sur le Raycasting pour détecter les objets survolés des boutons et objets.
- **Saisie et Déplacement (Drag & Drop)** : Manipulation d'objets physiques dans l'espace 3D.
- **Retour Visuel** : Changement dynamique de matériaux lors du survol/clic.

## 🏗️ Structure du Projet

```
project/
├── main.tscn               # Scène principale avec l'environnement 3D complet
├── basketball.tscn         # Objet balle de basket (instanciable)
├── Controls.gd             # Contrôleur de personnage FPS
├── input_manager.gd        # Gestionnaire de raycasting et d'interaction
├── interactable_button.gd  # Script de bouton avec effets au survol
├── interactable_object.gd  # Objet physique manipulable (physique)
├── mesh_instance_3d.gd     # Changements dynamiques de couleur/matériau
├── .godot/                 # Cache et fichiers auto-générés par Godot
└── README.md               # Ce fichier
```

## 🔧 Détails Techniques

### Scripts Principaux

#### `Controls.gd` (CharacterBody3D)
Implémente les mouvements à la première personne :
- Simulation de la gravité.
- Mécanique de saut.
- Rotation de caméra basée sur la souris.
- Gestion des entrées clavier (ZQSD).

#### `input_manager.gd` (Node3D)
Gère le système d'interaction central :
- Raycasting continu depuis la position de la caméra.
- Détection des états survolés pour les objets StaticBody3D.
- Gestion des clics pour l'apparition d'objets.

#### `interactable_button.gd` (StaticBody3D)
Gère les interactions des boutons :
- Échange de matériaux au survol.
- Retour visuel via le changement de matériaux.
- Gestion efficace de l'état de survol (hover).

#### `interactable_object.gd` (RigidBody3D)
Interaction objet basée sur la physique :
- Détection de survol avec retour visuel.
- Mécaniques de prise et déplacement en 3D.
- Simulation physique avec forces de traction.

## 🚀 Pour Commencer

### Prérequis
- **Moteur Godot** : Version 4.7+ recommandée. Version Standard GDScript et non .NET
- **Système d'exploitation** : Windows/Mac/Linux (configuré pour le rendu D3D12).
- **Configuration système** : Compatible avec le mode GL Compatibility.

### Instructions de Configuration

1. **Téléchargez Godot Engine**
    - Visitez [godotengine.org](https://godotengine.org/).
    - Téléchargez la version 4.7 ou supérieure.

2. **Ouvrez le Projet**
  Fichier > Ouvrir Projet > Naviguez vers ce dossier

3. **Lancez le Projet**
    - Appuyez sur F5 ou cliquez sur "Exécuter le projet" dans l'éditeur.
    - La scène principale (`main.tscn`) se chargera automatiquement.

### Référence des Contrôles

| Action | Entrée |
|--------|--------|
| Avancer/Reculer | Z / S |
| Gauche/Droite | Q / D |
| Saut | Barre Espace |
| Regarder (Caméra) | Mouvement de la souris |
| Interagir | Clic Gauche |
| Quitter l'application | Échap (ESC) |

## 📚 Objectifs Pédagogiques

Ce projet démontre :
1. **Les Contrôleurs de Personnage** : Implémentation fluide des mouvements FPS.
2. **L'Intégration Physique** : Travail avec RigidBody3D et les moteurs physiques.
3. **Les Systèmes d'Interaction** : Raycasting pour la détection spatiale.
4. **Le Retour Visuel** : Matériaux dynamiques et animations.
5. **La Gestion de Scène** : Instanciation et gestion d'objets 3D.

## 🎓 Utilisation Éducative

Ce projet est conçu comme :
- Un **point de départ** pour le développement 3D avec Godot.
- Une **implémentation de référence** pour les mécaniques de jeu courantes.
- Un ** tutoriel interactif** pour comprendre les systèmes du moteur.
- Un **modèle** pour construire des applications 3D plus complexes.

## 🔍 Concepts Clés Couverts

- **CharacterBody3D** : Déplacement de personnage sans physique.
- **RigidBody3D** : Interaction basée sur la physique.
- **StaticBody3D** : Détection de collision sans physique.
- **RayCast3D** : Connaissance spatiale et ciblage.
- **Événements d'Entrée** : Gestion du clavier et de la souris.
- **Échange de Matériaux** : Retour visuel dynamique.

## 🛠️ Notes Techniques

### Moteur Physique
- Utilise **Jolt Physics** comme backend pour la physique 3D.
- Configurée pour une compatibilité maximale.
- Supporte les chemins de rendu GL et D3D12.

### Rendu
- Mode **GL Compatibility** (multi-plateforme).
- **Taille du Viewport** : 1920x1080 (par défaut).
- **Ratio d'Aspect** : Agrandir pour s'adapter.

### Optimisation
- Détection de survol efficace avec suivi des changements d'état.
- Calculs par frame minimaux dans les systèmes d'interaction.
- Séparation claire des responsabilités entre les scripts.

## 📝 Dépendances

Ce projet n'utilise que les fonctionnalités intégrées de Godot Engine :
- Aucune ressource externe ou bibliothèque requise.
- API standard de Godot 4.7.
- Compatible avec toutes les plateformes majeures (Windows, macOS, Linux).

## 🤝 Comment Contribuer / Expérimenter

N'hésitez pas à modifier ce projet pour apprendre :
1. Experimentez avec différents matériaux et couleurs.
2. Ajoutez de nouveaux objets interactifs.
3. Modifiez les paramètres physiques.
4. Étendez le système d'interaction.

**Rappel** : L'objectif est l'exploration et la compréhension, pas la perfection !

## 📄 Licence

Ce projet est publié sous la [Licence MIT](LICENSE).

Vous êtes libre de l'utiliser, de le modifier et de le distribuer à des fins éducatives.

## 🙏 Remerciements

- **L'équipe Godot Engine** - Pour avoir créé ce moteur de jeu incroyable.
- **Les ressources de la communauté** - Pour les tutoriels et la documentation.
- **Apprendre par la pratique** - Ce projet met l'accent sur l'apprentissage pratique !
- **LegionGames2004** - https://www.youtube.com/watch?v=A3HLeyaBCq4
- **Brackeys le goat** - https://www.youtube.com/watch?v=ke5KpqcoiIU

---

> **Conseil** : Commencez par examiner `Controls.gd` pour comprendre le système de mouvement, puis explorez `input_manager.gd` pour les motifs d'interaction. Le meilleur moyen d'apprendre est de modifier et d'expérimenter !

### 📖 Pour Aller Plus Loin

- [Documentation Godot 4](https://docs.godotengine.org/fr/stable/)
- [Contrôleurs de Personnage 3D](https://docs.godotengine.org/fr/stable/tutorials/physics/using_kinematic_body_3d.html)
- [Matériaux Physiques](https://docs.godotengine.org/fr/stable/tutorials/physics/material_and_collision_layers.html)
- [Raycasting en 3D](https://docs.godotengine.org/fr/stable/tutorials/physics/raycasting.html)

---

*Bon apprentissage ! 🎮*
# Godot-Template3D

