<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class AuthControllerTest extends TestCase
{
  use RefreshDatabase;

  public function test_user_can_signup()
  {
    $response = $this->postJson('/api/auth/signup', [
      'firstname' => 'test_user',
      'lastname' => 'Ahmad',
      'username' => 'test_user123',

      'name' => 'test_user test_user2',

      'email' => 'test_user@test.com',
      'password' => 'password123',
      'password_confirmation' => 'password123',
    ]);

    $response->dump();

    $response->assertStatus(201);
  }

  public function test_user_can_login()
  {
    User::create([
      'firstname' => 'test_user',
      'lastname' => 'test_user2',
      'username' => 'test_user123',

      'name' => 'test_user test_user2',

      'email' => 'test_user@test.com',
      'password' => bcrypt('password123'),
    ]);

    $response = $this->postJson('/api/auth/login', [
      'email' => 'test_user@test.com',
      'password' => 'password123',
    ]);

    $response->dump();

    $response->assertStatus(200);
  }

  public function test_user_can_logout()
  {
    $user = User::create([
      'firstname' => 'test_user',
      'lastname' => 'test_user2',
      'username' => 'test_user123',

      'name' => 'test_user test_user2',

      'email' => 'test_user@test.com',
      'password' => bcrypt('password123'),
    ]);

    $token = $user->createToken('test-token')->plainTextToken;

    $response = $this->withHeaders([
      'Authorization' => 'Bearer ' . $token,
    ])->postJson('/api/auth/logout');

    $response->dump();

    $response->assertStatus(200);
  }
}
