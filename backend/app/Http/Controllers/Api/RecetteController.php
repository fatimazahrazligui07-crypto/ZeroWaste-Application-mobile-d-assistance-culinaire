<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Recette;
use App\Models\IntervalleTemps;
use App\Services\UnitConverter;

class RecetteController extends Controller
{
    // POST /api/recettes/suggest
    public function suggest(Request $request)
    {
        $request->validate([
            'ingredients' => 'required|array|min:1',
            'ingredients.*.id' => 'required|integer|exists:ingredients,id',
            'ingredients.*.quantite' => 'nullable|numeric',
            'ingredients.*.unite' => 'nullable|string',
        ]);
    
        $userIngredients = $request->ingredients;
        $recettes = Recette::with('ingredients')->get();
    
        $mapped = $recettes->map(function ($recette) use ($userIngredients) {
            $totalIngredients = $recette->ingredients->count();
            $matchingCount = 0;
            $manquants = [];

            foreach ($recette->ingredients as $recetteIng) {
                $found = false;
                foreach ($userIngredients as $userIng) {
                    if ($userIng['id'] == $recetteIng->id) {
                        // Si l'utilisateur a fourni une quantité et une unité, on vérifie
                        if (isset($userIng['quantite'], $userIng['unite']) && isset($recetteIng->pivot->quantite, $recetteIng->pivot->unite)) {
                            if (UnitConverter::hasEnough($userIng['quantite'], $userIng['unite'], $recetteIng->pivot->quantite, $recetteIng->pivot->unite)) {
                                $matchingCount++;
                                $found = true;
                            }
                        } else {
                            // Si pas de quantité/unité spécifiée, on compte juste l'ingrédient
                            $matchingCount++;
                            $found = true;
                        }
                        break;
                    }
                }
                if (!$found) {
                    $manquants[] = $recetteIng->nom;
                }
            }

            $compatibilite = $totalIngredients > 0
                ? round(($matchingCount / $totalIngredients) * 100)
                : 0;
    
            return [
                'id'                    => $recette->id,
                'nom'                   => $recette->nom,
                'image_url'             => $recette->image_url,
                'niveauDifficulte'      => $recette->niveauDifficulte,
                'tempsPreparation'      => $recette->tempsPreparation,
                'compatibilite'         => $compatibilite,
                'matching'              => $matchingCount,
                'manquants'             => count($manquants),
                'ingredients_manquants' => $manquants,
            ];
        });
    
        // Recettes avec au moins 1 ingredient matching
        $suggestions = $mapped
            ->filter(fn($r) => $r['matching'] >= 1)
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
                'unite'      => $ing->pivot->unite ?? '',
                'disponible' => false,
            ];
        });
 
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

    public function getIntervallesTemps()
    {
        $intervalles = IntervalleTemps::all();
        return response()->json($intervalles);
    }
}
