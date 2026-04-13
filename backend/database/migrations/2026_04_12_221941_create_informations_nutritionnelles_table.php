<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('informations_nutritionnelles', function (Blueprint $table) {
            $table->id();
            $table->integer('calories')->nullable();
            $table->integer('proteines')->nullable();
            $table->integer('glucides')->nullable();
            $table->integer('lipides')->nullable();
            $table->timestamps();

        });
    }

    public function down(): void
    {
        Schema::dropIfExists('informations_nutritionnelles');
    }
};