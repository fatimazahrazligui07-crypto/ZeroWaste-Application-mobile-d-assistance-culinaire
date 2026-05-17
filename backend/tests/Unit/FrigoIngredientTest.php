<?php

namespace Tests\Unit;

use Tests\TestCase;
use App\Models\User;
use App\Models\Frigo;
use App\Models\Categorie;
use App\Models\Ingredient;
use Illuminate\Foundation\Testing\RefreshDatabase;

class FrigoIngredientTest extends TestCase
{
    use RefreshDatabase;

    public function test_frigo_ingredient_can_be_created()
    {
        $user = User::create([
            'name' => 'Test User',
            'firstname' => 'Test',
            'lastname' => 'User',
            'username' => 'testuser',
            'email' => 'test@test.com',
            'password' => bcrypt('password'),
        ]);
        $frigo = Frigo::create([
            'utilisateur_id' => $user->id
        ]);

        $categorie = Categorie::create([
            'slug' => 'test',
            'label' => 'Test',
            'svgIcon' => 'icon',
            'couleur' => '#fff'
        ]);

        $ingredient = Ingredient::create([
            'categorie_id' => $categorie->id,
            'nom' => 'Onion',
            'svgIcon' => 'icon',
            'couleur' => '#fff'
        ]);

        $frigo->ingredients()->attach($ingredient->id);

        $this->assertDatabaseHas('frigo_ingredients', [
            'frigo_id' => $frigo->id,
            'ingredient_id' => $ingredient->id,
        ]);
    }
}
