<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Faker\Factory as Faker;

class UsersSeeder extends Seeder
{
    public function run(): void
    {
        $faker = Faker::create();

        $users = [
            [
                'firstname' => 'Admin',
                'lastname' => 'System',
                'username' => 'admin',
                'name' => 'Ahmed',
                'email' => 'admin@recipe.com',
                'password' => Hash::make('password'),
                'role' => 'admin',
                'avatar' => '/storage/users/admin.jpg',
                'bio' => 'Platform administrator managing content and users.'
            ],
            [
                'firstname' => 'Chef',
                'lastname' => 'Master',
                'username' => 'chefmaster',
                'name' => 'Ahmed',

                'email' => 'chef@recipe.com',
                'password' => Hash::make('password'),
                'role' => 'author',
                'avatar' => '/storage/users/chef.jpg',
                'bio' => 'Professional chef sharing high-quality recipes.'
            ]
        ];

        foreach ($users as $user) {
            User::create($user);
        }

        for ($i = 0; $i < 20; $i++) {
            User::create([
                'firstname' => $faker->firstName(),
                'lastname' => $faker->lastName(),
                'name' => 'Ahmed',

                'username' => $faker->unique()->userName(),
                'email' => $faker->unique()->safeEmail(),
                'password' => Hash::make('password'),
                'role' => $faker->randomElement(['user', 'author']),
                'avatar' => '/storage/users/default.jpg',
                'bio' => $faker->sentence(10)
            ]);
        }
    }
}
