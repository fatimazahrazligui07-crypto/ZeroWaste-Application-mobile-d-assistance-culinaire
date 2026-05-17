<?php

namespace Tests\Feature;

use App\Models\User;
use Laravel\Sanctum\Sanctum;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class ProfileControllerTest extends TestCase
{
  use RefreshDatabase;

  /**
   * SHOW PROFILE
   */
  public function test_user_can_view_profile()
  {
    $user = User::create([
      'firstname' => 'test_user',
      'lastname' => 'test_user2',
      'username' => 'test_user123',
      'name' => 'test_user test_user2',
      'email' => 'test_user@test.com',
      'password' => bcrypt('password123'),
    ]);

    Sanctum::actingAs($user);

    $response = $this->getJson('/api/profile');

    $response->dump();

    $response->assertStatus(200)
      ->assertJson([
        'firstname' => 'test_user',
        'lastname' => 'test_user2',
        'username' => 'test_user123',
        'email' => 'test_user@test.com',
      ]);
  }

  /**
   * UPDATE PROFILE
   */
  public function test_user_can_update_profile()
  {
    $user = User::create([
      'firstname' => 'Old',
      'lastname' => 'Name',
      'username' => 'oldusername',
      'name' => 'Old Name',
      'email' => 'old@test.com',
      'password' => bcrypt('password123'),
    ]);

    Sanctum::actingAs($user);

    $response = $this->postJson('/api/profile/update', [
      'firstname' => 'NewFirstname',
      'lastname' => 'NewLastname',
      'username' => 'newusername',
      'email' => 'new@test.com',
    ]);

    $response->dump();

    $response->assertStatus(200)
      ->assertJson([
        'message' => 'Profile updated successfully',
      ]);
  }

  /**
   * UPDATE PASSWORD
   */
  public function test_user_can_update_password()
  {
    $user = User::create([
      'firstname' => 'test_user',
      'lastname' => 'test_user2',
      'username' => 'test_user123',
      'name' => 'test_user test_user2',
      'email' => 'test_user@test.com',
      'password' => bcrypt('password123'),
    ]);

    Sanctum::actingAs($user);

    $response = $this->postJson('/api/password/update', [
      'old_password' => 'password123',
      'password' => 'newpassword123',
    ]);

    $response->dump();

    $response->assertStatus(200)
      ->assertJson([
        'message' => 'Password updated successfully',
      ]);
  }
}
