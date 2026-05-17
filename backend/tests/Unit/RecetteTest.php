<?php

namespace Tests\Unit;

use Tests\TestCase;
use App\Models\Recette;
use App\Models\Categorie;
use App\Models\Ingredient;
use App\Models\Administrateur;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Hash;

class RecetteTest extends TestCase
{
    use RefreshDatabase;

    private function createAdmin(): Administrateur
    {
        return Administrateur::forceCreate([
            'nom'      => 'Admin',
            'email'    => 'admin@test.com',
            'password' => Hash::make('password'),
        ]);
    }

    private function createRecette(int $adminId): Recette
    {
        return Recette::forceCreate([
            'nom'               => 'Pizza',
            'image_url'         => 'pizza.jpg',
            'administrateur_id' => $adminId,
        ]);
    }

    public function test_recette_can_be_created(): void
    {
        $admin   = $this->createAdmin();
        $recette = $this->createRecette($admin->id);

        $this->assertNotNull($recette->id);
        $this->assertDatabaseHas('recettes', [
            'nom'               => 'Pizza',
            'administrateur_id' => $admin->id,
        ]);
    }

    public function test_recette_has_ingredients_relationship(): void
    {
        $admin   = $this->createAdmin();
        $recette = $this->createRecette($admin->id);

        $categorie = Categorie::forceCreate([
            'slug'    => 'test',
            'label'   => 'Test',
            'svgIcon' => 'icon',
            'couleur' => '#fff',
        ]);

        $ingredient = Ingredient::forceCreate([
            'categorie_id' => $categorie->id,
            'nom'          => 'Cheese',
            'svgIcon'      => 'icon',
            'couleur'       => '#fff',
        ]);

        $recette->ingredients()->attach($ingredient->id, [
            'quantite' => '100g',
        ]);

        $this->assertCount(1, $recette->fresh()->ingredients);
    }
}
