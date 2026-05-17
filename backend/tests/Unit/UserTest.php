<?php

namespace Tests\Unit;

use Tests\TestCase;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;

class UserTest extends TestCase
{
    use RefreshDatabase;

    public function test_user_can_be_created()
    {
        $user = User::create([
            'firstname' => 'Youssef',
            'lastname' => 'Ahmadi',
            'name' => 'Ahmadi',
            'username' => 'youssef123',
            'email' => 'test@example.com',
            'password' => bcrypt('password'),
        ]);

        $this->assertDatabaseHas('users', [
            'email' => 'test@example.com'
        ]);
    }

    public function test_user_has_api_token_trait()
    {
        $this->assertTrue(
            in_array('Laravel\Sanctum\HasApiTokens', class_uses(User::class))
        );
    }
}
