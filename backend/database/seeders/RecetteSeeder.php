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