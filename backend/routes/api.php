<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\IngredientController;
use App\Http\Controllers\Api\HomeController;


// Public routes
Route::get('/ingredients', [IngredientController::class, 'index']);
Route::get('/categories', [IngredientController::class, 'categories']);
Route::get('/home', [HomeController::class, 'index']);

// Auth routes
Route::prefix('auth')->group(function () {
    Route::post('/signup', [AuthController::class, 'signup']);
    Route::post('/login', [AuthController::class, 'login']);
    Route::post('/logout', [AuthController::class, 'logout'])->middleware('auth:sanctum');
});

// Password update route (outside auth prefix)
Route::post('/password/update', [AuthController::class, 'updatePassword'])->middleware('auth:sanctum');