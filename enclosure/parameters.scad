// =============================================================================
// Altoids Mesh Enclosure - Parameters
// =============================================================================
// Parametric dimensions for the Altoids-style Meshtastic enclosure.
// All measurements in millimeters.
// =============================================================================

// ---- Printing Tolerances ----
tolerance = 0.3;           // General FDM tolerance
fit_clearance = 0.5;       // Clearance for component fit
snap_clearance = 0.2;      // Clearance for snap-fit joints

// ---- Wall & Structure ----
wall_thickness = 2.0;       // Main wall thickness (FDM minimum recommended)
floor_thickness = 1.6;      // Floor/ceiling thickness
lid_thickness = 1.6;        // Lid top surface thickness
corner_radius = 3.0;        // External corner radius (Altoids aesthetic)
fillet_radius = 1.0;        // Internal fillet radius for strength

// ---- Component Dimensions: Heltec V4 ----
heltec_length = 52.0;       // PCB length (X)
heltec_width = 25.0;        // PCB width (Y)
heltec_height = 7.0;        // Component height (Z, including parts)
heltec_pcb_thickness = 1.6; // PCB thickness
heltec_usbc_width = 9.0;    // USB-C port width
heltec_usbc_height = 3.5;   // USB-C port height
heltec_usbc_offset_y = 12.5;// USB-C center offset from PCB edge (Y)
heltec_oled_width = 27.0;   // OLED display window width
heltec_oled_height = 11.0;  // OLED display window height
heltec_oled_offset_x = 12.0;// OLED offset from PCB edge (X)
heltec_oled_offset_y = 7.0; // OLED offset from PCB edge (Y)
heltec_antenna_dia = 6.5;   // SMA antenna connector diameter
heltec_mount_hole_dia = 2.2;// Mounting hole diameter (M2 screw)
heltec_mount_standoff = 3.0;// Standoff height under PCB

// ---- Component Dimensions: CardKB Unit 1.1 ----
cardkb_length = 88.0;       // Length (X)
cardkb_width = 54.0;        // Width (Y)
cardkb_height = 5.0;        // Thickness (Z)
cardkb_cable_width = 8.0;   // Grove/I2C cable connector width
cardkb_cable_offset = 44.0; // Cable connector offset from edge

// ---- Component Dimensions: MakerFocus Battery ----
battery_length = 65.0;      // Length (X)
battery_width = 36.0;       // Width (Y)
battery_height = 10.0;      // Height (Z)
battery_wire_clearance = 8.0;// Space for battery wires/connector
battery_tolerance = 2.0;    // Manufacturer tolerance (±2mm)

// ---- Enclosure Internal Dimensions ----
// Calculated to fit all components with clearance
// Battery and Heltec overlap by ~15mm along the length axis (staggered layout)
component_overlap = 15;
internal_length = max(cardkb_length, battery_length + heltec_length - component_overlap)
                  + fit_clearance * 2;  // ~92mm
internal_width = max(cardkb_width, battery_width + heltec_width + fit_clearance)
                 + fit_clearance * 2;   // ~63mm
case_internal_depth = max(battery_height, heltec_height + heltec_mount_standoff)
                      + fit_clearance + 1.0;  // ~14mm

// Lid internal depth for CardKB recess
lid_internal_depth = cardkb_height + fit_clearance + 1.0;  // ~7mm

// ---- Enclosure External Dimensions ----
external_length = internal_length + wall_thickness * 2;
external_width = internal_width + wall_thickness * 2;
case_external_depth = case_internal_depth + floor_thickness;
lid_external_depth = lid_internal_depth + lid_thickness;
total_height = case_external_depth + lid_external_depth;

// ---- Lip/Rim for Lid Engagement ----
lip_height = 3.0;           // Height of engagement lip
lip_thickness = 1.2;        // Thickness of the lip wall
lip_clearance = snap_clearance;

// ---- Snap-Fit Latches ----
snap_width = 8.0;           // Width of snap latch
snap_depth = 1.0;           // Depth of snap catch
snap_height = 2.0;          // Height of snap catch
snap_count_long = 2;        // Number of snaps on long sides
snap_count_short = 1;       // Number of snaps on short sides

// ---- Ventilation ----
vent_slot_length = 15.0;    // Length of ventilation slot
vent_slot_width = 1.5;      // Width of ventilation slot
vent_slot_spacing = 3.0;    // Spacing between vent slots
vent_slot_count = 4;        // Number of vent slots per group

// ---- Screw Mounts (optional alternative to snap-fit) ----
screw_hole_dia = 2.5;       // M2.5 screw hole diameter
screw_boss_dia = 6.0;       // Screw boss outer diameter
screw_boss_height = 5.0;    // Screw boss height

// ---- Port Cutouts ----
usbc_cutout_width = heltec_usbc_width + tolerance * 2;
usbc_cutout_height = heltec_usbc_height + tolerance * 2;
antenna_cutout_dia = heltec_antenna_dia + tolerance * 2;

// ---- Internal Antenna Housing ----
// Channel along front wall for housing LoRa antenna internally.
// Plastic enclosure does not block RF signals, so the antenna can be
// routed inside the case instead of requiring an external SMA antenna.
antenna_housing_length = 82.0;      // Quarter-wave antenna length (915 MHz)
antenna_housing_width = 2.0;        // Channel width (wire/pigtail antenna)
antenna_housing_depth = 3.5;        // Rail height above floor
antenna_housing_wall = 0.8;         // Retaining rail thickness
antenna_clip_count = 3;             // Number of retention clips
antenna_clip_width = 4.0;           // Width of each retention clip

// Antenna channel position (front wall interior, centered along length)
antenna_channel_pos_x = (internal_length - antenna_housing_length) / 2;
antenna_channel_pos_y = 0;

// ---- Component Positioning (relative to case interior origin) ----
// Battery placed along one long edge
battery_pos_x = fit_clearance + 2.0;
battery_pos_y = fit_clearance + 2.0;
battery_pos_z = floor_thickness;

// Heltec placed next to battery
heltec_pos_x = battery_pos_x + 5.0;
heltec_pos_y = battery_pos_y + battery_width + fit_clearance + 2.0;
heltec_pos_z = floor_thickness + heltec_mount_standoff;

// CardKB centered on lid interior
cardkb_pos_x = (internal_length - cardkb_length) / 2;
cardkb_pos_y = (internal_width - cardkb_width) / 2;

// ---- Display Window (positioned above Heltec OLED) ----
oled_window_x = heltec_pos_x + heltec_oled_offset_x;
oled_window_y = heltec_pos_y + heltec_oled_offset_y;
oled_window_width = heltec_oled_width + 1.0;
oled_window_height = heltec_oled_height + 1.0;
