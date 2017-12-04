/*
  Created by Aaron Ciuffo http://www.thingiverse.com/txoof/about
  Released under the Creative Commons Attrib-Share-Alike license
  16 December 2015
*/

$fn = 25;
include <MCAD/boxes.scad>

yourName = "PERSON"; //Type your name inside these quotes

//Base plate dimensions
width = 120;
height = 80;
thickness = 2;

//Text
textThickness = 2;
headerOffset = 10;
headerSize = 14;
nameOffset = 0;
nameSize = 20;

module textExtrude
(
    textHeight = textThickness,
    textSize = 7.5,
    message = "test",
    textColor = "black", // [green, yellow, blue, red, silver, black]
    textFont = "Liberation Sans" // [Liberation Mono, Liberation Sans, Liberation Sans Narrow and Liberation Serif]
)
{
    color(textColor)
    {
        linear_extrude
        (
            height = textHeight
        )
        {
            text
            (
                message,
                halign = "center",
                valign = "center",
                size = textSize,
                font = textFont
            );
        }
    }
}

module base
(
    xSize = 48,
    ySize = 25,
    zSize = 3
)
{
    baseSize =
    [
        xSize,
        ySize,
        zSize
    ];
    difference()
    {
        roundedBox
        (
            baseSize,
            radius = 3,
            sidesonly = 1
        );

        holes();
    }
}

xSize = 45; // length
ySize = 15; // height
zSize = 3; //thickness
holeDia = 3.5; // hole diameter
holeRad = holeDia/2;
module holes
(
)
{
    translate([-xSize/2+holeDia, ySize/2-holeDia, 0])
        cylinder(r = holeRad, h = 2*zSize, $fn = 36, center = true);
    translate([xSize/2-holeDia, ySize/2-holeDia, 0])
        cylinder(r = holeRad, h = 2*zSize, $fn = 36, center = true);
}


module makeTag()
{
    translate
    (
        [
            0,
            headerSize + headerOffset,
            thickness / 2
        ]
    )
    {
        textExtrude
        (
            message = "HELLO",
            textSize = headerSize
        );

        translate
        (
            [
                0,
                -headerSize,
                0
            ]
        )
        {
            textExtrude
            (
                message = "MY NAME IS",
                textSize = headerSize * (2 / 5)
            );
        }
    }

    translate
    (
        [
            0,
            -nameSize + nameOffset,
            thickness / 2
        ]
    )
    {
        textExtrude
        (
            message = yourName,
            textSize = nameSize
        );
    }

    base
    (
        xSize = width,
        ySize = height,
        zSize = thickness
    );
}

makeTag();