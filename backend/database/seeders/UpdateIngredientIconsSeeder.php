<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class UpdateIngredientIconsSeeder extends Seeder
{
    public function run(): void
    {
        $icons = [
            'Tomates' => 'https://cdn-icons-png.flaticon.com/512/11737/11737826.png',
            'Oignons' => 'https://cdn-icons-png.flaticon.com/512/1330/1330443.png',
            'Carottes' => 'https://cdn-icons-png.flaticon.com/512/4056/4056887.png',
            'Courgettes' => 'https://cdn-icons-png.flaticon.com/512/6108/6108527.png',
            'Pommes de terre' => 'https://cdn-icons-png.flaticon.com/512/1652/1652127.png',
            'Poivrons' => 'https://cdn-icons-png.flaticon.com/512/5346/5346646.png',
            'Céleri' => 'https://cdn-icons-png.flaticon.com/512/2503/2503866.png',
            'Navets' => 'https://cdn-icons-png.flaticon.com/512/3944/3944102.png',
            'Aubergines' => 'https://cdn-icons-png.flaticon.com/512/765/765592.png',
            'Petits pois' => 'https://cdn-icons-png.flaticon.com/512/7315/7315544.png',
            'Poulet' => 'https://cdn-icons-png.flaticon.com/512/10753/10753522.png',
            'Bœuf' => 'https://cdn-icons-png.flaticon.com/512/1703/1703009.png',
            'Pois chiches' => 'https://cdn-icons-png.flaticon.com/512/10806/10806482.png',
            'Lentilles' => 'https://cdn-icons-png.flaticon.com/512/7230/7230979.png',
            'Œufs' => 'https://cdn-icons-png.flaticon.com/512/17432/17432658.png',
            'Thon' => 'https://cdn-icons-png.flaticon.com/512/17783/17783166.png',
            'Cumin' => 'https://cdn-icons-png.flaticon.com/512/15528/15528558.png',
            'Paprika' => 'https://cdn-icons-png.flaticon.com/512/6332/6332161.png',
            'Curcuma' => 'https://cdn-icons-png.flaticon.com/512/4165/4165744.png',
            'Coriandre' => 'https://cdn-icons-png.flaticon.com/512/8933/8933689.png',
        ];

        foreach ($icons as $nom => $url ) {
            DB::table('ingredients')
                ->where('nom', 'like', '%' . $nom . '%')
                ->update(['svgIcon' => $url]);
        }
    }
}
