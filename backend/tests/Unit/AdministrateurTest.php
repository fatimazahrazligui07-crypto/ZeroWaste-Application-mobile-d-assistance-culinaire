<?php

namespace Tests\Unit;

use Tests\TestCase;
use App\Models\Administrateur;
use Illuminate\Foundation\Testing\RefreshDatabase;

class AdministrateurTest extends TestCase
{
    use RefreshDatabase;

    public function test_administrateur_can_be_created()
    {
        $admin = Administrateur::create([
            'nom' => 'Admin One',
            'email' => 'admin@test.com',
            'password' => bcrypt('password'),
        ]);

        $this->assertDatabaseHas('administrateurs', [
            'email' => 'admin@test.com'
        ]);

        $this->assertEquals('Admin One', $admin->nom);
    }
}
