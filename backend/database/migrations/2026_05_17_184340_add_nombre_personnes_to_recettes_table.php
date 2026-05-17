<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('recettes', function (Blueprint $table) {
            $table->integer('nombre_personnes')->nullable()->default(4)->after('tempsCuisson');
        });
    }

    public function down(): void
    {
        Schema::table('recettes', function (Blueprint $table) {
            $table->dropColumn('nombre_personnes');
        });
    }
};