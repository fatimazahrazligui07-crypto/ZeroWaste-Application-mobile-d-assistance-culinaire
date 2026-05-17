<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\IntervalleTemps;

class IntervalleTempsSeeder extends Seeder
{
    public function run(): void
    {
        IntervalleTemps::insert([
            ['libelle' => 'Moins de 15 min', 'duree_min' => 0,  'duree_max' => 15,   'created_at' => now(), 'updated_at' => now()],
            ['libelle' => '15 à 30 min',     'duree_min' => 15, 'duree_max' => 30,   'created_at' => now(), 'updated_at' => now()],
            ['libelle' => '30 min à 1h',     'duree_min' => 30, 'duree_max' => 60,   'created_at' => now(), 'updated_at' => now()],
            ['libelle' => 'Plus d\'1 heure', 'duree_min' => 60, 'duree_max' => 9999, 'created_at' => now(), 'updated_at' => now()],
        ]);
    }
}