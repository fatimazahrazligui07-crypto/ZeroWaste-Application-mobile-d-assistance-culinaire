<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\IngredientController;
use App\Http\Controllers\Api\HomeController;
Route::get('/ingredients', [IngredientController::class, 'index']);
Route::get('/categories', [IngredientController::class, 'categories']);
Route::get('/home', [HomeController::class, 'index']);
Route::prefix('auth')->group(function () {
    Route::post('signup', [AuthController::class, 'signup']);
    Route::post('login', [AuthController::class, 'login']);

    // Protected routes
    Route::middleware('auth:sanctum')->group(function () {
        Route::post('logout', [AuthController::class, 'logout']);
    });
});