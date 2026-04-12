<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Categorie;

class CategorieSeeder extends Seeder
{
    public function run(): void
    {
        $categories = [
            ['slug' => 'legumes', 'label' => 'Légumes', 'couleur' => '#3E7D52'],
            ['slug' => 'proteines', 'label' => 'Protéines', 'couleur' => '#E8892A'],
            ['slug' => 'epices', 'label' => 'Épices', 'couleur' => '#7A6255'],
            ['slug' => 'feculents', 'label' => 'Féculents', 'couleur' => '#E8C42A'],
            ['slug' => 'produits-laitiers', 'label' => 'Produits laitiers', 'couleur' => '#4A90D9'],
            ['slug' => 'fruits', 'label' => 'Fruits', 'couleur' => '#FF4E1F'],
            ['slug' => 'huiles', 'label' => 'Huiles & Sauces', 'couleur' => '#A0522D'],
        ];

        foreach ($categories as $cat) {
            Categorie::create($cat);
        }
    }
}