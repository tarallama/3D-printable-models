use <coin-library.scad>;
$fn = 200;

coin
(
    message = "THANKS",
    positiveText = true,
    topSurfaceOnly = true,
    radius = 24,
    structureHeight = 4,
    detailHeight = 2,
    rimThickness = 2,
    textSize = 6.5
);