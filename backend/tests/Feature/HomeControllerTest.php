<?php

namespace Tests\Feature;

use Tests\TestCase;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Hash;

class HomeControllerTest extends TestCase
{
  use RefreshDatabase;

  protected $user;

  protected function setUp(): void
  {
    parent::setUp();

    // Create a clean user for authentication
    $this->user = User::create([
      'firstname' => 'Test',
      'lastname'  => 'User',
      'username'  => 'testuser',
      'name'      => 'Test User',
      'email'     => 'test@example.com',
      'password'  => Hash::make('password'),
      'role'      => 'user',
      'avatar'    => '/storage/users/default.jpg',
      'bio'       => 'Test account'
    ]);
  }

  public function test_home_endpoint_returns_stats_and_recettes()
  {
    $token = $this->user->createToken('test-token')->plainTextToken;

    $response = $this->withHeaders([
      'Authorization' => 'Bearer ' . $token,
      'Accept' => 'application/json',
    ])->getJson('/api/home');

    $response->assertStatus(200);

    $response->assertJsonStructure([
      'stats',
      'recettes',
    ]);
  }
}
