// =============================================================================
// Altoids Mesh Enclosure — Top Lid
// =============================================================================
// Overlapping lid that slides over the bottom-case walls — just like a
// real Altoids tin.  Houses the CardKB keyboard and has an OLED display
// window.
//
// Features:  overlapping skirt · embossed label panel · friction-fit
//            bump at front edge · CardKB mounting ledges & retention
//            clips · OLED display window · hinge knuckles (paper-clip pin)
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

// CardKB retention clip
module cardkb_clip(len) {
    ch  = 3.0;   // clip height
    ct  = 1.0;   // clip thickness
    coh = 1.2;   // overhang
    cube([len, ct, ch]);
    translate([-coh, 0, ch - ct])
        cube([len + coh * 2, ct, ct]);
}

// ----- Lid Hinge Knuckle (lid side) ------------------------------------------
// In lid-local coordinates the hinge axis is at Y = 0, Z = lid_ext_depth
// (maps to the back-edge hinge axis when the lid is flipped in assembly).
module lid_hinge_knuckle(x_pos, klen) {
    barrel_r = hinge_barrel_d / 2;
    translate([x_pos, 0, lid_ext_depth]) {
        difference() {
            union() {
                rotate([0, 90, 0])
                    cylinder(d = hinge_barrel_d, h = klen, $fn = 24);
                // Arm toward lid body (+Y)
                translate([0, 0, -barrel_r])
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
//  Main Top Lid
// =========================================================================
module top_lid() {
    // Offsets caused by the wider lid vs case
    lid_off = lid_wall + snap_clearance;   // extra width per side

    difference() {
        union() {
            // ----------------------------------------------------------
            //  Outer shell  (top plate + skirt walls)
            // ----------------------------------------------------------
            // Top plate at full lid footprint
            rrect([lid_ext_len, lid_ext_wid, lid_top_t],
                  corner_r + lid_off);

            // Skirt (short walls that slide over the case)
            difference() {
                rrect([lid_ext_len, lid_ext_wid, lid_top_t + lid_overlap],
                      corner_r + lid_off);
                // Hollow out the interior of the skirt
                translate([lid_wall, lid_wall, -0.1])
                    rrect([lid_ext_len - lid_wall * 2,
                           lid_ext_wid - lid_wall * 2,
                           lid_top_t + lid_overlap + 0.2],
                          corner_r + lid_off - lid_wall);
            }

            // Interior pocket walls (for CardKB recess depth)
            translate([lid_off, lid_off, lid_top_t])
                difference() {
                    rrect([case_ext_len, case_ext_wid, lid_int_depth],
                          corner_r);
                    translate([wall, wall, -0.1])
                        rrect([int_len, int_wid, lid_int_depth + 0.2],
                              max(0.5, corner_r - wall));
                }

            // ----------------------------------------------------------
            //  Friction-fit bump on front skirt (Altoids-style catch)
            // ----------------------------------------------------------
            translate([lid_ext_len / 2 - friction_bump_w / 2,
                       0,
                       lid_top_t + lid_overlap * 0.4])
                cube([friction_bump_w, lid_wall + friction_bump_h,
                      lid_overlap * 0.3]);

            // ----------------------------------------------------------
            //  CardKB support ledges
            // ----------------------------------------------------------
            kb_ledge_h = lid_int_depth - cardkb_ht;

            // Left ledge
            translate([lid_off + wall + cardkb_pos_x - 0.5,
                       lid_off + wall + cardkb_pos_y - 0.5,
                       lid_top_t])
                cube([cardkb_len + 1, 1.5, kb_ledge_h]);

            // Right ledge
            translate([lid_off + wall + cardkb_pos_x - 0.5,
                       lid_off + wall + cardkb_pos_y + cardkb_wid - 1,
                       lid_top_t])
                cube([cardkb_len + 1, 1.5, kb_ledge_h]);

            // Front ledge
            translate([lid_off + wall + cardkb_pos_x - 0.5,
                       lid_off + wall + cardkb_pos_y - 0.5,
                       lid_top_t])
                cube([1.5, cardkb_wid + 1, kb_ledge_h]);

            // Back ledge
            translate([lid_off + wall + cardkb_pos_x + cardkb_len - 1,
                       lid_off + wall + cardkb_pos_y - 0.5,
                       lid_top_t])
                cube([1.5, cardkb_wid + 1, kb_ledge_h]);

            // ----------------------------------------------------------
            //  CardKB retention clips (four corners)
            // ----------------------------------------------------------
            for (cx = [5, cardkb_len - 15])
                for (cy = [-0.5, cardkb_wid - 0.5])
                    translate([lid_off + wall + cardkb_pos_x + cx,
                               lid_off + wall + cardkb_pos_y + cy,
                               lid_top_t + kb_ledge_h])
                        cardkb_clip(10);

            // ----------------------------------------------------------
            //  Hinge knuckles  (lid gets knuckles 1, 3)
            // ----------------------------------------------------------
            // Shift by lid_off so knuckles align with case knuckles
            translate([lid_off, lid_off + case_ext_wid, 0])
            for (i = [1, 3]) {
                xp = hinge_margin + i * (hinge_knuckle_l + hinge_gap);
                barrel_r = hinge_barrel_d / 2;
                translate([xp, 0, lid_top_t + lid_overlap]) {
                    difference() {
                        union() {
                            rotate([0, 90, 0])
                                cylinder(d = hinge_barrel_d,
                                         h = hinge_knuckle_l, $fn = 24);
                            // Arm toward lid body (-Y)
                            translate([0, -hinge_arm_t, -barrel_r])
                                cube([hinge_knuckle_l, hinge_arm_t,
                                      barrel_r]);
                        }
                        translate([-0.1, 0, 0])
                            rotate([0, 90, 0])
                                cylinder(d = hinge_pin_d + tolerance * 2,
                                         h = hinge_knuckle_l + 0.2,
                                         $fn = 24);
                    }
                }
            }
        }

        // ==============================================================
        //  Subtractive features
        // ==============================================================

        // CardKB keyboard opening (keys accessible through lid top)
        translate([lid_off + wall + cardkb_pos_x + 4,
                   lid_off + wall + cardkb_pos_y + 4,
                   -0.1])
            cube([cardkb_len - 8, cardkb_wid - 8,
                  lid_top_t + 0.2]);

        // OLED display window
        translate([lid_off + wall + oled_win_x,
                   lid_off + wall + oled_win_y,
                   -0.1])
            cube([oled_win_w, oled_win_h, lid_top_t + 0.2]);

        // CardKB cable routing slot
        translate([lid_off + wall + cardkb_pos_x
                       + cardkb_cable_off - cardkb_cable_w / 2 - 1,
                   lid_off + wall + cardkb_pos_y - 1,
                   lid_top_t])
            cube([cardkb_cable_w + 2, wall + 2, cardkb_ht + 2]);

        // Embossed label panel (shallow recess on lid top)
        translate([emboss_inset, emboss_inset, -0.1])
            rrect([lid_ext_len - emboss_inset * 2,
                   lid_ext_wid - emboss_inset * 2,
                   emboss_depth + 0.1],
                  emboss_r);

        // Corner screw holes
        for (p = [ [lid_off + wall + 4, lid_off + wall + 4],
                   [lid_ext_len - lid_off - wall - 4, lid_off + wall + 4],
                   [lid_off + wall + 4, lid_ext_wid - lid_off - wall - 4],
                   [lid_ext_len - lid_off - wall - 4,
                    lid_ext_wid - lid_off - wall - 4] ]) {
            translate([p[0], p[1], -0.1])
                cylinder(d = screw_d, h = lid_ext_depth + lid_overlap + 0.2,
                         $fn = 24);
            // Countersink
            translate([p[0], p[1], -0.1])
                cylinder(d1 = screw_d + 3, d2 = screw_d, h = 1.5,
                         $fn = 24);
        }
    }
}

// Render when opened directly
top_lid();
