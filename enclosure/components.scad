// =============================================================================
// Altoids Mesh Enclosure — Component Models
// =============================================================================
// Approximate shapes of the real components for fit-check visualisation.
// These are NOT part of the printable enclosure.
// =============================================================================

include <parameters.scad>

// ----- Heltec WiFi LoRa 32 V4 ------------------------------------------------
module heltec_v4() {
    color("darkgreen", 0.8) {
        // PCB
        cube([heltec_len, heltec_wid, heltec_pcb_t]);
        // Components on top
        translate([2, 2, heltec_pcb_t])
            cube([heltec_len - 4, heltec_wid - 4,
                  heltec_ht - heltec_pcb_t]);
    }
    // OLED display
    color("black", 0.9)
        translate([heltec_oled_off_x, heltec_oled_off_y, heltec_ht - 0.5])
            cube([heltec_oled_w, heltec_oled_h, 0.5]);
    // USB-C port
    color("silver", 0.9)
        translate([heltec_len - 1,
                   heltec_usbc_off_y - heltec_usbc_w / 2,
                   heltec_pcb_t])
            cube([3, heltec_usbc_w, heltec_usbc_h]);
    // SMA antenna connector
    color("gold", 0.9)
        translate([1, heltec_wid / 2, heltec_ht])
            cylinder(d = heltec_antenna_dia, h = 3, $fn = 24);
}

// ----- Heltec WiFi LoRa 32 V3 ------------------------------------------------
module heltec_v3() {
    color("darkgreen", 0.8) {
        // PCB
        cube([heltec_len, heltec_wid, heltec_pcb_t]);
        // Components on top (taller LoRa module)
        translate([2, 2, heltec_pcb_t])
            cube([heltec_len - 4, heltec_wid - 4,
                  heltec_ht - heltec_pcb_t]);
    }
    // OLED display
    color("black", 0.9)
        translate([heltec_oled_off_x, heltec_oled_off_y, heltec_ht - 0.5])
            cube([heltec_oled_w, heltec_oled_h, 0.5]);
    // USB-C port
    color("silver", 0.9)
        translate([heltec_len - 1,
                   heltec_usbc_off_y - heltec_usbc_w / 2,
                   heltec_pcb_t])
            cube([3, heltec_usbc_w, heltec_usbc_h]);
    // IPEX / U.FL antenna connector (much smaller than SMA)
    color("gold", 0.9)
        translate([1, heltec_wid / 2, heltec_ht])
            cylinder(d = heltec_antenna_dia, h = 1.5, $fn = 24);
}

// ----- M5Stack CardKB Unit 1.1 -----------------------------------------------
module cardkb_unit() {
    color("dimgray", 0.8)
        cube([cardkb_len, cardkb_wid, cardkb_ht]);
    // Key area
    color("darkslategray", 0.9)
        translate([5, 5, cardkb_ht])
            cube([cardkb_len - 10, cardkb_wid - 10, 0.5]);
    // Grove connector
    color("white", 0.9)
        translate([cardkb_cable_off - cardkb_cable_w / 2, -2, 1])
            cube([cardkb_cable_w, 4, 3]);
}

// ----- MakerFocus 3000 mAh Battery -------------------------------------------
module battery_3000mah() {
    color("steelblue", 0.7)
        cube([batt_len, batt_wid, batt_ht]);
    // Wire leads
    color("red", 0.9)
        translate([batt_len, batt_wid / 2 - 2, batt_ht / 2])
            rotate([0, 90, 0])
                cylinder(d = 1.5, h = batt_wire_clr, $fn = 12);
    color("black", 0.9)
        translate([batt_len, batt_wid / 2 + 2, batt_ht / 2])
            rotate([0, 90, 0])
                cylinder(d = 1.5, h = batt_wire_clr, $fn = 12);
}

// ----- Internal LoRa Wire Antenna --------------------------------------------
module internal_antenna() {
    color("silver", 0.9) {
        translate([2, ant_chan_w / 2, 1])
            rotate([0, 90, 0])
                cylinder(d = 1.0, h = ant_len - 4, $fn = 12);
        translate([-1, 0, 0])
            cube([3, ant_chan_w, 2.5]);
    }
}

// ----- Paper-Clip Hinge Pin --------------------------------------------------
module hinge_pin() {
    color("silver", 0.8)
        translate([hinge_margin - 2, 0, 0])
            rotate([0, 90, 0])
                cylinder(d = hinge_pin_d, h = hinge_span + 4, $fn = 16);
}

// ----- Full Component Assembly (for preview) ---------------------------------
module component_assembly() {
    // Battery
    translate([batt_pos_x, batt_pos_y, batt_pos_z])
        battery_3000mah();
    // Heltec board (V3 or V4 based on board_version)
    translate([heltec_pos_x, heltec_pos_y, heltec_pos_z])
        if (board_version == 3) heltec_v3();
        else                    heltec_v4();
    // CardKB (shown above case for reference)
    translate([cardkb_pos_x, cardkb_pos_y,
               case_ext_depth + lid_ext_depth + 2])
        cardkb_unit();
    // Internal LoRa antenna
    translate([ant_pos_x, ant_pos_y, floor_t])
        internal_antenna();
}

// Preview when opened directly
component_assembly();
