<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('intervalles_temps', function (Blueprint $table) {
            $table->id();
            $table->string('libelle', 70);  // "Moins de 15 min", "15 à 30 min"...
            $table->integer('duree_min');   // 0
            $table->integer('duree_max');   // 15
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('intervalles_temps');
    }
};