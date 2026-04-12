<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Frigo extends Model
{
    protected $fillable = ['utilisateur_id'];

    public function ingredients()
    {
        return $this->belongsToMany(Ingredient::class, 'frigo_ingredients');
    }

    public function utilisateur()
    {
        return $this->belongsTo(User::class, 'utilisateur_id');
    }
}