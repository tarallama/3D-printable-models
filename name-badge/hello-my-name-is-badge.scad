/*
  Created by Aaron Ciuffo http://www.thingiverse.com/txoof/about
  Released under the Creative Commons Attrib-Share-Alike license
  16 December 2015
*/

$fn = 25;
include <MCAD/boxes.scad>

yourName = "PERSON"; //Type your name inside these quotes

//Base plate dimensions
width = 110;
height = 70;
thickness = 2;

//Text
textThickness = 2;
headerOffset = 8;
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
    roundedBox
    (
        baseSize,
        radius = 3,
        sidesonly = 1
    );
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
            message = "Nick Tait",
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