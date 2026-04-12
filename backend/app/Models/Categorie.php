<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Categorie extends Model
{
    protected $fillable = ['slug', 'label', 'svgIcon', 'couleur'];

    public function ingredients()
    {
        return $this->hasMany(Ingredient::class, 'categorie_id');
    }
}