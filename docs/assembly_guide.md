# Assembly Guide

Step-by-step instructions for assembling the Altoids Mesh enclosure.

## Required Tools

- Small Phillips screwdriver (if using screw mounting)
- Flush cutters or craft knife (for support cleanup if needed)
- Soldering iron (if connecting battery directly)

## Required Hardware

| Item | Quantity | Notes |
|------|----------|-------|
| Heltec V4 module | 1 | With OLED display |
| M5Stack CardKB Unit 1.1 | 1 | With Grove/I2C cable |
| MakerFocus 3.7V 3000mAh battery | 1 | With JST connector |
| M2 × 5mm screws | 4 | For Heltec mounting (optional) |
| M2.5 × 8mm screws | 4 | For lid closure (optional, snap-fit also works) |
| 2 mm metal rod / music wire | ~80 mm | Hinge pin for laptop-style opening |
| SMA antenna | 1 | External LoRa antenna (optional, see internal option) |
| SMA pigtail + wire antenna | 1 | For internal antenna housing (alternative to external) |

## Pre-Assembly Checks

1. **Print quality**: Inspect both printed parts for warping, stringing, or layer adhesion issues
2. **Fit test**: Dry-fit the lid onto the bottom case to verify snap-fit engagement
3. **Clean ports**: Ensure all port cutouts are clean and free of stringing or support material
4. **Component inspection**: Verify all electronic components are functioning before installation

## Assembly Steps

### Step 1: Install the Battery

1. Place the MakerFocus battery into the battery compartment in the bottom case
2. Orient the battery with wires facing toward the center of the case
3. Route the JST connector wire along the cable channel toward the Heltec mounting area
4. Verify the battery retention clip holds the battery securely
5. Ensure the battery sits flat and does not obstruct the Heltec mounting standoffs

### Step 2: Mount the Heltec V4

1. Connect the battery JST connector to the Heltec V4 battery input
2. Lower the Heltec V4 onto the four mounting standoffs
3. Align the USB-C port with the port cutout on the case wall
4. Align the antenna connector (if using SMA pigtail) with the antenna port cutout
5. Secure with M2 screws through the mounting holes (optional — friction fit works for prototyping)
6. Verify the OLED display faces upward and is centered under the lid display window

### Step 3: Install Internal Antenna (Optional)

If using an internal antenna instead of an external SMA antenna:

1. Connect an SMA pigtail cable to the Heltec V4 antenna connector
2. Route the wire antenna along the antenna housing channel on the front wall of the case
3. Tuck the wire under the retention clips to secure it in the channel
4. Ensure the antenna wire is fully seated in the channel and does not interfere with other components

> **Note:** The plastic enclosure does not block RF signals, so an internal wire
> antenna provides comparable performance to an external antenna while keeping
> the enclosure sealed and compact. A quarter-wave wire antenna (~82 mm for
> 915 MHz) fits the housing channel.

### Step 4: Connect the CardKB

1. Connect the Grove/I2C cable to the Heltec V4's I2C port
2. Route the cable through the cable routing slot in the lid
3. Connect the other end to the CardKB Unit 1.1

### Step 5: Install CardKB in Lid

1. With the lid interior facing up, place the CardKB onto the support ledges
2. Press down gently until the retention clips snap over the edges
3. Verify the keyboard keys are accessible through the keyboard opening
4. Ensure the cable exits through the cable routing slot cleanly

### Step 6: Install the Hinge Pin

1. Align the bottom case and top lid so the hinge knuckles on the back edge interleave
   - The bottom case has three knuckle barrels (positions 1, 3, 5)
   - The top lid has two knuckle barrels (positions 2, 4)
2. Slide the 2 mm metal rod (or music wire) through all five knuckle barrels from one side
3. Trim the rod flush with the outer knuckles or leave a small protrusion
4. Optionally apply a tiny drop of glue to one end to prevent the pin from sliding out
5. Verify the lid swings open and closed smoothly around the hinge

### Step 7: Close the Enclosure

1. Carefully fold excess cable into the case interior
2. Align the lid engagement rim with the bottom case lip
3. Press the lid down evenly until snap-fit latches engage on all sides
4. Verify a firm, even closure with no gaps
5. (Optional) Install M2.5 screws through the corner holes for secure closure

### Step 8: Final Checks

1. **USB-C access**: Verify a USB-C cable plugs in through the port cutout
2. **Antenna port**: Attach the SMA antenna through the antenna port
3. **Display visibility**: Confirm the OLED display is visible through the display window
4. **Keyboard function**: Test all CardKB keys through the keyboard opening
5. **Ventilation**: Ensure ventilation slots are unobstructed
6. **Power on**: Turn on the Heltec V4 and verify Meshtastic boots correctly

## Disassembly

1. Remove corner screws if installed
2. Gently pry the snap-fit latches using a thin tool (guitar pick or spudger works well)
3. Lift the lid straight up
4. Disconnect cables before fully separating lid from base

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Lid too tight | Sand the engagement lip lightly or increase `lip_clearance` in parameters.scad |
| Lid too loose | Decrease `lip_clearance` or use corner screws |
| USB-C doesn't fit | Enlarge `usbc_cutout_width` in parameters.scad and reprint |
| Battery rattles | Add foam tape padding or decrease battery compartment tolerances |
| Overheating | Ensure ventilation slots are clear; consider PETG or ABS for better heat resistance |
| CardKB keys blocked | Widen the keyboard opening by adjusting cutout margins in top_lid.scad |
| Hinge too stiff/loose | Adjust `hinge_gap` in parameters.scad; sand barrel interiors if needed |
| Hinge pin slides out | Bend the last 1 mm of the rod or apply a drop of glue to one end |
