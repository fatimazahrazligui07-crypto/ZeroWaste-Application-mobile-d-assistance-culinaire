<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Recette;

class RecetteController extends Controller
{
    // POST /api/recettes/suggest
    public function suggest(Request $request)
    {
        $request->validate([
            'ingredient_ids'   => 'required|array|min:2',
            'ingredient_ids.*' => 'integer|exists:ingredients,id',
        ]);
    
        $selectedIds = array_map('intval', $request->ingredient_ids);
        $recettes = Recette::with('ingredients')->get();
    
        $mapped = $recettes->map(function ($recette) use ($selectedIds) {
            $totalIngredients   = $recette->ingredients->count();
            $ingredientsRecette = $recette->ingredients->pluck('id')->toArray();
            $matching           = count(array_intersect($selectedIds, $ingredientsRecette));
            $manquants          = count(array_diff($ingredientsRecette, $selectedIds));
            $compatibilite      = $totalIngredients > 0
                ? round(($matching / $totalIngredients) * 100)
                : 0;
    
            return [
                'id'                    => $recette->id,
                'nom'                   => $recette->nom,
                'image_url'             => $recette->image_url,
                'niveauDifficulte'      => $recette->niveauDifficulte,
                'tempsPreparation'      => $recette->tempsPreparation,
                'compatibilite'         => $compatibilite,
                'matching'              => $matching,
                'manquants'             => $manquants,
                'ingredients_manquants' => $recette->ingredients
                    ->whereNotIn('id', $selectedIds)
                    ->pluck('nom')
                    ->values(),
            ];
        });
    
        // Recettes avec au moins 1 ingredient matching
        $suggestions = $mapped
            ->filter(fn($r) => $r['matching'] >= 1 && $r['manquants'] <= 3)
            ->sortByDesc('compatibilite')
            ->values();
    
        $noMatch = false;
    
        // Si aucune suggestion → on retourne les plus proches
        if ($suggestions->isEmpty()) {
            $noMatch = true;
            $suggestions = $mapped
                ->sortByDesc('compatibilite')
                ->take(5)
                ->values();
        }
    
        return response()->json([
            'suggestions' => $suggestions,
            'nb_recettes' => $suggestions->count(),
            'no_match'    => $noMatch,
        ]);
    }
    public function index()
{
    $recettes = Recette::with('ingredients')->get()->map(function ($recette) {
        return [
            'id'               => $recette->id,
            'nom'              => $recette->nom,
            'image_url'        => $recette->image_url,
            'niveauDifficulte' => $recette->niveauDifficulte,
            'tempsPreparation' => $recette->tempsPreparation,
            'compatibilite'    => 0,
            'manquants'        => 0,
        ];
    });

    return response()->json($recettes);
}

    // GET /api/recettes/{id}
    public function show(int $id)
    {
        $recette = Recette::with('ingredients')->findOrFail($id);
 
        $ingredients = $recette->ingredients->map(function ($ing) {
            return [
                'id'         => $ing->id,
                'nom'        => $ing->nom,
                'quantite'   => $ing->pivot->quantite ?? '',
                'disponible' => false, // pas de frigo lié ici
            ];
        });
 
        // instructions est stocké en JSON dans la DB
        $instructions = [];
        if ($recette->instructions) {
            $decoded = json_decode($recette->instructions, true);
            $instructions = is_array($decoded) ? $decoded : [];
        }
 
        return response()->json([
            'id'               => $recette->id,
            'nom'              => $recette->nom,
            'description'      => $recette->description,
            'image_url'        => $recette->image_url,
            'niveauDifficulte' => $recette->niveauDifficulte,
            'tempsPreparation' => $recette->tempsPreparation,
            'tempsCuisson'     => $recette->tempsCuisson,
            'compatibilite'    => 0,
            'instructions'     => $instructions,
            'ingredients'      => $ingredients->values(),
        ]);
    }
}
