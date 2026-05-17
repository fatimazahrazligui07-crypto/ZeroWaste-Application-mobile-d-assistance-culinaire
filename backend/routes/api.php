<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\FavoriteController;
use App\Http\Controllers\IngredientController;
use App\Http\Controllers\Api\HomeController;
use App\Http\Controllers\Api\ProfileController;
use App\Http\Controllers\Api\RecetteController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| PUBLIC ROUTES (No authentication required)
| GET    /api/ingredients   - Get all ingredients
| GET    /api/categories    - Get all categories  
| GET    /api/home          - Get home page data
| POST   /api/auth/signup   - Register new user
| POST   /api/auth/login    - User login
|
| PROTECTED ROUTES (Authentication required)
| POST   /api/auth/logout           - Logout user
| POST   /api/password/update       - Update user password
| GET    /api/profile               - Get authenticated user profile
| POST   /api/profile/update        - Update profile (firstname, lastname, username, email)
|
*/


// Public routes
Route::get('/ingredients', [IngredientController::class, 'index']);
Route::get('/categories', [IngredientController::class, 'categories']);
Route::get('/home', [HomeController::class, 'index']);

// Recette routes
Route::post('/recettes/suggest', [RecetteController::class, 'suggest']);
Route::get('/recettes', [RecetteController::class, 'index']);
Route::get('/recettes/{id}', [RecetteController::class, 'show']);
Route::get('/intervalles-temps', [RecetteController::class, 'getIntervallesTemps']);

// Auth routes
Route::prefix('auth')->group(function () {
    Route::post('/signup', [AuthController::class, 'signup']);
    Route::post('/login', [AuthController::class, 'login']);
    Route::post('/logout', [AuthController::class, 'logout'])->middleware('auth:sanctum');
});

// Password update route (outside auth prefix)
Route::post('/password/update', [ProfileController::class, 'updatePassword'])->middleware('auth:sanctum');

Route::get('/profile', [ProfileController::class, 'show'])->middleware('auth:sanctum');
Route::post('/profile/update', [ProfileController::class, 'update'])->middleware('auth:sanctum');

Route::middleware('auth:sanctum')->group(function () {
    // Favorites
    Route::get('/favorites',                [FavoriteController::class, 'index']);
    Route::post('/favorites/{recette_id}',  [FavoriteController::class, 'store']);
    Route::delete('/favorites/{recette_id}', [FavoriteController::class, 'destroy']);
    Route::get('/favorites/{recette_id}/check', [FavoriteController::class, 'check']);
});