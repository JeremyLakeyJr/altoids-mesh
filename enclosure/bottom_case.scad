// =============================================================================
// Altoids Mesh Enclosure - Bottom Case
// =============================================================================
// Bottom half of the enclosure housing the Heltec V4 and battery.
// Features: battery compartment, Heltec mounting, port cutouts,
//           ventilation, snap-fit lip, screw bosses.
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

// ---- Ventilation Slots ----
module vent_slots(count, slot_length, slot_width, slot_spacing) {
    total_width = count * slot_width + (count - 1) * slot_spacing;
    for (i = [0:count - 1]) {
        translate([0, i * (slot_width + slot_spacing) - total_width / 2, 0])
            cube([slot_length, slot_width, wall_thickness * 3], center = true);
    }
}

// ---- Snap-Fit Tab ----
module snap_tab() {
    // Flexible cantilever with catch
    translate([0, 0, 0]) {
        cube([snap_width, lip_thickness, lip_height - snap_depth]);
        translate([0, -snap_depth, lip_height - snap_depth])
            cube([snap_width, lip_thickness + snap_depth, snap_depth]);
    }
}

// ---- Battery Retainer Clip ----
module battery_retainer() {
    clip_height = battery_height * 0.6;
    clip_thickness = 1.5;
    clip_overhang = 2.0;

    // Vertical wall
    cube([clip_thickness, battery_width + fit_clearance * 2, clip_height]);

    // Overhang lip
    translate([0, 0, clip_height])
        cube([clip_overhang, battery_width + fit_clearance * 2, clip_thickness]);
}

// ---- Heltec Mounting Standoff ----
module mounting_standoff(height, hole_dia, outer_dia) {
    difference() {
        cylinder(d = outer_dia, h = height, $fn = 24);
        translate([0, 0, -0.1])
            cylinder(d = hole_dia, h = height + 0.2, $fn = 24);
    }
}

// ---- Main Bottom Case ----
module bottom_case() {
    difference() {
        union() {
            // ---- Outer Shell ----
            rounded_rect(
                [external_length, external_width, case_external_depth],
                corner_radius
            );

            // ---- Interior Features (unioned with shell for manifold safety) ----

            // Battery compartment walls
            translate([wall_thickness + battery_pos_x - 1.5, wall_thickness + battery_pos_y - 1.5, 0]) {
                // Left rail
                cube([battery_length + battery_wire_clearance + 3, 1.5, floor_thickness + battery_height * 0.7]);
                // Right rail
                translate([0, battery_width + fit_clearance * 2 + 1.5, 0])
                    cube([battery_length + battery_wire_clearance + 3, 1.5, floor_thickness + battery_height * 0.7]);
                // Back wall (extended into case wall)
                translate([-0.5, 0, 0])
                    cube([2.0, battery_width + fit_clearance * 2 + 3, floor_thickness + battery_height * 0.7]);
            }

            // Battery retainer clip (front)
            translate([
                wall_thickness + battery_pos_x + battery_length + battery_wire_clearance + 1,
                wall_thickness + battery_pos_y - 1.5,
                0
            ]) {
                clip_height = battery_height * 0.6;
                clip_thickness = 1.5;
                clip_overhang = 2.0;
                cube([clip_thickness, battery_width + fit_clearance * 2, floor_thickness + clip_height]);
                translate([0, 0, floor_thickness + clip_height])
                    cube([clip_overhang, battery_width + fit_clearance * 2, clip_thickness]);
            }

            // Heltec V4 mounting standoffs
            heltec_mount_positions = [
                [2.5, 2.5],
                [heltec_length - 2.5, 2.5],
                [2.5, heltec_width - 2.5],
                [heltec_length - 2.5, heltec_width - 2.5]
            ];

            for (pos = heltec_mount_positions) {
                translate([
                    wall_thickness + heltec_pos_x + pos[0],
                    wall_thickness + heltec_pos_y + pos[1],
                    0
                ])
                    cylinder(d = screw_boss_dia - 1, h = floor_thickness + heltec_mount_standoff, $fn = 24);
            }

            // Corner Screw Bosses
            screw_positions = [
                [wall_thickness + 4, wall_thickness + 4],
                [external_length - wall_thickness - 4, wall_thickness + 4],
                [wall_thickness + 4, external_width - wall_thickness - 4],
                [external_length - wall_thickness - 4, external_width - wall_thickness - 4]
            ];

            for (pos = screw_positions) {
                translate([pos[0], pos[1], 0])
                    cylinder(d = screw_boss_dia, h = floor_thickness + case_internal_depth - lip_height + 0.1, $fn = 24);
            }

            // Lid Engagement Lip
            translate([wall_thickness - lip_thickness, wall_thickness - lip_thickness, case_external_depth - lip_height])
                rounded_rect(
                    [internal_length + lip_thickness * 2, internal_width + lip_thickness * 2, lip_height],
                    corner_radius - wall_thickness + lip_thickness
                );

            // Snap-Fit Tabs (long sides)
            for (i = [1:snap_count_long]) {
                x_pos = (external_length / (snap_count_long + 1)) * i - snap_width / 2;

                translate([x_pos, wall_thickness - lip_thickness - snap_depth, case_external_depth - lip_height])
                    snap_tab();
                translate([x_pos, external_width - wall_thickness + lip_clearance, case_external_depth - lip_height])
                    snap_tab();
            }

            // Snap-Fit Tabs (short sides)
            for (i = [1:snap_count_short]) {
                y_pos = (external_width / (snap_count_short + 1)) * i - snap_width / 2;

                translate([wall_thickness - lip_thickness - snap_depth, y_pos, case_external_depth - lip_height])
                    rotate([0, 0, 90])
                    snap_tab();
                translate([external_length - wall_thickness + lip_clearance, y_pos, case_external_depth - lip_height])
                    rotate([0, 0, 90])
                    snap_tab();
            }

            // Cable Channel (between battery and Heltec)
            translate([
                wall_thickness + battery_pos_x + battery_length,
                wall_thickness + battery_pos_y + battery_width - 2,
                0
            ])
                cube([3, heltec_pos_y - battery_pos_y - battery_width + 4, floor_thickness + 2]);
        }

        // ---- Subtractive Features ----

        // Hollow Interior
        translate([wall_thickness, wall_thickness, floor_thickness])
            rounded_rect(
                [internal_length, internal_width, case_internal_depth + 1],
                corner_radius - wall_thickness
            );

        // Lip interior hollow
        translate([wall_thickness, wall_thickness, case_external_depth - lip_height - 0.1])
            rounded_rect(
                [internal_length, internal_width, lip_height + 0.2],
                corner_radius - wall_thickness
            );

        // USB-C Port Cutout
        translate([
            wall_thickness + heltec_pos_x + heltec_length - 1,
            wall_thickness + heltec_pos_y + heltec_usbc_offset_y - usbc_cutout_width / 2,
            floor_thickness + heltec_mount_standoff + heltec_pcb_thickness
        ])
            cube([wall_thickness + 2, usbc_cutout_width, usbc_cutout_height]);

        // Antenna Port Cutout
        translate([
            -1,
            wall_thickness + heltec_pos_y + heltec_width / 2,
            floor_thickness + heltec_pos_z - floor_thickness + heltec_height + 1
        ])
            rotate([0, 90, 0])
            cylinder(d = antenna_cutout_dia, h = wall_thickness + 2, $fn = 24);

        // Side Ventilation Slots (battery side)
        translate([
            external_length / 2,
            wall_thickness / 2,
            floor_thickness + case_internal_depth / 2
        ])
            rotate([90, 0, 0])
            vent_slots(vent_slot_count, vent_slot_length, vent_slot_width, vent_slot_spacing);

        // Bottom Ventilation Slots (under battery)
        translate([
            wall_thickness + battery_pos_x + battery_length / 2,
            wall_thickness + battery_pos_y + battery_width / 2,
            floor_thickness / 2
        ])
            vent_slots(3, battery_length * 0.6, vent_slot_width, vent_slot_spacing * 1.5);

        // Charging LED Window
        translate([
            external_length - wall_thickness - 1,
            wall_thickness + heltec_pos_y + heltec_usbc_offset_y + usbc_cutout_width,
            floor_thickness + heltec_mount_standoff + heltec_pcb_thickness + 1
        ])
            cube([wall_thickness + 2, 2.0, 2.0]);

        // Heltec mounting screw holes
        heltec_mount_positions2 = [
            [2.5, 2.5],
            [heltec_length - 2.5, 2.5],
            [2.5, heltec_width - 2.5],
            [heltec_length - 2.5, heltec_width - 2.5]
        ];
        for (pos = heltec_mount_positions2) {
            translate([
                wall_thickness + heltec_pos_x + pos[0],
                wall_thickness + heltec_pos_y + pos[1],
                -0.1
            ])
                cylinder(d = heltec_mount_hole_dia, h = floor_thickness + heltec_mount_standoff + 0.2, $fn = 24);
        }

        // Screw boss holes
        screw_positions2 = [
            [wall_thickness + 4, wall_thickness + 4],
            [external_length - wall_thickness - 4, wall_thickness + 4],
            [wall_thickness + 4, external_width - wall_thickness - 4],
            [external_length - wall_thickness - 4, external_width - wall_thickness - 4]
        ];
        for (pos = screw_positions2) {
            translate([pos[0], pos[1], -0.1])
                cylinder(d = screw_hole_dia, h = floor_thickness + case_internal_depth - lip_height + 0.3, $fn = 24);
        }
    }
}

// Render the bottom case
bottom_case();
