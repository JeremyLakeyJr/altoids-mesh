# Assembly Guide

Step-by-step instructions for assembling the Altoids Mesh enclosure.

## Required Tools

- Small Phillips screwdriver (if using screw mounting)
- Flush cutters or craft knife (for support cleanup if needed)
- Needle-nose pliers (for straightening the paper clip)
- Soldering iron (if connecting battery directly)

## Required Hardware

| Item | Quantity | Notes |
|------|----------|-------|
| Heltec V4 module | 1 | With OLED display |
| M5Stack CardKB Unit 1.1 | 1 | With Grove/I2C cable |
| MakerFocus 3.7V 3000mAh battery | 1 | With JST connector |
| M2 × 5mm screws | 4 | For Heltec mounting (optional) |
| M2.5 × 8mm screws | 4 | For lid closure (optional, friction fit also works) |
| Standard paper clip | 1 | Straightened — used as the hinge pin (~0.9 mm wire) |
| SMA antenna | 1 | External LoRa antenna (optional, see internal option) |
| SMA pigtail + wire antenna | 1 | For internal antenna housing (alternative to external) |

## Pre-Assembly Checks

1. **Print quality**: Inspect both printed parts for warping, stringing, or layer adhesion issues
2. **Fit test**: Slide the lid skirt over the bottom case walls to verify the overlap fits
3. **Clean ports**: Ensure all port cutouts are clean and free of stringing or support material
4. **Component inspection**: Verify all electronic components are functioning before installation

## Assembly Steps

### Step 1: Install the Battery

1. Place the MakerFocus battery into the battery compartment in the bottom case
2. Orient the battery with wires facing toward the centre of the case
3. Route the JST connector wire along the cable channel toward the Heltec mounting area
4. Verify the battery retention clip holds the battery securely
5. Ensure the battery sits flat and does not obstruct the Heltec mounting standoffs

### Step 2: Mount the Heltec V4

1. Connect the battery JST connector to the Heltec V4 battery input
2. Lower the Heltec V4 onto the four mounting standoffs
3. Align the USB-C port with the port cutout on the case wall
4. Align the antenna connector (if using SMA pigtail) with the antenna port cutout
5. Secure with M2 screws through the mounting holes (optional — friction fit works for prototyping)
6. Verify the OLED display faces upward and is centred under the lid display window

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

### Step 6: Prepare the Hinge Pin

1. Take a standard paper clip and straighten it completely using needle-nose pliers
2. The straightened wire should be approximately 80–90 mm long (trim if needed)
3. Optionally bend a tiny 1–2 mm 90° hook at one end to act as a retainer

### Step 7: Install the Hinge Pin

1. Align the bottom case and top lid so the hinge knuckles on the back edge interleave
   - The bottom case has three knuckle barrels (positions 0, 2, 4)
   - The top lid has two knuckle barrels (positions 1, 3)
2. Slide the straightened paper clip through all five knuckle barrels from one side
3. Trim the wire flush with the outer knuckles, or bend the last 1–2 mm at each end to prevent it sliding out
4. Verify the lid swings open and closed smoothly around the hinge

> **Tip:** A small drop of super glue on one bent end permanently secures the
> pin while still allowing removal from the other side if needed.

### Step 8: Close the Enclosure

1. Carefully fold excess cable into the case interior
2. Swing the lid closed — the skirt should slide over the case walls
3. Press gently until the friction bump at the front clicks into place
4. Verify a firm, even closure with no gaps
5. (Optional) Install M2.5 screws through the corner holes for a secure closure

### Step 9: Final Checks

1. **USB-C access**: Verify a USB-C cable plugs in through the port cutout
2. **Antenna port**: Attach the SMA antenna through the antenna port (if external)
3. **Display visibility**: Confirm the OLED display is visible through the display window
4. **Keyboard function**: Test all CardKB keys through the keyboard opening
5. **Ventilation**: Ensure ventilation slots are unobstructed
6. **Hinge action**: Open and close the lid several times to verify smooth operation
7. **Power on**: Turn on the Heltec V4 and verify Meshtastic boots correctly

## Disassembly

1. Remove corner screws if installed
2. Gently pull the front of the lid upward to release the friction bump
3. Swing the lid open on its hinge
4. Disconnect cables before fully separating lid from base
5. To remove the hinge, straighten any bent ends and slide the paper clip out

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Lid too tight | Sand the skirt interior lightly or increase `snap_clearance` in parameters.scad |
| Lid too loose | Decrease `snap_clearance` or increase `friction_bump_h` in parameters.scad |
| USB-C doesn't fit | Enlarge `usbc_cut_w` in parameters.scad and reprint |
| Battery rattles | Add foam tape padding or decrease battery compartment tolerances |
| Overheating | Ensure ventilation slots are clear; consider PETG or ABS for better heat resistance |
| CardKB keys blocked | Widen the keyboard opening by adjusting cutout margins in top_lid.scad |
| Hinge too stiff/loose | Adjust `hinge_gap` in parameters.scad; sand barrel interiors if needed |
| Hinge pin slides out | Bend the last 1–2 mm of the wire at each end |
| Paper clip too thick | Use a smaller paper clip or lightly sand the wire; standard clips are ~0.9 mm |
