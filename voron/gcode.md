---
layout: default
title: G-code
parent: "Voron Design Printer"
---

# G-code

G-code (also RS-274) is the most widely used computer numerical control (CNC) and 3D printing programming language. It is used mainly in computer-aided manufacturing to control automated machine tools, as well as for 3D-printer slicer applications. The G stands for geometry. G-code has many variants.

G-code instructions are provided to a machine controller (industrial computer) that tells the motors where to move, how fast to move, and what path to follow. The two most common situations are that, within a machine tool such as a lathe or mill, a cutting tool is moved according to these instructions through a toolpath cutting away material to leave only the finished workpiece and/or an unfinished workpiece is precisely positioned in any of up to nine axes[1] around the three dimensions relative to a toolpath and, either or both can move relative to each other. The same concept also extends to noncutting tools such as forming or burnishing tools, photoplotting, additive methods such as 3D printing, and measuring instruments.

<https://en.wikipedia.org/wiki/G-code>

## Table

Below is a basic table (list) of some common G-code commands:

| Code  | Description                                       |
|-------|---------------------------------------------------|
| G0    | Rapid Move                                        |
| G1    | Linear Move                                       |
| G2    | Clockwise Arc Move                                |
| G3    | Counter-Clockwise Arc Move                        |
| G4    | Dwell (Pause)                                     |
| G20   | Set Units to Inches                               |
| G21   | Set Units to Millimeters                          |
| G28   | Return to Home Position                           |
| G90   | Absolute Positioning                              |
| G91   | Incremental Positioning                           |
| G92   | Set Position                                      |
| M0    | Program Stop                                      |
| M1    | Optional Program Stop                             |
| M2    | Program End                                       |
| M3    | Spindle On (Clockwise Rotation)                   |
| M4    | Spindle On (Counter-Clockwise Rotation)           |
| M5    | Spindle Off                                       |
| M6    | Tool Change                                       |
| M7    | Coolant On (Mist)                                 |
| M8    | Coolant On (Flood)                                |
| M9    | Coolant Off                                       |
| M30   | Program End and Reset                             |


<https://www.klipper3d.org/G-Codes.html>