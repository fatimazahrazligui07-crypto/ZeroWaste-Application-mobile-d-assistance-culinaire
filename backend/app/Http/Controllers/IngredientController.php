<?php

namespace App\Http\Controllers;

use App\Models\Ingredient;
use App\Models\Categorie;
use Illuminate\Http\Request;

class IngredientController extends Controller
{
    // GET /api/ingredients → tous les ingrédients avec leur catégorie
    public function index()
    {
        $ingredients = Ingredient::with('categorie')->get();
        return response()->json($ingredients);
    }

    // GET /api/categories → toutes les catégories
    public function categories()
    {
        $categories = Categorie::all();
        return response()->json($categories);
    }
}