<?php

namespace Tests\Feature;

use Tests\TestCase;
use App\Models\User;
use App\Models\Categorie;
use App\Models\Ingredient;
use Illuminate\Foundation\Testing\RefreshDatabase;

class IngredientControllerTest extends TestCase
{
  use RefreshDatabase;

  public function it_returns_all_ingredients_with_categories()
  {
    $user = User::create([
      'firstname' => 'Test',
      'lastname' => 'User',
      'username' => 'testuser',
      'name' => 'Test User',
      'email' => 'test@example.com',
      'password' => bcrypt('password'),
      'role' => 'user',
    ]);

    $categorie = Categorie::create([
      'nom' => 'Fruits',
      'slug' => 'fruits'
    ]);

    Ingredient::create([
      'nom' => 'Apple',
      'categorie_id' => $categorie->id
    ]);

    $response = $this->actingAs($user, 'sanctum')
      ->getJson('/api/ingredients');

    $response->assertStatus(200);

    $response->assertJsonStructure([
      [
        'id',
        'nom',
        'categorie' => [
          'id',
          'nom'
        ]
      ]
    ]);
  }

  public function it_returns_all_categories()
  {
    $user = User::create([
      'firstname' => 'Test',
      'lastname' => 'User',
      'username' => 'testuser2',
      'name' => 'Test User',
      'email' => 'test2@example.com',
      'password' => bcrypt('password'),
      'role' => 'user',
    ]);

    Categorie::create([
      'nom' => 'Vegetables',
      'slug' => 'vegetables'
    ]);

    Categorie::create([
      'nom' => 'Spices',
      'slug' => 'spices'
    ]);

    $response = $this->actingAs($user, 'sanctum')
      ->getJson('/api/categories');

    $response->assertStatus(200);

    $response->assertJsonStructure([
      [
        'id',
        'nom'
      ]
    ]);
  }
}
