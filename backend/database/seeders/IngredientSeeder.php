<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Ingredient;
use App\Models\Categorie;

class IngredientSeeder extends Seeder
{
    public function run(): void
    {
        $ingredients = [
            // Légumes
            ['categorie' => 'legumes', 'nom' => 'Tomates'],
            ['categorie' => 'legumes', 'nom' => 'Oignons'],
            ['categorie' => 'legumes', 'nom' => 'Carottes'],
            ['categorie' => 'legumes', 'nom' => 'Courgettes'],
            ['categorie' => 'legumes', 'nom' => 'Pommes de terre'],
            ['categorie' => 'legumes', 'nom' => 'Poivrons'],
            ['categorie' => 'legumes', 'nom' => 'Céleri'],
            ['categorie' => 'legumes', 'nom' => 'Navets'],
            ['categorie' => 'legumes', 'nom' => 'Aubergines'],
            ['categorie' => 'legumes', 'nom' => 'Petits pois'],

            // Protéines
            ['categorie' => 'proteines', 'nom' => 'Poulet'],
            ['categorie' => 'proteines', 'nom' => 'Agneau'],
            ['categorie' => 'proteines', 'nom' => 'Bœuf'],
            ['categorie' => 'proteines', 'nom' => 'Sardines'],
            ['categorie' => 'proteines', 'nom' => 'Pois chiches'],
            ['categorie' => 'proteines', 'nom' => 'Lentilles'],
            ['categorie' => 'proteines', 'nom' => 'Œufs'],
            ['categorie' => 'proteines', 'nom' => 'Thon'],
            ['categorie' => 'proteines', 'nom' => 'Crevettes'],
            ['categorie' => 'proteines', 'nom' => 'Merguez'],

            // Épices
            ['categorie' => 'epices', 'nom' => 'Cumin'],
            ['categorie' => 'epices', 'nom' => 'Paprika'],
            ['categorie' => 'epices', 'nom' => 'Ras el hanout'],
            ['categorie' => 'epices', 'nom' => 'Curcuma'],
            ['categorie' => 'epices', 'nom' => 'Coriandre'],
            ['categorie' => 'epices', 'nom' => 'Persil'],
            ['categorie' => 'epices', 'nom' => 'Gingembre'],
            ['categorie' => 'epices', 'nom' => 'Cannelle'],
            ['categorie' => 'epices', 'nom' => 'Safran'],
            ['categorie' => 'epices', 'nom' => 'Poivre noir'],

            // Féculents
            ['categorie' => 'feculents', 'nom' => 'Semoule'],
            ['categorie' => 'feculents', 'nom' => 'Riz'],
            ['categorie' => 'feculents', 'nom' => 'Pâtes'],
            ['categorie' => 'feculents', 'nom' => 'Farine'],
            ['categorie' => 'feculents', 'nom' => 'Pain'],

            // Produits laitiers
            ['categorie' => 'produits-laitiers', 'nom' => 'Lait'],
            ['categorie' => 'produits-laitiers', 'nom' => 'Beurre'],
            ['categorie' => 'produits-laitiers', 'nom' => 'Fromage'],
            ['categorie' => 'produits-laitiers', 'nom' => 'Yaourt'],
            ['categorie' => 'produits-laitiers', 'nom' => 'Crème fraîche'],

            // Fruits
            ['categorie' => 'fruits', 'nom' => 'Citron'],
            ['categorie' => 'fruits', 'nom' => 'Oranges'],
            ['categorie' => 'fruits', 'nom' => 'Dattes'],
            ['categorie' => 'fruits', 'nom' => 'Figues'],
            ['categorie' => 'fruits', 'nom' => 'Olives'],

            // Huiles & Sauces
            ['categorie' => 'huiles', 'nom' => 'Huile d\'olive'],
            ['categorie' => 'huiles', 'nom' => 'Huile de tournesol'],
            ['categorie' => 'huiles', 'nom' => 'Concentré de tomate'],
            ['categorie' => 'huiles', 'nom' => 'Chermoula'],
            ['categorie' => 'huiles', 'nom' => 'Harissa'],
        ];

        foreach ($ingredients as $item) {
            $categorie = Categorie::where('slug', $item['categorie'])->first();
            Ingredient::create([
                'categorie_id' => $categorie->id,
                'nom' => $item['nom'],
            ]);
        }
    }
}