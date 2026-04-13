<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('statistiques', function (Blueprint $table) {
            $table->id();
            $table->foreignId('administrateur_id')->constrained('administrateurs')->onDelete('cascade');
            $table->string('type');
            $table->text('valeur')->nullable();
            $table->date('date');
            $table->timestamps();


        });
    }

    public function down(): void
    {
        Schema::dropIfExists('statistiques');
    }
};