// =============================================================================
// Altoids Mesh Enclosure - Main Assembly
// =============================================================================
// Complete assembly view combining bottom case, top lid, and component models.
// Use this file to visualize the full enclosure with components.
//
// IMPORTANT: All companion files must be in the same directory as this file:
//   - parameters.scad   (shared dimensions and configuration)
//   - bottom_case.scad   (bottom half of enclosure)
//   - top_lid.scad       (top lid with CardKB mount)
//   - components.scad    (visual component models)
//
// Render modes (uncomment one):
//   - Assembly view: see everything together
//   - Exploded view: parts separated for inspection
//   - Print layout: parts arranged flat for 3D printing
// =============================================================================

include <parameters.scad>

// ---- Render Mode Selection ----
// Change this value to switch views:
//   0 = Assembly (closed)
//   1 = Exploded view
//   2 = Print layout (parts flat on build plate)
render_mode = 1;

// Exploded view separation distance
explode_distance = 30;

// ---- Import Modules ----
use <bottom_case.scad>
use <top_lid.scad>
use <components.scad>

// Show/hide component models (for visualization only)
show_components = true;

// ---- Assembly View ----
module assembly_view() {
    // Bottom case
    bottom_case();

    // Top lid (flipped and placed on top)
    translate([0, 0, case_external_depth + lid_external_depth])
        rotate([180, 0, 0])
        translate([0, -external_width, 0])
        top_lid();

    // Component models
    if (show_components) {
        color("green", 0.5) {
            translate([wall_thickness, wall_thickness, 0])
                component_assembly();
        }
    }
}

// ---- Exploded View ----
module exploded_view() {
    // Bottom case
    bottom_case();

    // Top lid (separated above)
    translate([0, 0, case_external_depth + explode_distance + lid_external_depth])
        rotate([180, 0, 0])
        translate([0, -external_width, 0])
        top_lid();

    // Component models (separated between case and lid)
    if (show_components) {
        translate([wall_thickness, wall_thickness, 0]) {
            // Battery
            translate([battery_pos_x, battery_pos_y, battery_pos_z + explode_distance * 0.3])
                battery_3000mah();

            // Heltec V4
            translate([heltec_pos_x, heltec_pos_y, heltec_pos_z + explode_distance * 0.5])
                heltec_v4();

            // CardKB
            translate([cardkb_pos_x, cardkb_pos_y,
                       case_external_depth + explode_distance * 0.7 + 5])
                cardkb_unit();

            // Internal Antenna
            translate([antenna_channel_pos_x, antenna_channel_pos_y,
                       floor_thickness + explode_distance * 0.2])
                internal_antenna();
        }
    }
}

// ---- Print Layout ----
module print_layout() {
    // Bottom case - as is
    bottom_case();

    // Top lid - placed next to bottom case, upside down for printing
    translate([external_length + 10, 0, 0])
        top_lid();
}

// ---- Render Selected Mode ----
if (render_mode == 0) {
    assembly_view();
} else if (render_mode == 1) {
    exploded_view();
} else if (render_mode == 2) {
    print_layout();
}

// ---- Dimension Annotations (console output) ----
echo(str("=== Altoids Mesh Enclosure Dimensions ==="));
echo(str("External: ", external_length, " x ", external_width, " x ", total_height, " mm"));
echo(str("Internal: ", internal_length, " x ", internal_width, " mm"));
echo(str("Case depth: ", case_external_depth, " mm"));
echo(str("Lid depth: ", lid_external_depth, " mm"));
echo(str("Wall thickness: ", wall_thickness, " mm"));
echo(str("Standard Altoids tin: 95.5 x 60 x 21.5 mm (for reference)"));
