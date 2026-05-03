<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Categorie;

class IngredientSeeder extends Seeder
{
    public function run(): void
    {
        $ingredients = [

            // ─── Légumes ───────────────────────────────────────────────────────────
            [
                'categorie' => 'legumes',
                'nom'       => 'Tomates',
                'couleur'   => '#E53935',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><circle cx="12" cy="13" r="9" fill="currentColor"/><path d="M12 4v4M9 5l1.5 3M15 5l-1.5 3" stroke="#2E7D32" stroke-width="1.8" stroke-linecap="round"/></svg>',
            ],
            [
                'categorie' => 'legumes',
                'nom'       => 'Oignons',
                'couleur'   => '#AB47BC',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M12 22c4.4 0 8-3.6 8-8 0-5.5-8-12-8-12S4 8.5 4 14c0 4.4 3.6 8 8 8z" fill="currentColor"/><path d="M9 14c0-1.7 1.3-4 3-6" stroke="white" stroke-width="1.2" stroke-linecap="round" opacity="0.5"/></svg>',
            ],
            [
                'categorie' => 'legumes',
                'nom'       => 'Carottes',
                'couleur'   => '#FB8C00',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M12 20L7 6l5-2 5 2-5 14z" fill="currentColor"/><path d="M12 4s-2-3 0-4 0 4 0 4" fill="#43A047"/><path d="M10 4s-3-2-3 0 3 0 3 0" fill="#43A047"/><path d="M14 4s3-2 3 0-3 0-3 0" fill="#43A047"/></svg>',
            ],
            [
                'categorie' => 'legumes',
                'nom'       => 'Courgettes',
                'couleur'   => '#43A047',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><ellipse cx="12" cy="14" rx="7" ry="5" fill="currentColor"/><path d="M12 9V5M10 6l2-3 2 3" stroke="#2E7D32" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M7 13c1-2 3-3 5-3s4 1 5 3" stroke="white" stroke-width="1" opacity="0.4"/></svg>',
            ],
            [
                'categorie' => 'legumes',
                'nom'       => 'Pommes de terre',
                'couleur'   => '#A1887F',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><ellipse cx="12" cy="13" rx="8" ry="6" fill="currentColor"/><circle cx="9" cy="11" r="1" fill="#6D4C41"/><circle cx="14" cy="14" r="1" fill="#6D4C41"/><circle cx="11" cy="15" r="0.8" fill="#6D4C41"/></svg>',
            ],
            [
                'categorie' => 'legumes',
                'nom'       => 'Poivrons',
                'couleur'   => '#E53935',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M12 5c-5 0-8 4-7 9s4 8 7 8 6-3 7-8-2-9-7-9z" fill="currentColor"/><path d="M12 3V5" stroke="#2E7D32" stroke-width="2" stroke-linecap="round"/><path d="M10 5c-1-2 1-3 2-2" stroke="#2E7D32" stroke-width="1.2" stroke-linecap="round"/></svg>',
            ],
            [
                'categorie' => 'legumes',
                'nom'       => 'Céleri',
                'couleur'   => '#66BB6A',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M12 22V8" stroke="currentColor" stroke-width="3" stroke-linecap="round"/><path d="M12 14c-3-3-6-2-6 1" stroke="currentColor" stroke-width="2" stroke-linecap="round" fill="none"/><path d="M12 10c3-3 6-2 6 1" stroke="currentColor" stroke-width="2" stroke-linecap="round" fill="none"/><path d="M9 4c-1 2 0 4 3 4s4-2 3-4" fill="currentColor"/></svg>',
            ],
            [
                'categorie' => 'legumes',
                'nom'       => 'Navets',
                'couleur'   => '#CE93D8',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><circle cx="12" cy="14" r="7" fill="currentColor"/><path d="M12 7V3M10 5l2-2 2 2" stroke="#7B1FA2" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M5 14h14" stroke="white" stroke-width="1" opacity="0.3"/></svg>',
            ],
            [
                'categorie' => 'legumes',
                'nom'       => 'Aubergines',
                'couleur'   => '#6A1B9A',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M12 21c4 0 7-3.5 7-7.5S16 6 12 6 5 9.5 5 13.5 8 21 12 21z" fill="currentColor"/><path d="M12 6V3M14 4c1-2 4-1 3 2" stroke="#2E7D32" stroke-width="1.5" stroke-linecap="round" fill="none"/></svg>',
            ],
            [
                'categorie' => 'legumes',
                'nom'       => 'Petits pois',
                'couleur'   => '#2E7D32',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M4 12c0 2 1.5 4 4 4h8c2.5 0 4-2 4-4s-1.5-4-4-4H8c-2.5 0-4 2-4 4z" fill="currentColor"/><circle cx="9" cy="12" r="1.8" fill="#A5D6A7"/><circle cx="12" cy="12" r="1.8" fill="#A5D6A7"/><circle cx="15" cy="12" r="1.8" fill="#A5D6A7"/></svg>',
            ],

            // ─── Protéines ─────────────────────────────────────────────────────────
            [
                'categorie' => 'proteines',
                'nom'       => 'Poulet',
                'couleur'   => '#F9A825',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M16 5c0-1.7-1.3-3-3-3S10 3.3 10 5c0 1 .5 2 1.2 2.6L7 20h10l-3.2-12.4C14.5 7 16 6 16 5z" fill="currentColor"/><path d="M7 20h10" stroke="#E65100" stroke-width="1.5" stroke-linecap="round"/></svg>',
            ],
            [
                'categorie' => 'proteines',
                'nom'       => 'Agneau',
                'couleur'   => '#8D6E63',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><ellipse cx="12" cy="13" rx="7" ry="5" fill="currentColor"/><circle cx="9" cy="9" r="3" fill="currentColor"/><circle cx="15" cy="9" r="3" fill="currentColor"/><ellipse cx="12" cy="9" rx="4" ry="3" fill="currentColor"/><path d="M9 18v3M15 18v3" stroke="currentColor" stroke-width="2" stroke-linecap="round"/></svg>',
            ],
            [
                'categorie' => 'proteines',
                'nom'       => 'Bœuf',
                'couleur'   => '#B71C1C',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M5 7c0-2 1-3 3-3h8c2 0 3 1 3 3v7c0 2-1 4-3 5H9c-2-1-3-3-3-5V7z" fill="currentColor"/><path d="M9 4V2M15 4V2" stroke="#7F0000" stroke-width="1.5" stroke-linecap="round"/><path d="M8 12h8" stroke="white" stroke-width="1" opacity="0.3"/></svg>',
            ],
            [
                'categorie' => 'proteines',
                'nom'       => 'Sardines',
                'couleur'   => '#1565C0',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M3 12c0 0 4-5 9-5s9 5 9 5-4 5-9 5-9-5-9-5z" fill="currentColor"/><circle cx="17" cy="12" r="1.2" fill="white"/><path d="M3 12l-2-2M3 12l-2 2" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/><path d="M8 10c1 1 1 3 0 4" stroke="#90CAF9" stroke-width="1" stroke-linecap="round" fill="none"/></svg>',
            ],
            [
                'categorie' => 'proteines',
                'nom'       => 'Pois chiches',
                'couleur'   => '#F9A825',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><circle cx="9" cy="13" r="4" fill="currentColor"/><circle cx="15" cy="13" r="4" fill="currentColor"/><path d="M9 9c-1-2 0-5 3-5s3 3 3 5" fill="currentColor"/></svg>',
            ],
            [
                'categorie' => 'proteines',
                'nom'       => 'Lentilles',
                'couleur'   => '#795548',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><ellipse cx="8" cy="12" rx="3" ry="2" fill="currentColor"/><ellipse cx="14" cy="10" rx="3" ry="2" fill="currentColor"/><ellipse cx="16" cy="15" rx="3" ry="2" fill="currentColor"/><ellipse cx="10" cy="16" rx="2.5" ry="1.8" fill="currentColor"/></svg>',
            ],
            [
                'categorie' => 'proteines',
                'nom'       => 'Œufs',
                'couleur'   => '#FDD835',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M12 3C8 3 5 7.5 5 12c0 3.9 3.1 7 7 7s7-3.1 7-7c0-4.5-3-9-7-9z" fill="white" stroke="#E0E0E0" stroke-width="1"/><circle cx="12" cy="13" r="4" fill="currentColor"/></svg>',
            ],
            [
                'categorie' => 'proteines',
                'nom'       => 'Thon',
                'couleur'   => '#0288D1',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M2 12c0 0 5-6 10-6s10 6 10 6-5 6-10 6S2 12 2 12z" fill="currentColor"/><circle cx="17" cy="12" r="1.5" fill="white"/><path d="M22 8l-2 4 2 4" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" fill="none"/></svg>',
            ],
            [
                'categorie' => 'proteines',
                'nom'       => 'Crevettes',
                'couleur'   => '#FF7043',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M8 4c-2 2-3 5-2 8s4 5 7 5c2 0 4-1 5-3" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" fill="none"/><path d="M13 17c1 2 1 3 0 4" stroke="currentColor" stroke-width="2" stroke-linecap="round" fill="none"/><path d="M7 6l-3-1M7 9l-3 0M7 12l-3 1" stroke="currentColor" stroke-width="1.2" stroke-linecap="round"/></svg>',
            ],
            [
                'categorie' => 'proteines',
                'nom'       => 'Merguez',
                'couleur'   => '#C62828',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M4 16c0 0 2-8 8-10s10 2 10 2" stroke="currentColor" stroke-width="3" stroke-linecap="round" fill="none"/><path d="M4 16c0 1.5 1 2 2 1" stroke="currentColor" stroke-width="2" stroke-linecap="round" fill="none"/></svg>',
            ],

            // ─── Épices ────────────────────────────────────────────────────────────
            [
                'categorie' => 'epices',
                'nom'       => 'Cumin',
                'couleur'   => '#8D6E63',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><ellipse cx="12" cy="12" rx="2" ry="6" fill="currentColor" transform="rotate(-20 12 12)"/><ellipse cx="8" cy="12" rx="1.5" ry="5" fill="currentColor" transform="rotate(-20 8 12)"/><ellipse cx="16" cy="12" rx="1.5" ry="5" fill="currentColor" transform="rotate(-20 16 12)"/></svg>',
            ],
            [
                'categorie' => 'epices',
                'nom'       => 'Paprika',
                'couleur'   => '#D84315',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M12 21c4 0 6-3 6-7s-2-8-6-8-6 4-6 8 2 7 6 7z" fill="currentColor"/><path d="M12 6V3M11 4c-1-2 3-2 2 0" stroke="#1B5E20" stroke-width="1.5" stroke-linecap="round" fill="none"/></svg>',
            ],
            [
                'categorie' => 'epices',
                'nom'       => 'Ras el hanout',
                'couleur'   => '#6A1B9A',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><circle cx="12" cy="12" r="4" fill="currentColor"/><path d="M12 4v3M12 17v3M4 12h3M17 12h3M6.3 6.3l2.1 2.1M15.6 15.6l2.1 2.1M6.3 17.7l2.1-2.1M15.6 8.4l2.1-2.1" stroke="currentColor" stroke-width="1.8" stroke-linecap="round"/></svg>',
            ],
            [
                'categorie' => 'epices',
                'nom'       => 'Curcuma',
                'couleur'   => '#F9A825',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M6 18c2-4 4-8 6-10 2 2 4 6 6 10" fill="currentColor"/><path d="M9 18h6" stroke="#E65100" stroke-width="1.5" stroke-linecap="round"/><circle cx="12" cy="6" r="2" fill="currentColor"/></svg>',
            ],
            [
                'categorie' => 'epices',
                'nom'       => 'Coriandre',
                'couleur'   => '#2E7D32',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M12 20V8" stroke="currentColor" stroke-width="2" stroke-linecap="round"/><circle cx="9" cy="7" r="3" fill="currentColor"/><circle cx="15" cy="9" r="3" fill="currentColor"/><circle cx="10" cy="13" r="2.5" fill="currentColor"/></svg>',
            ],
            [
                'categorie' => 'epices',
                'nom'       => 'Persil',
                'couleur'   => '#388E3C',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M12 21V9" stroke="currentColor" stroke-width="2" stroke-linecap="round"/><path d="M12 13c-2-3-6-4-6-1 0 2 3 2 6 1z" fill="currentColor"/><path d="M12 9c2-3 6-4 6-1 0 2-3 2-6 1z" fill="currentColor"/></svg>',
            ],
            [
                'categorie' => 'epices',
                'nom'       => 'Gingembre',
                'couleur'   => '#F57F17',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M6 18c0 0 2-4 4-5s5 0 6-2 0-5-2-5-3 2-2 4" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" fill="none"/><circle cx="7" cy="18" r="2" fill="currentColor"/><circle cx="20" cy="10" r="2" fill="currentColor"/></svg>',
            ],
            [
                'categorie' => 'epices',
                'nom'       => 'Cannelle',
                'couleur'   => '#6D4C41',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M8 19c0-4 3-14 5-15" stroke="currentColor" stroke-width="3" stroke-linecap="round" fill="none"/><path d="M11 19c0-4 3-14 5-15" stroke="currentColor" stroke-width="3" stroke-linecap="round" fill="none"/></svg>',
            ],
            [
                'categorie' => 'epices',
                'nom'       => 'Safran',
                'couleur'   => '#FF8F00',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M12 20V10" stroke="currentColor" stroke-width="2" stroke-linecap="round"/><path d="M12 10c0-3-3-5-3-5s0 4 3 5z" fill="currentColor"/><path d="M12 10c0-3 3-5 3-5s0 4-3 5z" fill="currentColor"/><path d="M12 13c-3 0-5-3-5-3s4 0 5 3z" fill="currentColor"/><path d="M12 13c3 0 5-3 5-3s-4 0-5 3z" fill="currentColor"/></svg>',
            ],
            [
                'categorie' => 'epices',
                'nom'       => 'Poivre noir',
                'couleur'   => '#212121',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><circle cx="8" cy="14" r="2.5" fill="currentColor"/><circle cx="14" cy="11" r="2.5" fill="currentColor"/><circle cx="16" cy="16" r="2" fill="currentColor"/><circle cx="10" cy="17" r="1.8" fill="currentColor"/><circle cx="12" cy="8" r="2" fill="currentColor"/></svg>',
            ],

            // ─── Féculents ─────────────────────────────────────────────────────────
            [
                'categorie' => 'feculents',
                'nom'       => 'Semoule',
                'couleur'   => '#FDD835',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><rect x="4" y="14" width="16" height="6" rx="2" fill="currentColor"/><path d="M7 14c0-5 10-5 10 0" fill="currentColor"/><path d="M9 14c0-3 6-3 6 0" fill="#F9A825"/></svg>',
            ],
            [
                'categorie' => 'feculents',
                'nom'       => 'Riz',
                'couleur'   => '#F5F5F5',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><ellipse cx="8" cy="11" rx="2" ry="1" fill="currentColor" stroke="#BDBDBD" stroke-width="0.5"/><ellipse cx="12" cy="9" rx="2" ry="1" fill="currentColor" stroke="#BDBDBD" stroke-width="0.5"/><ellipse cx="16" cy="11" rx="2" ry="1" fill="currentColor" stroke="#BDBDBD" stroke-width="0.5"/><ellipse cx="10" cy="14" rx="2" ry="1" fill="currentColor" stroke="#BDBDBD" stroke-width="0.5"/><ellipse cx="14" cy="14" rx="2" ry="1" fill="currentColor" stroke="#BDBDBD" stroke-width="0.5"/><path d="M5 18h14" stroke="#9E9E9E" stroke-width="1.5" stroke-linecap="round"/></svg>',
            ],
            [
                'categorie' => 'feculents',
                'nom'       => 'Pâtes',
                'couleur'   => '#FBC02D',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M5 8c0 0 1 6 7 6s7-6 7-6" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" fill="none"/><path d="M8 8c0 0 0 4 4 4s4-4 4-4" stroke="currentColor" stroke-width="2" stroke-linecap="round" fill="none"/><path d="M4 17h16" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"/></svg>',
            ],
            [
                'categorie' => 'feculents',
                'nom'       => 'Farine',
                'couleur'   => '#EFEBE9',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M8 5h8l2 14H6L8 5z" fill="currentColor" stroke="#BCAAA4" stroke-width="1"/><path d="M10 5V3h4v2" stroke="#BCAAA4" stroke-width="1.2" stroke-linecap="round" stroke-linejoin="round" fill="none"/><path d="M9 10h6M9 13h6" stroke="#BCAAA4" stroke-width="1" opacity="0.5"/></svg>',
            ],
            [
                'categorie' => 'feculents',
                'nom'       => 'Pain',
                'couleur'   => '#FF8F00',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M4 13c0-4 2-7 8-7s8 3 8 7v4H4v-4z" fill="currentColor"/><path d="M4 17h16" stroke="#E65100" stroke-width="1"/><path d="M8 9c0-1 2-2 4-2" stroke="white" stroke-width="1" opacity="0.4" stroke-linecap="round"/></svg>',
            ],

            // ─── Produits laitiers ─────────────────────────────────────────────────
            [
                'categorie' => 'produits-laitiers',
                'nom'       => 'Lait',
                'couleur'   => '#E3F2FD',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M8 3h8l2 5v11H6V8L8 3z" fill="currentColor" stroke="#90CAF9" stroke-width="1"/><path d="M6 8h12" stroke="#90CAF9" stroke-width="1"/><path d="M9 12c1 1 5 1 6 0" stroke="#BBDEFB" stroke-width="1.2" stroke-linecap="round"/></svg>',
            ],
            [
                'categorie' => 'produits-laitiers',
                'nom'       => 'Beurre',
                'couleur'   => '#FDD835',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><rect x="3" y="9" width="18" height="10" rx="2" fill="currentColor"/><rect x="3" y="9" width="18" height="3" rx="2" fill="#F9A825"/><path d="M7 14h10" stroke="#F57F17" stroke-width="1" opacity="0.5"/></svg>',
            ],
            [
                'categorie' => 'produits-laitiers',
                'nom'       => 'Fromage',
                'couleur'   => '#FFB300',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M3 16l9-10 9 10v3H3v-3z" fill="currentColor"/><circle cx="11" cy="14" r="1.5" fill="#FF8F00"/><circle cx="15" cy="12" r="1" fill="#FF8F00"/></svg>',
            ],
            [
                'categorie' => 'produits-laitiers',
                'nom'       => 'Yaourt',
                'couleur'   => '#F3E5F5',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M7 6h10v2l1 12H6L7 8V6z" fill="currentColor" stroke="#CE93D8" stroke-width="1"/><path d="M7 8h10" stroke="#CE93D8" stroke-width="1"/><path d="M10 6V4h4v2" stroke="#CE93D8" stroke-width="1.2" stroke-linecap="round" stroke-linejoin="round" fill="none"/></svg>',
            ],
            [
                'categorie' => 'produits-laitiers',
                'nom'       => 'Crème fraîche',
                'couleur'   => '#FFF9C4',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><ellipse cx="12" cy="12" rx="9" ry="6" fill="currentColor" stroke="#F9A825" stroke-width="1"/><path d="M6 11c2-2 4-2 6 0s4 2 6 0" stroke="#FDD835" stroke-width="1.2" stroke-linecap="round" fill="none"/></svg>',
            ],

            // ─── Fruits ────────────────────────────────────────────────────────────
            [
                'categorie' => 'fruits',
                'nom'       => 'Citron',
                'couleur'   => '#FDD835',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><ellipse cx="12" cy="13" rx="8" ry="7" fill="currentColor"/><path d="M12 6V4M10 5l2-2 2 2" stroke="#F9A825" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M12 9v8M8 13h8" stroke="white" stroke-width="1" opacity="0.3"/></svg>',
            ],
            [
                'categorie' => 'fruits',
                'nom'       => 'Oranges',
                'couleur'   => '#FB8C00',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><circle cx="12" cy="13" r="8" fill="currentColor"/><path d="M12 5V3M10 4l2-2 2 2" stroke="#2E7D32" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M12 8v10M7 13h10" stroke="white" stroke-width="1" opacity="0.3"/></svg>',
            ],
            [
                'categorie' => 'fruits',
                'nom'       => 'Dattes',
                'couleur'   => '#4E342E',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><ellipse cx="10" cy="14" rx="4" ry="6" fill="currentColor"/><ellipse cx="16" cy="13" rx="3.5" ry="5.5" fill="currentColor"/><path d="M10 8V4M10 4c0-2 3-2 3 0" stroke="#795548" stroke-width="1.5" stroke-linecap="round" fill="none"/></svg>',
            ],
            [
                'categorie' => 'fruits',
                'nom'       => 'Figues',
                'couleur'   => '#6A1B9A',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M12 21c4 0 6-3 6-7s-4-8-6-8-6 4-6 8 2 7 6 7z" fill="currentColor"/><path d="M12 6V3" stroke="#2E7D32" stroke-width="1.8" stroke-linecap="round"/><path d="M12 11v5" stroke="#CE93D8" stroke-width="1" stroke-linecap="round" opacity="0.6"/></svg>',
            ],
            [
                'categorie' => 'fruits',
                'nom'       => 'Olives',
                'couleur'   => '#558B2F',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><ellipse cx="9" cy="13" rx="4" ry="5" fill="currentColor"/><ellipse cx="16" cy="12" rx="3.5" ry="4.5" fill="currentColor"/><circle cx="9" cy="12" r="1.5" fill="#1B5E20"/><circle cx="16" cy="11" r="1.2" fill="#1B5E20"/></svg>',
            ],

            // ─── Huiles & Sauces ───────────────────────────────────────────────────
            [
                'categorie' => 'huiles',
                'nom'       => "Huile d'olive",
                'couleur'   => '#AFB42B',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M10 3h4l2 5v12H8V8L10 3z" fill="currentColor" stroke="#827717" stroke-width="0.8"/><path d="M8 8h8" stroke="#827717" stroke-width="1"/><path d="M12 11v5" stroke="#827717" stroke-width="1" stroke-linecap="round"/></svg>',
            ],
            [
                'categorie' => 'huiles',
                'nom'       => 'Huile de tournesol',
                'couleur'   => '#FDD835',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><circle cx="12" cy="10" r="3" fill="#F57F17"/><path d="M12 4v2M12 14v2M6 10H4M18 10h2M7.8 5.8l1.4 1.4M14.8 12.8l1.4 1.4M7.8 14.2l1.4-1.4M14.8 7.2l1.4-1.4" stroke="currentColor" stroke-width="2" stroke-linecap="round"/><path d="M10 18h4l1 3H9l1-3z" fill="currentColor"/></svg>',
            ],
            [
                'categorie' => 'huiles',
                'nom'       => 'Concentré de tomate',
                'couleur'   => '#B71C1C',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M8 5h8l1 14H7L8 5z" fill="currentColor" stroke="#7F0000" stroke-width="0.8"/><path d="M9 5V3h6v2" stroke="#7F0000" stroke-width="1.2" stroke-linecap="round" stroke-linejoin="round" fill="none"/><path d="M9 10c2 2 5 2 6 0" stroke="#FF5252" stroke-width="1" stroke-linecap="round" opacity="0.6"/></svg>',
            ],
            [
                'categorie' => 'huiles',
                'nom'       => 'Chermoula',
                'couleur'   => '#2E7D32',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M6 19l3-8 3 3 3-6 3 11" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" fill="none"/><path d="M4 19h16" stroke="currentColor" stroke-width="2" stroke-linecap="round"/></svg>',
            ],
            [
                'categorie' => 'huiles',
                'nom'       => 'Harissa',
                'couleur'   => '#E53935',
                'svgIcon'   => '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M12 20c0 0-7-5-7-11 0-4 3-6 7-6s7 2 7 6c0 6-7 11-7 11z" fill="currentColor"/><path d="M9 9c1-2 5-2 6 0" stroke="#FF8F00" stroke-width="1.2" stroke-linecap="round" opacity="0.7"/><path d="M10 13c1-1 4-1 4 0" stroke="#FF8F00" stroke-width="1" stroke-linecap="round" opacity="0.5"/></svg>',
            ],
        ];

        foreach ($ingredients as $item) {
            $categorie = Categorie::where('slug', $item['categorie'])->first();

            if (! $categorie) {
                $this->command->warn("Catégorie introuvable pour le slug : {$item['categorie']}");
                continue;
            }

            DB::table('ingredients')->updateOrInsert(
                ['nom' => $item['nom']],
                [
                    'categorie_id' => $categorie->id,
                    'svgIcon'      => $item['svgIcon'],
                    'couleur'      => $item['couleur'],
                    'updated_at'   => now(),
                    'created_at'   => now(),
                ]
            );
        }

        $this->command->info('✅ Ingrédients seedés avec succès (' . count($ingredients) . ' entrées).');
    }
}
