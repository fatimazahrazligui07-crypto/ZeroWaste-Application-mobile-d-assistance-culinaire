<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Recette;
use App\Models\User;
use App\Models\Ingredient;
use App\Models\Administrateur;

class RecetteSeeder extends Seeder
{
    public function run(): void
    {$admin = \App\Models\Administrateur::firstOrCreate(
        ['email' => 'admin@zerowaste.ma'],
        [
            'nom' => 'Admin ZeroWaste',
            'password' => bcrypt('password'),
        ]
    );
        $recettes = [
            [
                'nom' => 'Couscous aux légumes',
                'description' => 'Le plat marocain par excellence, préparé avec de la semoule et des légumes frais.',
                'niveauDifficulte' => 'Moyen',
                'tempsPreparation' => 30,
                'tempsCuisson' => 60,
                'origineCulinaires' => 'Maroc',
                'image_url' => 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=400',
                'instructions' => json_encode(['Préparer la semoule', 'Cuire les légumes', 'Assembler le plat']),
                'ingredients' => ['Semoule', 'Carottes', 'Courgettes', 'Oignons', 'Pois chiches'],
            ],
            [
                'nom' => 'Tajine poulet aux olives',
                'description' => 'Un tajine savoureux au poulet confit avec des olives et du citron confit.',
                'niveauDifficulte' => 'Facile',
                'tempsPreparation' => 20,
                'tempsCuisson' => 45,
                'origineCulinaires' => 'Maroc',
                'image_url' => 'https://images.unsplash.com/photo-1511690743698-d9d85f2fbf38?w=400',
                'instructions' => json_encode(['Mariner le poulet', 'Cuire dans le tajine', 'Ajouter les olives']),
                'ingredients' => ['Poulet', 'Olives', 'Oignons', 'Citron', 'Cumin'],
            ],
            [
                'nom' => 'Harira',
                'description' => 'La soupe traditionnelle marocaine à base de tomates, lentilles et pois chiches.',
                'niveauDifficulte' => 'Facile',
                'tempsPreparation' => 15,
                'tempsCuisson' => 40,
                'origineCulinaires' => 'Maroc',
                'image_url' => 'https://images.unsplash.com/photo-1547592180-85f173990554?w=400',
                'instructions' => json_encode(['Faire revenir les oignons', 'Ajouter les tomates', 'Cuire les légumineuses']),
                'ingredients' => ['Tomates', 'Lentilles', 'Pois chiches', 'Oignons', 'Coriandre'],
            ],
            [
                'nom' => 'Pastilla au poulet',
                'description' => 'La pastilla, feuilleté sucré-salé farci au poulet et aux amandes.',
                'niveauDifficulte' => 'Difficile',
                'tempsPreparation' => 45,
                'tempsCuisson' => 30,
                'origineCulinaires' => 'Maroc',
                'image_url' => 'https://images.unsplash.com/photo-1574484284002-952d92456975?w=400',
                'instructions' => json_encode(['Préparer la farce', 'Monter la pastilla', 'Cuire au four']),
                'ingredients' => ['Poulet', 'Oignons', 'Cannelle', 'Œufs', 'Farine'],
            ],
            [
                'nom' => 'Zaalouk',
                'description' => 'Salade cuite d\'aubergines et tomates, parfumée au cumin et paprika.',
                'niveauDifficulte' => 'Facile',
                'tempsPreparation' => 10,
                'tempsCuisson' => 25,
                'origineCulinaires' => 'Maroc',
                'image_url' => 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400',
                'instructions' => json_encode(['Cuire les aubergines', 'Écraser avec les tomates', 'Assaisonner']),
                'ingredients' => ['Aubergines', 'Tomates', 'Cumin', 'Paprika', 'Huile d\'olive'],
            ],
            [
                'nom' => 'Mrouzia',
                'description' => 'Tajine d\'agneau sucré-salé aux raisins secs et amandes.',
                'niveauDifficulte' => 'Moyen',
                'tempsPreparation' => 20,
                'tempsCuisson' => 90,
                'origineCulinaires' => 'Maroc',
                'image_url' => 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=400',
                'instructions' => json_encode(['Mariner l\'agneau', 'Cuire longuement', 'Ajouter les fruits secs']),
                'ingredients' => ['Agneau', 'Oignons', 'Cannelle', 'Ras el hanout', 'Gingembre'],
            ],
            [
                'nom' => 'Bissara',
                'description' => 'Soupe épaisse de fèves ou pois cassés, typique du nord du Maroc.',
                'niveauDifficulte' => 'Facile',
                'tempsPreparation' => 10,
                'tempsCuisson' => 30,
                'origineCulinaires' => 'Maroc',
                'image_url' => 'https://images.unsplash.com/photo-1476718406336-bb5a9690ee2a?w=400',
                'instructions' => json_encode(['Cuire les pois', 'Mixer', 'Assaisonner avec cumin']),
                'ingredients' => ['Pois chiches', 'Cumin', 'Paprika', 'Huile d\'olive', 'Citron'],
            ],
            [
                'nom' => 'Kefta aux tomates',
                'description' => 'Boulettes de viande épicées mijotées dans une sauce tomate maison.',
                'niveauDifficulte' => 'Facile',
                'tempsPreparation' => 20,
                'tempsCuisson' => 30,
                'origineCulinaires' => 'Maroc',
                'image_url' => 'https://images.unsplash.com/photo-1529042410759-befb1204b468?w=400',
                'instructions' => json_encode(['Préparer les boulettes', 'Cuire la sauce tomate', 'Mijoter ensemble']),
                'ingredients' => ['Bœuf', 'Tomates', 'Oignons', 'Persil', 'Cumin'],
            ],
            [
                'nom' => 'Tajine sardines aux tomates',
                'description' => 'Tajine de sardines fraîches mijotées avec tomates et épices marocaines.',
                'niveauDifficulte' => 'Facile',
                'tempsPreparation' => 15,
                'tempsCuisson' => 30,
                'origineCulinaires' => 'Maroc',
                'image_url' => 'https://images.unsplash.com/photo-1580822184713-fc5400e7fe10?w=400',
                'instructions' => json_encode(['Nettoyer les sardines', 'Préparer la sauce tomate', 'Mijoter ensemble']),
                'ingredients' => ['Sardines', 'Tomates', 'Oignons', 'Cumin', 'Paprika'],
            ],
            [
                'nom' => 'Salade thon tomates',
                'description' => 'Salade fraîche au thon avec tomates et poivrons.',
                'niveauDifficulte' => 'Facile',
                'tempsPreparation' => 10,
                'tempsCuisson' => 0,
                'origineCulinaires' => 'Maroc',
                'image_url' => 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400',
                'instructions' => json_encode(['Couper les légumes', 'Égoutter le thon', 'Mélanger et assaisonner']),
                'ingredients' => ['Thon', 'Tomates', 'Poivrons', 'Oignons', 'Citron'],
            ],
           
            [
                'nom' => 'Tajine agneau aux légumes',
                'description' => 'Tajine d\'agneau tendre avec carottes et pommes de terre.',
                'niveauDifficulte' => 'Moyen',
                'tempsPreparation' => 20,
                'tempsCuisson' => 75,
                'origineCulinaires' => 'Maroc',
                'image_url' => 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=400',
                'instructions' => json_encode(['Dorer l\'agneau', 'Ajouter les légumes', 'Mijoter']),
                'ingredients' => ['Agneau', 'Carottes', 'Pommes de terre', 'Oignons', 'Ras el hanout'],
            ],
            [
                'nom' => 'Merguez aux poivrons',
                'description' => 'Merguez grillées avec poivrons et tomates épicées.',
                'niveauDifficulte' => 'Facile',
                'tempsPreparation' => 10,
                'tempsCuisson' => 20,
                'origineCulinaires' => 'Maroc',
                'image_url' => 'https://images.unsplash.com/photo-1529042410759-befb1204b468?w=400',
                'instructions' => json_encode(['Griller les merguez', 'Faire revenir les poivrons', 'Assembler']),
                'ingredients' => ['Merguez', 'Poivrons', 'Tomates', 'Oignons', 'Cumin'],
            ],
            [
                'nom' => 'Crevettes à la chermoula',
                'description' => 'Crevettes marinées à la chermoula et grillées.',
                'niveauDifficulte' => 'Facile',
                'tempsPreparation' => 20,
                'tempsCuisson' => 10,
                'origineCulinaires' => 'Maroc',
                'image_url' => 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=400',
                'instructions' => json_encode(['Mariner les crevettes', 'Griller', 'Servir avec citron']),
                'ingredients' => ['Crevettes', 'Coriandre', 'Cumin', 'Paprika', 'Citron'],
            ],
            [
                'nom' => 'Tajine bœuf aux petits pois',
                'description' => 'Tajine de bœuf mijoté avec petits pois et carottes.',
                'niveauDifficulte' => 'Moyen',
                'tempsPreparation' => 20,
                'tempsCuisson' => 60,
                'origineCulinaires' => 'Maroc',
                'image_url' => 'https://images.unsplash.com/photo-1574484284002-952d92456975?w=400',
                'instructions' => json_encode(['Dorer le bœuf', 'Ajouter les légumes', 'Mijoter']),
                'ingredients' => ['Bœuf', 'Petits pois', 'Carottes', 'Oignons', 'Curcuma'],
            ],
            [
                'nom' => 'Omelette aux légumes',
                'description' => 'Omelette marocaine aux poivrons, tomates et épices.',
                'niveauDifficulte' => 'Facile',
                'tempsPreparation' => 10,
                'tempsCuisson' => 15,
                'origineCulinaires' => 'Maroc',
                'image_url' => 'https://images.unsplash.com/photo-1510693206972-df098062cb71?w=400',
                'instructions' => json_encode(['Battre les œufs', 'Faire revenir les légumes', 'Cuire l\'omelette']),
                'ingredients' => ['Œufs', 'Poivrons', 'Tomates', 'Oignons', 'Cumin'],
            ],
            [
                'nom' => 'Soupe lentilles',
                'description' => 'Soupe épaisse de lentilles aux épices marocaines.',
                'niveauDifficulte' => 'Facile',
                'tempsPreparation' => 10,
                'tempsCuisson' => 35,
                'origineCulinaires' => 'Maroc',
                'image_url' => 'https://images.unsplash.com/photo-1476718406336-bb5a9690ee2a?w=400',
                'instructions' => json_encode(['Cuire les lentilles', 'Ajouter épices', 'Mixer partiellement']),
                'ingredients' => ['Lentilles', 'Oignons', 'Tomates', 'Cumin', 'Coriandre'],
            ],
           
        ];

        foreach ($recettes as $data) {
            $ingredientNames = $data['ingredients'];
            unset($data['ingredients']);

            $recette = Recette::create([
                ...$data,
                'administrateur_id' => 1,
            ]);

            foreach ($ingredientNames as $name) {
                $ingredient = Ingredient::where('nom', $name)->first();
                if ($ingredient) {
                    $recette->ingredients()->attach($ingredient->id, ['quantite' => '200g']);
                }
            }
        }
    }
}