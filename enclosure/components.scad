// =============================================================================
// Altoids Mesh Enclosure - Component Models
// =============================================================================
// Visual reference models for fit verification. These are approximate shapes
// of the actual components and are NOT part of the printable enclosure.
// =============================================================================

include <parameters.scad>

// ---- Heltec V4 Module ----
module heltec_v4() {
    color("darkgreen", 0.8) {
        // PCB
        cube([heltec_length, heltec_width, heltec_pcb_thickness]);

        // Components on top of PCB
        translate([2, 2, heltec_pcb_thickness])
            cube([heltec_length - 4, heltec_width - 4, heltec_height - heltec_pcb_thickness]);

        // OLED display
        color("black", 0.9)
        translate([heltec_oled_offset_x, heltec_oled_offset_y, heltec_height - 0.5])
            cube([heltec_oled_width, heltec_oled_height, 0.5]);

        // USB-C port
        color("silver", 0.9)
        translate([heltec_length - 1, heltec_usbc_offset_y - heltec_usbc_width / 2, heltec_pcb_thickness])
            cube([3, heltec_usbc_width, heltec_usbc_height]);
    }

    // Antenna connector
    color("gold", 0.9)
    translate([1, heltec_width / 2, heltec_height])
        cylinder(d = heltec_antenna_dia, h = 3, $fn = 24);
}

// ---- CardKB Unit 1.1 ----
module cardkb_unit() {
    color("dimgray", 0.8) {
        // Main body
        cube([cardkb_length, cardkb_width, cardkb_height]);

        // Key area (slightly raised for visualization)
        color("darkslategray", 0.9)
        translate([5, 5, cardkb_height])
            cube([cardkb_length - 10, cardkb_width - 10, 0.5]);

        // Grove connector
        color("white", 0.9)
        translate([cardkb_cable_offset - cardkb_cable_width / 2, -2, 1])
            cube([cardkb_cable_width, 4, 3]);
    }
}

// ---- MakerFocus 3000mAh Battery ----
module battery_3000mah() {
    color("steelblue", 0.7) {
        // Battery body
        cube([battery_length, battery_width, battery_height]);

        // Wire leads
        color("red", 0.9)
        translate([battery_length, battery_width / 2 - 2, battery_height / 2])
            rotate([0, 90, 0])
            cylinder(d = 1.5, h = battery_wire_clearance, $fn = 12);

        color("black", 0.9)
        translate([battery_length, battery_width / 2 + 2, battery_height / 2])
            rotate([0, 90, 0])
            cylinder(d = 1.5, h = battery_wire_clearance, $fn = 12);
    }
}

// ---- Internal LoRa Antenna (wire type) ----
module internal_antenna() {
    color("silver", 0.9) {
        // Wire antenna element
        translate([2, antenna_housing_width / 2, 1])
            rotate([0, 90, 0])
            cylinder(d = 1.0, h = antenna_housing_length - 4, $fn = 12);
        // SMA pigtail connector end
        translate([-1, 0, 0])
            cube([3, antenna_housing_width, 2.5]);
    }
}

// ---- Assembly Preview ----
module component_assembly() {
    // Battery
    translate([battery_pos_x, battery_pos_y, battery_pos_z])
        battery_3000mah();

    // Heltec V4
    translate([heltec_pos_x, heltec_pos_y, heltec_pos_z])
        heltec_v4();

    // CardKB (shown above case for reference)
    translate([cardkb_pos_x, cardkb_pos_y, case_external_depth + lid_external_depth + 2])
        cardkb_unit();

    // Internal LoRa antenna
    translate([antenna_channel_pos_x, antenna_channel_pos_y, floor_thickness])
        internal_antenna();
}

// Preview when opened directly
component_assembly();
