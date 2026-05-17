<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('recette_ingredient', function (Blueprint $table) {
            $table->string('unite')->nullable()->after('quantite');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('recette_ingredient', function (Blueprint $table) {
            $table->dropColumn('unite');
        });
    }
};
