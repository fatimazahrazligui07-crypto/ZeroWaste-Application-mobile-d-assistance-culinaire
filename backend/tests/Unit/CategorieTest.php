<?php

namespace Tests\Unit;

use Tests\TestCase;
use App\Models\Categorie;
use Illuminate\Foundation\Testing\RefreshDatabase;

class CategorieTest extends TestCase
{
    use RefreshDatabase;

    public function test_categorie_can_be_created()
    {
        $categorie = Categorie::create([
            'slug' => 'fruits',
            'label' => 'Fruits',
            'svgIcon' => 'fruit.svg',
            'couleur' => '#ff0000',
        ]);

        $this->assertDatabaseHas('categories', [
            'slug' => 'fruits'
        ]);

        $this->assertEquals('Fruits', $categorie->label);
    }

    public function test_categorie_has_many_ingredients()
    {
        $categorie = Categorie::create([
            'slug' => 'vegetables',
            'label' => 'Vegetables',
            'svgIcon' => 'veg.svg',
            'couleur' => '#00ff00',
        ]);

        $this->assertTrue(method_exists($categorie, 'ingredients'));
    }
}
