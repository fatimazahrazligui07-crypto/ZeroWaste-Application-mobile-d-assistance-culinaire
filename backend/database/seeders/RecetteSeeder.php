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
                'image_url' => 'https://www.voyage-marrakech.com/wp-content/uploads/2024/03/Photo-Couscous-Maroc.webp',
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
                'image_url' => 'https://www.delicerecette.com/wp-content/uploads/2024/11/42.Tajine-de-poulet-aux-olives-et-Citron-3-683x1024.jpg',
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
                'image_url' => 'https://www.trendinrecipe.com/wp-content/uploads/2025/08/assets_task_01k1js9dh6fgxr0z6g7q4xa724_1754050991_img_1.webp',
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
                'image_url' => 'https://tse2.mm.bing.net/th/id/OIP.kQUqZyZF7zUe3uR34f4M7AHaEK?rs=1&pid=ImgDetMain&o=7&rm=3',
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
                'image_url' => 'https://www.thedeliciouscrescent.com/wp-content/uploads/2021/09/Zaalouk-5.jpg',
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
                'image_url' => 'https://tse4.mm.bing.net/th/id/OIP.IAGYe0otyQieFc8PvmH8mgHaE9?rs=1&pid=ImgDetMain&o=7&rm=3',
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
                'image_url' => 'https://tse1.mm.bing.net/th/id/OIP.zYBOitsRLFme09FgxGWhGQHaEJ?rs=1&pid=ImgDetMain&o=7&rm=3',
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
                'image_url' => 'https://www.auxdelicesdupalais.net/wp-content/uploads/2024/05/tajine-kefta-aux-oeufs-a-la-marocaine-8.jpg',
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