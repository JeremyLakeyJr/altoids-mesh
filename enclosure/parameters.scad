// =============================================================================
// Altoids Mesh Enclosure — Parameters
// =============================================================================
// All configurable dimensions for the Altoids-style Meshtastic enclosure.
// Measurements in millimeters.  Edit values here to customise the design;
// every other file includes this one.
// =============================================================================

// =====================================================================
//  1. PRINTING TOLERANCES
// =====================================================================
tolerance       = 0.3;   // General FDM tolerance
fit_clearance   = 0.5;   // Clearance for component pockets
snap_clearance  = 0.2;   // Clearance for snap / friction fits

// =====================================================================
//  2. WALL & STRUCTURE
// =====================================================================
wall            = 2.0;   // Main wall thickness (bottom case)
floor_t         = 1.6;   // Floor / ceiling thickness
lid_wall        = 1.6;   // Lid skirt wall thickness
lid_top_t       = 1.6;   // Lid top-surface thickness
corner_r        = 3.0;   // External corner radius (Altoids aesthetic)
fillet_r        = 1.0;   // Internal fillet radius for strength

// =====================================================================
//  3. COMPONENT DIMENSIONS — Heltec WiFi LoRa 32 V4
// =====================================================================
heltec_len          = 52.0;   // PCB length  (X)
heltec_wid          = 25.0;   // PCB width   (Y)
heltec_ht           = 7.0;    // Component height (Z, incl. parts on PCB)
heltec_pcb_t        = 1.6;    // PCB thickness
heltec_usbc_w       = 9.0;    // USB-C port width
heltec_usbc_h       = 3.5;    // USB-C port height
heltec_usbc_off_y   = 12.5;   // USB-C centre offset from PCB edge (Y)
heltec_oled_w       = 27.0;   // OLED display window width
heltec_oled_h       = 11.0;   // OLED display window height
heltec_oled_off_x   = 12.0;   // OLED offset from PCB edge (X)
heltec_oled_off_y   = 7.0;    // OLED offset from PCB edge (Y)
heltec_antenna_dia  = 6.5;    // SMA antenna connector diameter
heltec_mount_hole   = 2.2;    // Mounting-hole diameter (M2 screw)
heltec_standoff     = 3.0;    // Stand-off height under PCB

// =====================================================================
//  4. COMPONENT DIMENSIONS — M5Stack CardKB Unit 1.1
// =====================================================================
cardkb_len       = 88.0;  // Length (X)
cardkb_wid       = 54.0;  // Width  (Y)
cardkb_ht        = 5.0;   // Thickness (Z)
cardkb_cable_w   = 8.0;   // Grove / I²C cable connector width
cardkb_cable_off = 44.0;  // Cable connector offset from edge

// =====================================================================
//  5. COMPONENT DIMENSIONS — MakerFocus 3.7 V 3000 mAh Battery
// =====================================================================
batt_len         = 65.0;  // Length (X)
batt_wid         = 36.0;  // Width  (Y)
batt_ht          = 10.0;  // Height (Z)
batt_wire_clr    = 8.0;   // Space for battery wires / JST connector

// =====================================================================
//  6. ENCLOSURE INTERNAL DIMENSIONS  (derived)
// =====================================================================
// Battery + Heltec overlap ~15 mm along X (staggered layout).
comp_overlap = 15;

int_len = max(cardkb_len,
              batt_len + heltec_len - comp_overlap)
          + fit_clearance * 2;                        // ≈ 92 mm

int_wid = max(cardkb_wid,
              batt_wid + heltec_wid + fit_clearance)
          + fit_clearance * 2;                        // ≈ 63 mm

case_int_depth = max(batt_ht,
                     heltec_ht + heltec_standoff)
                 + fit_clearance + 1.0;               // ≈ 14 mm

lid_int_depth = cardkb_ht + fit_clearance + 1.0;     // ≈  7 mm

// =====================================================================
//  7. ENCLOSURE EXTERNAL DIMENSIONS  (derived)
// =====================================================================
// Bottom case outer shell
case_ext_len   = int_len + wall * 2;
case_ext_wid   = int_wid + wall * 2;
case_ext_depth = case_int_depth + floor_t;

// Lid outer shell — slightly larger so the skirt overlaps the case walls
lid_overlap      = 4.0;       // How far the lid skirt extends down over case
lid_ext_len      = case_ext_len + (lid_wall + snap_clearance) * 2;
lid_ext_wid      = case_ext_wid + (lid_wall + snap_clearance) * 2;
lid_ext_depth    = lid_int_depth + lid_top_t;

total_height = case_ext_depth + lid_ext_depth;

// =====================================================================
//  8. ALTOIDS-STYLE LID OVERLAP / FRICTION FIT
// =====================================================================
// The lid skirt slides over the top of the case walls, just like a real
// Altoids tin.  A small bump on the front of the skirt provides a
// friction catch.
friction_bump_w = 12.0;   // Width of the front-edge friction bump
friction_bump_h = 0.5;    // Height (radial protrusion) of the bump

// =====================================================================
//  9. VENTILATION
// =====================================================================
vent_len     = 15.0;  // Slot length
vent_w       = 1.5;   // Slot width
vent_space   = 3.0;   // Centre-to-centre spacing
vent_count   = 4;     // Slots per group

// =====================================================================
// 10. SCREW MOUNTS  (optional alternative to snap-fit)
// =====================================================================
screw_d      = 2.5;   // M2.5 hole diameter
screw_boss_d = 6.0;   // Boss outer diameter

// =====================================================================
// 11. PORT CUTOUTS  (derived)
// =====================================================================
usbc_cut_w     = heltec_usbc_w + tolerance * 2;
usbc_cut_h     = heltec_usbc_h + tolerance * 2;
antenna_cut_d  = heltec_antenna_dia + tolerance * 2;

// =====================================================================
// 12. INTERNAL ANTENNA HOUSING
// =====================================================================
// Channel along the front wall for an internal LoRa wire antenna.
// Plastic does not block RF, so no external SMA antenna is required.
ant_len       = 82.0;  // Quarter-wave for 915 MHz  (c/f/4 ≈ 82 mm)
ant_chan_w    = 2.0;    // Channel width
ant_chan_d    = 3.5;    // Rail height above floor
ant_rail_t   = 0.8;    // Retaining-rail thickness
ant_clip_n   = 3;      // Number of retention clips
ant_clip_w   = 4.0;    // Width of each clip
ant_clip_ins = 0.3;    // Clip inset for snug fit

// Position (front wall interior, centred along X)
ant_pos_x = (int_len - ant_len) / 2;
ant_pos_y = 0;

// =====================================================================
// 13. COMPONENT POSITIONING  (relative to case interior origin)
// =====================================================================
batt_pos_x = fit_clearance + 2.0;
batt_pos_y = fit_clearance + 2.0;
batt_pos_z = floor_t;

heltec_pos_x = batt_pos_x + 5.0;
heltec_pos_y = batt_pos_y + batt_wid + fit_clearance + 2.0;
heltec_pos_z = floor_t + heltec_standoff;

cardkb_pos_x = (int_len - cardkb_len) / 2;
cardkb_pos_y = (int_wid - cardkb_wid) / 2;

// =====================================================================
// 14. DISPLAY WINDOW  (above Heltec OLED in assembled view)
// =====================================================================
oled_win_x = heltec_pos_x + heltec_oled_off_x;
oled_win_y = heltec_pos_y + heltec_oled_off_y;
oled_win_w = heltec_oled_w + 1.0;
oled_win_h = heltec_oled_h + 1.0;

// =====================================================================
// 15. HINGE  (laptop-style — assembled with a paper clip)
// =====================================================================
// A straightened standard paper-clip (~0.9 mm wire) is used as the
// hinge pin.  Barrel knuckles interleave along the back edge.
hinge_pin_d     = 0.9;    // Paper-clip wire diameter
hinge_barrel_d  = 3.5;    // Barrel outer diameter
hinge_knuckles  = 5;      // Total interleaved knuckles (3 case + 2 lid)
hinge_gap       = 0.4;    // Gap between adjacent knuckles
hinge_margin    = 8.0;    // Inset from enclosure corners
hinge_arm_t     = 2.0;    // Arm connecting barrel to wall

// Derived
hinge_span       = case_ext_len - 2 * hinge_margin;
hinge_gaps_total = (hinge_knuckles - 1) * hinge_gap;
hinge_knuckle_l  = (hinge_span - hinge_gaps_total) / hinge_knuckles;

// =====================================================================
// 16. EMBOSSED LID PANEL
// =====================================================================
// Shallow rectangular recess on the lid top — mimics the embossed label
// area of a real Altoids tin.
emboss_inset  = 6.0;   // Inset from lid edges
emboss_depth  = 0.6;   // Recess depth
emboss_r      = 2.0;   // Corner radius of embossed rectangle
