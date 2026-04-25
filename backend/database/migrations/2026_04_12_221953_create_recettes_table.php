<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('recettes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('administrateur_id')->constrained('administrateurs')->onDelete('cascade');
            $table->foreignId('informations_nutritionnelles_id')->nullable()->constrained('informations_nutritionnelles')->onDelete('set null');
            $table->string('nom');
            $table->text('description')->nullable();
            $table->json('instructions')->nullable();
            $table->string('niveauDifficulte', 50)->nullable();
            $table->integer('tempsPreparation')->nullable();
            $table->integer('tempsCuisson')->nullable();
            $table->string('origineCulinaires')->nullable();
            $table->string('image_url')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('recettes');
    }
};