<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Recette extends Model
{
    use HasFactory;

    protected $fillable = [
        'nom',
        'niveau_difficulte',
        'temps_preparation',
        'image_url',
    ];

    public function ingredients()
    {
        return $this->belongsToMany(Ingredient::class);
    }
}