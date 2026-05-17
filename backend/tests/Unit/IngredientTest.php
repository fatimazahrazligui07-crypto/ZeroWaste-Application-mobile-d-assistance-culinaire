<?php

namespace Tests\Unit;

use Tests\TestCase;
use App\Models\Ingredient;
use App\Models\Categorie;
use Illuminate\Foundation\Testing\RefreshDatabase;

class IngredientTest extends TestCase
{
    use RefreshDatabase;

    public function test_ingredient_belongs_to_categorie()
    {
        $categorie = Categorie::create([
            'slug' => 'fruits',
            'label' => 'Fruits',
            'svgIcon' => 'fruit.svg',
            'couleur' => '#ff0000',
        ]);

        $ingredient = Ingredient::create([
            'categorie_id' => $categorie->id,
            'nom' => 'Apple',
            'svgIcon' => 'apple.svg',
            'couleur' => '#ff0000',
        ]);

        $this->assertEquals('Fruits', $ingredient->categorie->label);
    }
}
