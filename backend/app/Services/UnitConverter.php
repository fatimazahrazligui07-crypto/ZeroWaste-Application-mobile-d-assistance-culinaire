<?php

namespace App\Services;

class UnitConverter
{
    protected static $ratios = [
        'mass' => [
            'g' => 1,
            'kg' => 1000,
        ],
        'volume' => [
            'ml' => 1,
            'cl' => 10,
            'l' => 1000,
        ],
        'piece' => [
            'pièces' => 1,
            'pièce' => 1,
        ]
    ];

    protected static $unitToType = [
        'g' => 'mass',
        'kg' => 'mass',
        'ml' => 'volume',
        'cl' => 'volume',
        'l' => 'volume',
        'pièces' => 'piece',
        'pièce' => 'piece',
    ];

    /**
     * Convertit une valeur d'une unité vers une autre si elles sont compatibles.
     */
    public static function convert($value, $fromUnit, $toUnit)
    {
        $fromUnit = strtolower($fromUnit);
        $toUnit = strtolower($toUnit);

        if ($fromUnit === $toUnit) {
            return $value;
        }

        $fromType = self::$unitToType[$fromUnit] ?? null;
        $toType = self::$unitToType[$toUnit] ?? null;

        if (!$fromType || !$toType || $fromType !== $toType) {
            return null; // Incompatible
        }

        $baseValue = $value * self::$ratios[$fromType][$fromUnit];
        return $baseValue / self::$ratios[$toType][$toUnit];
    }

    /**
     * Compare deux quantités avec des unités potentiellement différentes.
     * Retourne true si $have est supérieur ou égal à $need.
     */
    public static function hasEnough($haveQty, $haveUnit, $needQty, $needUnit)
    {
        $convertedHave = self::convert($haveQty, $haveUnit, $needUnit);
        
        if ($convertedHave === null) {
            return false;
        }

        return $convertedHave >= $needQty;
    }
}
