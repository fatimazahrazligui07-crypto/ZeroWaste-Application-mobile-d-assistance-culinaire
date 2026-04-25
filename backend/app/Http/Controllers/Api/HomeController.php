<?php
namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Recette;

class HomeController extends Controller
{
    // GET /api/home
    public function index(Request $request)
    {
        $user  = $request->user();
        //$frigo = $user->frigo;
        $frigo = $user?->frigo;

        // IDs des ingrédients dans le frigo
        $ingredientIds = $frigo
            ? $frigo->ingredients->pluck('id')->toArray()
            : [];

        // Recettes avec % de compatibilité
        $recettes = Recette::with('ingredients')
            ->get()
            ->map(function ($recette) use ($ingredientIds) {
                $total     = $recette->ingredients->count();
                $disponibles = $recette->ingredients
                    ->whereIn('id', $ingredientIds)
                    ->count();

                $compatibilite = $total > 0
                    ? round(($disponibles / $total) * 100)
                    : 0;

                return [
                    'id'               => $recette->id,
                    'nom'              => $recette->nom,
                    'niveau_difficulte' => $recette->niveauDifficulte,
                    'temps_preparation' => $recette->tempsPreparation,
                    'image_url'        => $recette->image_url,
                    'compatibilite'    => $compatibilite,
                ];
            })
            ->sortByDesc('compatibilite')
            ->take(5)
            ->values();

        return response()->json([
            'stats' => [
                'nb_ingredients' => count($ingredientIds),
                'nb_recettes'    => Recette::count(),
            ],
            'recettes' => $recettes,
        ]);
    }
}
