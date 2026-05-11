<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class UpdateIngredientIconsSeeder extends Seeder
{
    public function run(): void
    {
        $icons = [
            // Légumes
            'Tomates'          => 'https://cdn-icons-png.flaticon.com/512/11737/11737826.png',
            'Oignons'          => 'https://cdn-icons-png.flaticon.com/512/1330/1330443.png',
            'Carottes'         => 'https://cdn-icons-png.flaticon.com/512/4056/4056887.png',
            'Courgettes'       => 'https://cdn-icons-png.flaticon.com/512/6108/6108527.png',
            'Pommes de terre'  => 'https://cdn-icons-png.flaticon.com/512/1652/1652127.png',
            'Poivrons'         => 'https://cdn-icons-png.flaticon.com/512/5346/5346646.png',
            'Céleri'           => 'https://cdn-icons-png.flaticon.com/512/2503/2503866.png',
            'Navets'           => 'https://cdn-icons-png.flaticon.com/512/3944/3944102.png',
            'Aubergines'       => 'https://cdn-icons-png.flaticon.com/512/765/765592.png',
            'Petits pois'      => 'https://cdn-icons-png.flaticon.com/512/7315/7315544.png',
            // Protéines
            'Poulet'           => 'https://cdn-icons-png.flaticon.com/512/10753/10753522.png',
            //'Agneau'           => 'https://cdn-icons-png.flaticon.com/512/2639/2639988.png',
            'Bœuf'             => 'https://cdn-icons-png.flaticon.com/512/1703/1703009.png',
            'Sardines'         => 'https://cdn-icons-png.flaticon.com/128/1806/1806110.png',
            'Pois chiches'     => 'https://cdn-icons-png.flaticon.com/512/10806/10806482.png',
            'Lentilles'        => 'https://cdn-icons-png.flaticon.com/512/7230/7230979.png',
            'Œufs'             => 'https://cdn-icons-png.flaticon.com/512/17432/17432658.png',
            'Thon'             => 'https://cdn-icons-png.flaticon.com/512/17783/17783166.png',
            //'Crevettes'        => 'https://cdn-icons-png.flaticon.com/512/1716/1716012.png',
            //'Merguez'          => 'https://cdn-icons-png.flaticon.com/512/2917/2917995.png',
            // Épices
            'Cumin'            => 'https://cdn-icons-png.flaticon.com/512/15528/15528558.png',
            'Paprika'          => 'https://cdn-icons-png.flaticon.com/512/6332/6332161.png',
           // 'Ras el hanout'    => 'https://cdn-icons-png.flaticon.com/512/2965/2965567.png',
            'Curcuma'          => 'https://cdn-icons-png.flaticon.com/512/4165/4165744.png',
            'Coriandre'        => 'https://cdn-icons-png.flaticon.com/128/8933/8933689.png',
            'Persil'           => 'https://cdn-icons-png.flaticon.com/128/10441/10441102.png',
            'Gingembre'        => 'https://cdn-icons-png.flaticon.com/128/4165/4165744.png',
            'Cannelle'         => 'https://cdn-icons-png.flaticon.com/128/6692/6692068.png',
            'Safran'           => 'https://cdn-icons-png.flaticon.com/128/10979/10979562.png',
            'Poivre noir'      => 'https://cdn-icons-png.flaticon.com/128/15528/15528688.png',
            // Féculents
            'Semoule'          => 'https://cdn-icons-png.flaticon.com/128/5025/5025396.png',
            'Riz'              => 'https://cdn-icons-png.flaticon.com/128/9873/9873609.png',
            'Pâtes'            => 'https://cdn-icons-png.flaticon.com/128/10916/10916834.png',
            'Farine'           => 'https://cdn-icons-png.flaticon.com/128/9126/9126363.png',
            'Pain'             => 'https://cdn-icons-png.flaticon.com/128/8614/8614145.png',
            // Produits laitiers
            'Lait'             => 'https://cdn-icons-png.flaticon.com/128/10634/10634036.png',
            'Beurre'           => 'https://cdn-icons-png.flaticon.com/128/4670/4670983.png',
            'Fromage'          => 'https://cdn-icons-png.flaticon.com/128/3824/3824190.png',
            'Yaourt'           => 'https://cdn-icons-png.flaticon.com/128/5268/5268973.png',
           // 'Crème fraîche'    => 'https://cdn-icons-png.flaticon.com/512/3050/3050167.png',
            // Fruits
            'Citron'           => 'https://cdn-icons-png.flaticon.com/128/15612/15612986.png',
            'Oranges'          => 'https://cdn-icons-png.flaticon.com/128/1728/1728765.png',
           // 'Dattes'           => 'https://cdn-icons-png.flaticon.com/512/6098/6098149.png',
           // 'Figues'           => 'https://cdn-icons-png.flaticon.com/512/6098/6098155.png',
            'Olives'           => 'https://cdn-icons-png.flaticon.com/128/3130/3130149.png',
            // Huiles & Sauces
            "Huile d'olive"    => 'https://cdn-icons-png.flaticon.com/128/4264/4264676.png',
            'Huile de tournesol' => 'https://cdn-icons-png.flaticon.com/128/5037/5037447.png',
            'Concentré de tomate' => 'https://cdn-icons-png.flaticon.com/128/7557/7557291.png',
            //'Chermoula'        => 'https://cdn-icons-png.flaticon.com/512/2965/2965567.png',
           // 'Harissa'          => 'https://cdn-icons-png.flaticon.com/512/6332/6332161.png',
        ];

        foreach ($icons as $nom => $url) {
            DB::table('ingredients')
                ->where('nom', $nom)
                ->update(['svgIcon' => $url]);
        }

        $this->command->info('✅ Icônes mises à jour (' . count($icons) . ' ingrédients).');
    }
}