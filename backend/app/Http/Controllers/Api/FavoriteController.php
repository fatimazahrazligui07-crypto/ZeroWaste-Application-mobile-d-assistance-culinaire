<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Favorite;
use App\Models\Recette;
use Illuminate\Http\Request;

class FavoriteController extends Controller
{
    /**
     * GET /api/favorites
     * List all favorites for the authenticated user
     */
    public function index(Request $request)
    {
        $favorites = Favorite::with('recette')
            ->where('utilisateur_id', $request->user()->id)
            ->get()
            ->map(fn($fav) => [
                'id'               => $fav->id,
                'recette_id'       => $fav->recette_id,
                'nom'              => $fav->recette->nom,
                'image_url'        => $fav->recette->image_url,
                'niveauDifficulte' => $fav->recette->niveauDifficulte,
                'tempsPreparation' => $fav->recette->tempsPreparation,
                'added_at'         => $fav->created_at,
            ]);

        return response()->json([
            'favorites' => $favorites,
            'total'     => $favorites->count(),
        ]);
    }

    /**
     * POST /api/favorites/{recette_id}
     * Add a recette to favorites
     */
    public function store(Request $request, int $recetteId)
    {
        // Ensure the recette exists
        $recette = Recette::findOrFail($recetteId);

        $userId = $request->user()->id;

        // Prevent duplicates (including soft-deleted ones)
        $existing = Favorite::withTrashed()
            ->where('utilisateur_id', $userId)
            ->where('recette_id', $recetteId)
            ->first();

        if ($existing) {
            if ($existing->trashed()) {
                // Restore if it was soft-deleted
                $existing->restore();
                return response()->json([
                    'message'  => 'Recette added to favorites',
                    'favorite' => $existing,
                ], 201);
            }

            return response()->json([
                'message' => 'Recette already in favorites',
            ], 409);
        }

        $favorite = Favorite::create([
            'utilisateur_id' => $userId,
            'recette_id'     => $recetteId,
        ]);

        return response()->json([
            'message'  => 'Recette added to favorites',
            'favorite' => $favorite,
        ], 201);
    }

    /**
     * DELETE /api/favorites/{recette_id}
     * Remove a recette from favorites
     */
    public function destroy(Request $request, int $recetteId)
    {
        $favorite = Favorite::where('utilisateur_id', $request->user()->id)
            ->where('recette_id', $recetteId)
            ->first();

        if (!$favorite) {
            return response()->json([
                'message' => 'Favorite not found',
            ], 404);
        }

        $favorite->delete();

        return response()->json([
            'message' => 'Recette removed from favorites',
        ]);
    }

    /**
     * GET /api/favorites/{recette_id}/check
     * Check if a recette is in the user's favorites
     */
    public function check(Request $request, int $recetteId)
    {
        $isFavorite = Favorite::where('utilisateur_id', $request->user()->id)
            ->where('recette_id', $recetteId)
            ->exists();

        return response()->json([
            'is_favorite' => $isFavorite,
            'recette_id'  => $recetteId,
        ]);
    }
}