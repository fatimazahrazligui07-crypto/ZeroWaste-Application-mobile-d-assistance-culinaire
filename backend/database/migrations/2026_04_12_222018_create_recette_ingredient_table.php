<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('recette_ingredient', function (Blueprint $table) {
            $table->foreignId('recette_id')->constrained('recettes')->onDelete('cascade');
            $table->foreignId('ingredient_id')->constrained('ingredients')->onDelete('cascade');
            $table->string('quantite')->nullable();
            $table->primary(['recette_id', 'ingredient_id']);
            $table->timestamps();

        });
    }

    public function down(): void
    {
        Schema::dropIfExists('recette_ingredient');
    }
};