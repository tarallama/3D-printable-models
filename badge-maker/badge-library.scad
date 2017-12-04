/*
  Created by Aaron Ciuffo http://www.thingiverse.com/txoof/about
  Released under the Creative Commons Attrib-Share-Alike license
  16 December 2015
*/

$fn = 10;
include <MCAD/boxes.scad>

module textExtrude
(
    textHeight = 2,
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
    xSize,
    ySize,
    zSize,
    holeDia
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

        holes
        (
            xSize,
            ySize,
            zSize,
            holeDia
        );
    }
}

module holes
(
    xSize,
    ySize,
    zSize,
    holeDia
)
{
    holeRad = holeDia/2;
    translate([-xSize/2+holeDia, ySize/2-holeDia, 0])
    {
        cylinder(r = holeRad, h = 2*zSize, center = true);
    }
    translate([xSize/2-holeDia, ySize/2-holeDia, 0])
    {
        cylinder(r = holeRad, h = 2*zSize, center = true);
    }
}

module helloMyNameIsBadge
(
    width = 120,
    height = 80,
    thickness = 2,
    holeDiameter = 7,
    yourName = "PERSON",
    detailThickness = 2,
    headerOffset = 10,
    headerSize = 14,
    nameOffset = 0,
    nameSize = 20
)
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
            textSize = headerSize,
            textHeight = detailThickness
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
                textSize = headerSize * (2 / 5),
                textHeight = detailThickness
            );
        }
    }

    //Main structural backplate
    base
    (
        xSize = width,
        ySize = height,
        zSize = thickness,
        holeDia = holeDiameter
    );

    difference()
    {
        translate
        (
            [
                0,
                0,
                thickness
            ]
        )
        {
            base
            (
                xSize = width,
                ySize = height,
                zSize = detailThickness,
                holeDia = holeDiameter
            );
        }

        translate
        (
            [
                - width / 2,
                - height / 2 + height * 0.5,
                - thickness / 2 + thickness
            ]
        )
        {
            cube(size = [width, height, detailThickness]);
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
                textSize = nameSize,
                textHeight = detailThickness
            );
        }
    }
}

module generic_badge
(
    width = 125,
    height = 60,
    thickness = 2,
    holeDiameter = 7,
    topText = "Top Text",
    botText = "Bottom"
)
{
    base
    (
        xSize = width,
        ySize = height,
        zSize = thickness,
        holeDia = holeDiameter
    );

    translate
    (
        [
            0,
            height / 2 * 0.4,
            0
        ]
    )
    {
        textExtrude
        (
            message = topText
        );
    }

    translate
    (
        [
            0,
            - height / 2 * 0.35,
            0
        ]
    )
    {
        textExtrude
        (
            textSize = 20,
            message = botText
        );
    }
}