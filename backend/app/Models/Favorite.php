<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Favorite extends Model
{
    use SoftDeletes;

    protected $table = 'favoris';

    protected $fillable = [
        'utilisateur_id',
        'recette_id',
    ];

    public function recette()
    {
        return $this->belongsTo(Recette::class, 'recette_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'utilisateur_id');
    }
}