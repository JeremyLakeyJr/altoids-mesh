// =============================================================================
// Altoids Mesh Enclosure — Bottom Case
// =============================================================================
// Shallow tray (like the bottom of a real Altoids tin) that holds the
// battery, Heltec V4, and internal antenna.  The lid skirt slides over
// the top of these walls.
//
// Features:  battery compartment · Heltec mounting standoffs · USB-C &
//            antenna port cutouts · ventilation slots · hinge knuckles ·
//            internal antenna channel · corner screw bosses
// =============================================================================

include <parameters.scad>

// =========================================================================
//  Helper Modules
// =========================================================================

// Rounded rectangle (origin at corner, Z-up)
module rrect(size, r) {
    hull() {
        for (dx = [r, size[0] - r], dy = [r, size[1] - r])
            translate([dx, dy, 0])
                cylinder(r = r, h = size[2], $fn = 36);
    }
}

// Array of ventilation slots centred at origin
module vent_slots(n, len, w, spacing) {
    tw = n * w + (n - 1) * spacing;
    for (i = [0 : n - 1])
        translate([0, i * (w + spacing) - tw / 2, 0])
            cube([len, w, wall * 3], center = true);
}

// ----- Battery Retainer Clip -------------------------------------------------
module battery_retainer() {
    clip_h  = batt_ht * 0.6;
    clip_t  = 1.5;
    clip_oh = 2.0;
    cube([clip_t, batt_wid + fit_clearance * 2, clip_h]);
    translate([0, 0, clip_h])
        cube([clip_oh, batt_wid + fit_clearance * 2, clip_t]);
}

// ----- Hinge Knuckle (case side) ---------------------------------------------
// Barrel with paper-clip pin hole + support arm toward case interior.
module case_hinge_knuckle(x_pos, klen) {
    barrel_r = hinge_barrel_d / 2;
    translate([x_pos, case_ext_wid, case_ext_depth]) {
        difference() {
            union() {
                // Barrel along X
                rotate([0, 90, 0])
                    cylinder(d = hinge_barrel_d, h = klen, $fn = 24);
                // Arm connecting barrel to case wall (extends -Y, -Z)
                translate([0, -hinge_arm_t, -barrel_r])
                    cube([klen, hinge_arm_t, barrel_r]);
            }
            // Pin hole (paper-clip clearance)
            translate([-0.1, 0, 0])
                rotate([0, 90, 0])
                    cylinder(d = hinge_pin_d + tolerance * 2,
                             h = klen + 0.2, $fn = 24);
        }
    }
}

// =========================================================================
//  Main Bottom Case
// =========================================================================
module bottom_case() {
    difference() {
        union() {
            // ----------------------------------------------------------
            //  Outer shell
            // ----------------------------------------------------------
            rrect([case_ext_len, case_ext_wid, case_ext_depth], corner_r);

            // ----------------------------------------------------------
            //  Battery compartment rails
            // ----------------------------------------------------------
            translate([wall + batt_pos_x - 1.5,
                       wall + batt_pos_y - 1.5, 0]) {
                // Left rail
                cube([batt_len + batt_wire_clr + 3, 1.5,
                      floor_t + batt_ht * 0.7]);
                // Right rail
                translate([0, batt_wid + fit_clearance * 2 + 1.5, 0])
                    cube([batt_len + batt_wire_clr + 3, 1.5,
                          floor_t + batt_ht * 0.7]);
                // Back wall
                translate([-0.5, 0, 0])
                    cube([2.0, batt_wid + fit_clearance * 2 + 3,
                          floor_t + batt_ht * 0.7]);
            }

            // Battery retainer clip (front)
            translate([wall + batt_pos_x + batt_len + batt_wire_clr + 1,
                       wall + batt_pos_y - 1.5, 0]) {
                ch = batt_ht * 0.6;
                ct = 1.5;
                co = 2.0;
                cube([ct, batt_wid + fit_clearance * 2,
                      floor_t + ch]);
                translate([0, 0, floor_t + ch])
                    cube([co, batt_wid + fit_clearance * 2, ct]);
            }

            // ----------------------------------------------------------
            //  Heltec V4 mounting standoffs
            // ----------------------------------------------------------
            mount_pts = [
                [2.5, 2.5],
                [heltec_len - 2.5, 2.5],
                [2.5, heltec_wid - 2.5],
                [heltec_len - 2.5, heltec_wid - 2.5]
            ];
            for (p = mount_pts)
                translate([wall + heltec_pos_x + p[0],
                           wall + heltec_pos_y + p[1], 0])
                    cylinder(d = screw_boss_d - 1,
                             h = floor_t + heltec_standoff, $fn = 24);

            // ----------------------------------------------------------
            //  Corner screw bosses
            // ----------------------------------------------------------
            screw_pts = [
                [wall + 4, wall + 4],
                [case_ext_len - wall - 4, wall + 4],
                [wall + 4, case_ext_wid - wall - 4],
                [case_ext_len - wall - 4, case_ext_wid - wall - 4]
            ];
            for (p = screw_pts)
                translate([p[0], p[1], 0])
                    cylinder(d = screw_boss_d,
                             h = case_ext_depth, $fn = 24);

            // ----------------------------------------------------------
            //  Cable channel (between battery and Heltec)
            // ----------------------------------------------------------
            translate([wall + batt_pos_x + batt_len,
                       wall + batt_pos_y + batt_wid - 2, 0])
                cube([3,
                      heltec_pos_y - batt_pos_y - batt_wid + 4,
                      floor_t + 2]);

            // ----------------------------------------------------------
            //  Hinge knuckles  (case gets knuckles 0, 2, 4)
            // ----------------------------------------------------------
            for (i = [0, 2, 4]) {
                xp = hinge_margin + i * (hinge_knuckle_l + hinge_gap);
                case_hinge_knuckle(xp, hinge_knuckle_l);
            }

            // ----------------------------------------------------------
            //  Internal antenna housing channel
            // ----------------------------------------------------------
            translate([wall + ant_pos_x, wall, 0]) {
                // Retaining rail
                translate([0, ant_chan_w, 0])
                    cube([ant_len, ant_rail_t,
                          floor_t + ant_chan_d]);
                // End walls
                cube([ant_rail_t,
                      ant_chan_w + ant_rail_t,
                      floor_t + ant_chan_d]);
                translate([ant_len - ant_rail_t, 0, 0])
                    cube([ant_rail_t,
                          ant_chan_w + ant_rail_t,
                          floor_t + ant_chan_d]);
                // Retention clips
                for (i = [0 : ant_clip_n - 1]) {
                    cx = ant_len * (i + 1) / (ant_clip_n + 1)
                         - ant_clip_w / 2;
                    translate([cx, ant_rail_t + ant_clip_ins,
                               floor_t + ant_chan_d])
                        cube([ant_clip_w, ant_chan_w, ant_rail_t]);
                }
            }
        }

        // ==============================================================
        //  Subtractive features
        // ==============================================================

        // Hollow interior
        translate([wall, wall, floor_t])
            rrect([int_len, int_wid, case_int_depth + 1],
                  corner_r - wall);

        // USB-C port cutout
        translate([wall + heltec_pos_x + heltec_len - 1,
                   wall + heltec_pos_y + heltec_usbc_off_y
                       - usbc_cut_w / 2,
                   floor_t + heltec_standoff + heltec_pcb_t])
            cube([wall + 2, usbc_cut_w, usbc_cut_h]);

        // SMA antenna port cutout
        translate([-1,
                   wall + heltec_pos_y + heltec_wid / 2,
                   floor_t + heltec_standoff + heltec_ht + 1])
            rotate([0, 90, 0])
                cylinder(d = antenna_cut_d, h = wall + 2, $fn = 24);

        // Side ventilation (battery side)
        translate([case_ext_len / 2, wall / 2,
                   floor_t + case_int_depth / 2])
            rotate([90, 0, 0])
                vent_slots(vent_count, vent_len, vent_w, vent_space);

        // Bottom ventilation (under battery)
        translate([wall + batt_pos_x + batt_len / 2,
                   wall + batt_pos_y + batt_wid / 2,
                   floor_t / 2])
            vent_slots(3, batt_len * 0.6, vent_w, vent_space * 1.5);

        // Charging LED window
        translate([case_ext_len - wall - 1,
                   wall + heltec_pos_y + heltec_usbc_off_y + usbc_cut_w,
                   floor_t + heltec_standoff + heltec_pcb_t + 1])
            cube([wall + 2, 2.0, 2.0]);

        // Heltec mounting screw holes
        for (p = [ [2.5, 2.5],
                   [heltec_len - 2.5, 2.5],
                   [2.5, heltec_wid - 2.5],
                   [heltec_len - 2.5, heltec_wid - 2.5] ])
            translate([wall + heltec_pos_x + p[0],
                       wall + heltec_pos_y + p[1], -0.1])
                cylinder(d = heltec_mount_hole,
                         h = floor_t + heltec_standoff + 0.2, $fn = 24);

        // Corner screw holes
        for (p = [ [wall + 4, wall + 4],
                   [case_ext_len - wall - 4, wall + 4],
                   [wall + 4, case_ext_wid - wall - 4],
                   [case_ext_len - wall - 4, case_ext_wid - wall - 4] ])
            translate([p[0], p[1], -0.1])
                cylinder(d = screw_d,
                         h = case_ext_depth + 0.2, $fn = 24);
    }
}

// Render when opened directly
bottom_case();
