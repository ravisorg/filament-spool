# OpenSCAD BazzelRoller

This is a somewhat modified version of Bazzel Works' BazzelRoller filament roller design, found on Thingiverse at https://www.thingiverse.com/thing:4384862

I started by modifying it to work with the different sized PVC pipe I had on hand, and adding crush ribs to make fitting easier, and then it just got a little out of hand and I learned OpenSCAD to build a version programmatically for any size of pipe, bearing, height, etc. It makes decent attempts to create printable versions regardless of the parameters you give it, however extreme edge cases will probably break it. See the Thingiverse link above for lots of details on the original design.

I want to stress that all design credit needs to go to Bazzel Works https://www.thingiverse.com/bazzelworks/designs, I just turned their design into a stupidly overcomplex program, because it was a good excuse to learn OpenSCAD.

I would upload this to Thingiverse, but their account system is so horribly broken at the moment that I can't even log in. And their customizer is insanely slow anyway. Download OpenSCAD https://openscad.org/ to customize and render as you see fit.

## Parameters

### Roller_Tube_Outer_Diameter
The outer diameter of the pipe you want to use as your roller, in mm.

### Roller_Tube_Inner_Diameter
The inner diameter of the pipe you want to use as your roller, in mm.

### Cap_Width
How far the cap should extend beyond the end of the tube, in mm.

### Bearing_Outer_Diameter
The outer diameter of your bearings, in mm.

### Bearing_Inner_Diameter
The inner diameter of your bearings, in mm.

### Bearing_Width
The width of your bearings, in mm.

### Base_Thickness
The thickness of your base, in mm.

### Support_Tube_Outer_Diameter
The outer diameter of the stationary support tube, in mm.

### Base_Height_to_Rollers
How high to hold the filament off the ground (in mm, measured from ground to center of rollers). If you specify a number here that's not big enough to fit all the pieces together, it'll automatically use the smallest possible working value.

### Distance_Between_Rollers
How far to place the rollers apart, in mm.

### Number_of_Crush_Ribs
If you want to use crush ribs to make up for some inaccuracies in your print, while still allowing tight fits, set this to a non zero value (6 is recommended). If you use crush rubs, you must have at least 3, and the number you choose has to evenly divide into 360. Set to 0 to disable crush ribs completely.
