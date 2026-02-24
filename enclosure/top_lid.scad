// =============================================================================
// Altoids Mesh Enclosure - Top Lid
// =============================================================================
// Top lid with CardKB integration, OLED display window, and snap-fit
// engagement. Designed to mate with the bottom case.
// =============================================================================

include <parameters.scad>

// ---- Rounded Rectangle Helper ----
module rounded_rect(size, radius, center = false) {
    offset_x = center ? -size[0] / 2 : 0;
    offset_y = center ? -size[1] / 2 : 0;
    translate([offset_x, offset_y, 0])
    hull() {
        translate([radius, radius, 0])
            cylinder(r = radius, h = size[2], $fn = 36);
        translate([size[0] - radius, radius, 0])
            cylinder(r = radius, h = size[2], $fn = 36);
        translate([radius, size[1] - radius, 0])
            cylinder(r = radius, h = size[2], $fn = 36);
        translate([size[0] - radius, size[1] - radius, 0])
            cylinder(r = radius, h = size[2], $fn = 36);
    }
}

// ---- Snap-Fit Receiver Slot ----
module snap_receiver() {
    // Slot for snap tab to engage
    translate([0, 0, 0])
        cube([snap_width + tolerance * 2, lip_thickness + snap_depth + tolerance, snap_height + tolerance]);
}

// ---- CardKB Retention Clip ----
module cardkb_clip(length) {
    clip_height = 3.0;
    clip_thickness = 1.0;
    clip_overhang = 1.2;

    cube([length, clip_thickness, clip_height]);
    translate([-clip_overhang, 0, clip_height - clip_thickness])
        cube([length + clip_overhang * 2, clip_thickness, clip_thickness]);
}

// ---- Lid Hinge Knuckle ----
// Places a single knuckle barrel at the given X position.
// In lid coordinates the hinge axis is at Y=0, Z=lid_external_depth
// (maps to back edge hinge axis in the assembly).
module lid_hinge_knuckle(x_pos, knuckle_len) {
    barrel_r = hinge_barrel_outer_dia / 2;
    translate([x_pos, 0, lid_external_depth]) {
        difference() {
            union() {
                // Barrel cylinder along X
                rotate([0, 90, 0])
                    cylinder(d = hinge_barrel_outer_dia, h = knuckle_len, $fn = 24);
                // Support arm connecting barrel to lid wall
                translate([0, 0, -barrel_r])
                    cube([knuckle_len, hinge_arm_thickness, barrel_r]);
            }
            // Pin hole
            translate([-0.1, 0, 0])
                rotate([0, 90, 0])
                cylinder(d = hinge_pin_dia + tolerance * 2, h = knuckle_len + 0.2, $fn = 24);
        }
    }
}

// ---- Main Top Lid ----
module top_lid() {
    difference() {
        union() {
            // ---- Outer Shell ----
            rounded_rect(
                [external_length, external_width, lid_external_depth],
                corner_radius
            );
        }

        // ---- Hollow Interior (CardKB recess) ----
        translate([wall_thickness, wall_thickness, lid_thickness])
            rounded_rect(
                [internal_length, internal_width, lid_internal_depth + 1],
                corner_radius - wall_thickness
            );

        // ---- CardKB Keyboard Opening (top surface) ----
        // Rectangular cutout in the top of the lid for key access
        translate([
            wall_thickness + cardkb_pos_x + 4,
            wall_thickness + cardkb_pos_y + 4,
            -0.1
        ])
            cube([
                cardkb_length - 8,
                cardkb_width - 8,
                lid_thickness + 0.2
            ]);

        // ---- OLED Display Window ----
        // Window in the lid positioned to align with Heltec display
        translate([
            wall_thickness + oled_window_x,
            wall_thickness + oled_window_y,
            -0.1
        ])
            cube([
                oled_window_width,
                oled_window_height,
                lid_thickness + 0.2
            ]);

        // ---- CardKB Cable Routing Slot ----
        translate([
            wall_thickness + cardkb_pos_x + cardkb_cable_offset - cardkb_cable_width / 2 - 1,
            wall_thickness + cardkb_pos_y - 1,
            lid_thickness
        ])
            cube([cardkb_cable_width + 2, wall_thickness + 2, cardkb_height + 2]);

        // ---- Snap-Fit Receiver Slots ----
        // Matching the snap tabs on the bottom case

        // Long sides
        for (i = [1:snap_count_long]) {
            x_pos = (external_length / (snap_count_long + 1)) * i - snap_width / 2 - tolerance;

            // Front side
            translate([x_pos, 0, lid_external_depth - snap_height - tolerance])
                snap_receiver();

            // Back side
            translate([x_pos, external_width - lip_thickness - snap_depth - tolerance, lid_external_depth - snap_height - tolerance])
                snap_receiver();
        }

        // Short sides
        for (i = [1:snap_count_short]) {
            y_pos = (external_width / (snap_count_short + 1)) * i - snap_width / 2 - tolerance;

            // Left side
            translate([0, y_pos, lid_external_depth - snap_height - tolerance])
                rotate([0, 0, 90])
                snap_receiver();

            // Right side
            translate([external_length - lip_thickness - snap_depth - tolerance, y_pos, lid_external_depth - snap_height - tolerance])
                rotate([0, 0, 90])
                snap_receiver();
        }

        // ---- Corner Screw Holes ----
        screw_positions = [
            [wall_thickness + 4, wall_thickness + 4],
            [external_length - wall_thickness - 4, wall_thickness + 4],
            [wall_thickness + 4, external_width - wall_thickness - 4],
            [external_length - wall_thickness - 4, external_width - wall_thickness - 4]
        ];

        for (pos = screw_positions) {
            translate([pos[0], pos[1], -0.1])
                cylinder(d = screw_hole_dia, h = lid_external_depth + 0.2, $fn = 24);

            // Countersink on top
            translate([pos[0], pos[1], -0.1])
                cylinder(d1 = screw_hole_dia + 3, d2 = screw_hole_dia, h = 1.5, $fn = 24);
        }
    }

    // ---- Interior Features ----

    // Lid engagement rim (mates with bottom case lip)
    translate([
        wall_thickness + lip_clearance,
        wall_thickness + lip_clearance,
        lid_external_depth - lip_height
    ])
    difference() {
        rounded_rect(
            [internal_length - lip_clearance * 2, internal_width - lip_clearance * 2, lip_height],
            corner_radius - wall_thickness - lip_clearance
        );
        translate([lip_thickness, lip_thickness, -0.1])
            rounded_rect(
                [internal_length - lip_clearance * 2 - lip_thickness * 2,
                 internal_width - lip_clearance * 2 - lip_thickness * 2,
                 lip_height + 0.2],
                max(0.5, corner_radius - wall_thickness - lip_clearance - lip_thickness)
            );
    }

    // ---- CardKB Mounting Features ----
    // Support ledge for CardKB to rest on
    cardkb_ledge_height = lid_internal_depth - cardkb_height;

    // Side ledges
    // Left ledge
    translate([
        wall_thickness + cardkb_pos_x - 0.5,
        wall_thickness + cardkb_pos_y - 0.5,
        lid_thickness
    ])
        cube([cardkb_length + 1, 1.5, cardkb_ledge_height]);

    // Right ledge
    translate([
        wall_thickness + cardkb_pos_x - 0.5,
        wall_thickness + cardkb_pos_y + cardkb_width - 1,
        lid_thickness
    ])
        cube([cardkb_length + 1, 1.5, cardkb_ledge_height]);

    // Front ledge
    translate([
        wall_thickness + cardkb_pos_x - 0.5,
        wall_thickness + cardkb_pos_y - 0.5,
        lid_thickness
    ])
        cube([1.5, cardkb_width + 1, cardkb_ledge_height]);

    // Back ledge
    translate([
        wall_thickness + cardkb_pos_x + cardkb_length - 1,
        wall_thickness + cardkb_pos_y - 0.5,
        lid_thickness
    ])
        cube([1.5, cardkb_width + 1, cardkb_ledge_height]);

    // CardKB retention clips (corners)
    translate([
        wall_thickness + cardkb_pos_x + 5,
        wall_thickness + cardkb_pos_y - 0.5,
        lid_thickness + cardkb_ledge_height
    ])
        cardkb_clip(10);

    translate([
        wall_thickness + cardkb_pos_x + cardkb_length - 15,
        wall_thickness + cardkb_pos_y - 0.5,
        lid_thickness + cardkb_ledge_height
    ])
        cardkb_clip(10);

    translate([
        wall_thickness + cardkb_pos_x + 5,
        wall_thickness + cardkb_pos_y + cardkb_width - 0.5,
        lid_thickness + cardkb_ledge_height
    ])
        cardkb_clip(10);

    translate([
        wall_thickness + cardkb_pos_x + cardkb_length - 15,
        wall_thickness + cardkb_pos_y + cardkb_width - 0.5,
        lid_thickness + cardkb_ledge_height
    ])
        cardkb_clip(10);

    // ---- Hinge Knuckles (lid gets knuckles 1, 3) ----
    for (i = [1, 3]) {
        x_pos = hinge_margin + i * (hinge_knuckle_length + hinge_gap);
        lid_hinge_knuckle(x_pos, hinge_knuckle_length);
    }
}

// Render the top lid
top_lid();
