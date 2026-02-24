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
| SMA antenna | 1 | External LoRa antenna |

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

### Step 3: Connect the CardKB

1. Connect the Grove/I2C cable to the Heltec V4's I2C port
2. Route the cable through the cable routing slot in the lid
3. Connect the other end to the CardKB Unit 1.1

### Step 4: Install CardKB in Lid

1. With the lid interior facing up, place the CardKB onto the support ledges
2. Press down gently until the retention clips snap over the edges
3. Verify the keyboard keys are accessible through the keyboard opening
4. Ensure the cable exits through the cable routing slot cleanly

### Step 5: Close the Enclosure

1. Carefully fold excess cable into the case interior
2. Align the lid engagement rim with the bottom case lip
3. Press the lid down evenly until snap-fit latches engage on all sides
4. Verify a firm, even closure with no gaps
5. (Optional) Install M2.5 screws through the corner holes for secure closure

### Step 6: Final Checks

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
