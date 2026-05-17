<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class IntervalleTemps extends Model
{
    protected $table = 'intervalles_temps';

    protected $fillable = ['libelle', 'duree_min', 'duree_max'];
}