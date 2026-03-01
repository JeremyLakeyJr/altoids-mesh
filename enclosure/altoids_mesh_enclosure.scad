// =============================================================================
// Altoids Mesh Enclosure — Main Assembly
// =============================================================================
// Open this file in OpenSCAD to see the complete enclosure with components.
//
// Render modes (change render_mode below):
//   0 = Assembled (closed)
//   1 = Exploded view   (default)
//   2 = Print layout     (parts flat on build plate)
//   3 = Laptop open      (lid hinged open)
//
// Companion files (must be in the same directory):
//   parameters.scad   — shared dimensions / configuration
//   bottom_case.scad  — bottom half of the enclosure
//   top_lid.scad      — top lid (Altoids-style overlapping)
//   components.scad   — visual component models
// =============================================================================

include <parameters.scad>

// =====================================================================
//  Render Settings
// =====================================================================
render_mode     = 1;      // 0 assembled · 1 exploded · 2 print · 3 laptop
show_components = true;   // toggle component ghost models
explode_dist    = 30;     // separation for exploded view  (mm)
laptop_angle    = 110;    // lid opening angle for laptop view (°)

// =====================================================================
//  Import Part Modules
// =====================================================================
use <bottom_case.scad>
use <top_lid.scad>
use <components.scad>

// Offset from case origin to lid origin (the lid is wider by lid_off
// on each side so that the skirt overlaps the case walls).
lid_off = lid_wall + snap_clearance;

// =====================================================================
//  Assembly Views
// =====================================================================

// ----- Closed assembly -----------------------------------------------
module assembly_view() {
    // Bottom case
    bottom_case();

    // Top lid — flipped and placed on top, offset inward by lid_off
    translate([-lid_off, -lid_off,
               case_ext_depth + lid_top_t + lid_overlap])
        rotate([180, 0, 0])
            translate([0, -lid_ext_wid, 0])
                top_lid();

    if (show_components)
        color("green", 0.5)
            translate([wall, wall, 0])
                component_assembly();
}

// ----- Exploded view -------------------------------------------------
module exploded_view() {
    bottom_case();

    translate([-lid_off, -lid_off,
               case_ext_depth + explode_dist
                   + lid_top_t + lid_overlap])
        rotate([180, 0, 0])
            translate([0, -lid_ext_wid, 0])
                top_lid();

    if (show_components)
        translate([wall, wall, 0]) {
            translate([batt_pos_x, batt_pos_y,
                       batt_pos_z + explode_dist * 0.3])
                battery_3000mah();
            translate([heltec_pos_x, heltec_pos_y,
                       heltec_pos_z + explode_dist * 0.5])
                heltec_v4();
            translate([cardkb_pos_x, cardkb_pos_y,
                       case_ext_depth + explode_dist * 0.7 + 5])
                cardkb_unit();
            translate([ant_pos_x, ant_pos_y,
                       floor_t + explode_dist * 0.2])
                internal_antenna();
        }
}

// ----- Print layout --------------------------------------------------
module print_layout() {
    bottom_case();
    translate([case_ext_len + 10, 0, 0])
        top_lid();
}

// ----- Laptop (lid hinged open) --------------------------------------
module laptop_view() {
    bottom_case();

    // Pivot around the hinge axis at the back edge of the case
    translate([0, case_ext_wid, case_ext_depth])
        rotate([-laptop_angle, 0, 0])
            translate([0, -case_ext_wid, -case_ext_depth])
                // Closed-lid position
                translate([-lid_off, -lid_off,
                           case_ext_depth + lid_top_t + lid_overlap])
                    rotate([180, 0, 0])
                        translate([0, -lid_ext_wid, 0])
                            top_lid();

    if (show_components)
        color("green", 0.5)
            translate([wall, wall, 0])
                component_assembly();
}

// =====================================================================
//  Render Selected Mode
// =====================================================================
if      (render_mode == 0) assembly_view();
else if (render_mode == 1) exploded_view();
else if (render_mode == 2) print_layout();
else if (render_mode == 3) laptop_view();

// =====================================================================
//  Console Dimension Summary
// =====================================================================
echo(str("=== Altoids Mesh Enclosure ==="));
echo(str("Board      : Heltec WiFi LoRa 32 V", board_version));
echo(str("Case outer : ", case_ext_len, " × ", case_ext_wid,
         " × ", case_ext_depth, " mm"));
echo(str("Lid  outer : ", lid_ext_len,  " × ", lid_ext_wid,
         " × ", lid_ext_depth,  " mm"));
echo(str("Total height (closed): ", total_height, " mm"));
echo(str("Hinge pin  : paper clip  ø", hinge_pin_d, " mm"));
echo(str("(Real Altoids tin ≈ 95.5 × 60 × 21.5 mm for reference)"));
