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
| Heltec V3 or V4 module | 1 | With OLED display (set `board_version` in parameters.scad to match) |
| M5Stack CardKB Unit 1.1 | 1 | With Grove/I2C cable |
| MakerFocus 3.7V 3000mAh battery | 1 | With JST connector |
| M2 × 5mm screws | 4 | For Heltec mounting (recommended for sealed use) |
| Standard paper clip | 1 | Straightened — used as the hinge pin (~0.9 mm wire) |
| SMA pigtail + wire antenna | 1 | For internal antenna housing |

## Pre-Assembly Checks

1. **Print quality**: Inspect both printed parts for warping, stringing, or layer adhesion issues
2. **Fit test**: Slide the lid skirt over the bottom case walls to verify the overlap fits
3. **Clean surfaces**: Ensure mating surfaces and interior features are clean and free of stringing or support material
4. **Component inspection**: Verify all electronic components are functioning before installation

## Assembly Steps

### Step 1: Install the Battery

1. Place the MakerFocus battery into the battery compartment in the bottom case
2. Orient the battery with wires facing toward the centre of the case
3. Route the JST connector wire along the cable channel toward the Heltec mounting area
4. Verify the battery retention clip holds the battery securely
5. Ensure the battery sits flat and does not obstruct the Heltec mounting standoffs

### Step 2: Mount the Heltec Board

1. Connect the battery JST connector to the Heltec board's battery input
2. Lower the Heltec board onto the four mounting standoffs
3. Secure with M2 screws through the mounting holes (recommended for sealed use)
4. Verify the OLED display faces upward and is visible when the lid is open

### Step 3: Install Internal Antenna

The sealed design uses an internal wire antenna:

1. Connect an SMA pigtail cable (V4) or IPEX/U.FL pigtail (V3) to the Heltec antenna connector
2. Route the wire antenna along the antenna housing channel on the front wall of the case
3. Tuck the wire under the retention clips to secure it in the channel
4. Ensure the antenna wire is fully seated in the channel and does not interfere with other components

> **Note:** The sealed enclosure has no external antenna port, so an internal wire
> antenna is required. The plastic enclosure does not block RF signals, so an
> internal wire antenna provides comparable performance to an external antenna
> while keeping the enclosure sealed and compact. A quarter-wave wire antenna
> (~82 mm for 915 MHz) fits the housing channel.

### Step 4: Connect the CardKB

1. Connect the Grove/I2C cable to the Heltec board's I2C port
2. Connect the other end to the CardKB Unit 1.1

### Step 5: Install CardKB in Lid

1. With the lid interior facing up, place the CardKB onto the support ledges
2. Press down gently until the retention clips snap over the edges
3. Verify the keyboard is seated securely
4. Ensure the cable is routed cleanly

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

### Step 9: Final Checks

1. **USB-C access**: Verify a USB-C cable can be connected when the lid is open
2. **Antenna**: Confirm the internal antenna wire is secure in the housing channel
3. **Display visibility**: Confirm the OLED display is visible when the lid is open
4. **Keyboard function**: Test all CardKB keys with the lid open
5. **Hinge action**: Open and close the lid several times to verify smooth operation
6. **Power on**: Turn on the Heltec board and verify Meshtastic boots correctly

## Disassembly

1. Gently pull the front of the lid upward to release the friction bump
2. Swing the lid open on its hinge
3. Disconnect cables before fully separating lid from base
4. To remove the hinge, straighten any bent ends and slide the paper clip out

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Lid too tight | Sand the skirt interior lightly or increase `snap_clearance` in parameters.scad |
| Lid too loose | Decrease `snap_clearance` or increase `friction_bump_h` in parameters.scad |
| Battery rattles | Add foam tape padding or decrease battery compartment tolerances |
| Hinge too stiff/loose | Adjust `hinge_gap` in parameters.scad; sand barrel interiors if needed |
| Hinge pin slides out | Bend the last 1–2 mm of the wire at each end |
| Paper clip too thick | Use a smaller paper clip or lightly sand the wire; standard clips are ~0.9 mm |

> **Note:** The sealed design has no ventilation openings. If heat is a concern
> during extended use, consider printing in PETG or ABS for better heat
> resistance, or briefly open the lid to allow airflow.
