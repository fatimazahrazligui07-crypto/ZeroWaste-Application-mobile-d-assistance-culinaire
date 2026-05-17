<?php

namespace Tests\Unit;

use Tests\TestCase;
use App\Models\User;
use App\Models\Frigo;
use App\Models\Categorie;
use App\Models\Ingredient;
use Illuminate\Foundation\Testing\RefreshDatabase;

class FrigoTest extends TestCase
{
    use RefreshDatabase;

    public function test_frigo_belongs_to_user()
    {
        $user = User::create([
            'firstname' => 'Test',
            'lastname' => 'User',
            'username' => 'testuser',
            'name' => 'Test User', // REQUIRED by DB
            'email' => 'test@test.com',
            'password' => bcrypt('password'),
        ]);

        $frigo = Frigo::create([
            'utilisateur_id' => $user->id
        ]);

        $this->assertEquals($user->id, $frigo->utilisateur->id);
    }

    public function test_frigo_has_ingredients_relationship()
    {
        $user = User::create([
            'firstname' => 'Test',
            'lastname' => 'User',
                'name' => 'Test User', // REQUIRED by DB
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
            'nom' => 'Tomato',
            'svgIcon' => 'icon',
            'couleur' => '#red'
        ]);

        $frigo->ingredients()->attach($ingredient->id);

        $this->assertCount(1, $frigo->ingredients);
    }
}
