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
        Schema::table('frigo_ingredients', function (Blueprint $table) {
            $table->decimal('quantite', 10, 2)->nullable()->after('ingredient_id');
            $table->string('unite')->nullable()->after('quantite');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('frigo_ingredients', function (Blueprint $table) {
            $table->dropColumn(['quantite', 'unite']);
        });
    }
};
