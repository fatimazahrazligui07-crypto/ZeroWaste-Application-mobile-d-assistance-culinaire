<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class FrigoIngredient extends Model
{
    protected $fillable = ['frigo_id', 'ingredient_id', 'quantite', 'unite'];
}