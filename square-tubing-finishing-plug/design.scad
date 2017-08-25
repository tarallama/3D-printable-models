$fn = 100;
width = 45;
height = width;
depth = 15;
cornerRadius = 4;
roofDepth = 3;
sidewallThickness = 1.5;
cornerDiameter = cornerRadius * 2;
sidewallWidth = width - cornerDiameter - 1.5;
sidewallHeight = height - cornerDiameter - 1.5;
widthOffset = (width - sidewallWidth) / 2;
heightOffset = (height- sidewallHeight) / 2;

module sidewalls()
{
    doubleSidewall();
    translate
    (
        [
            width,
            0,
            0
        ]
    )
    {
        rotate
        (
            [
                0,
                0,
                90
            ]
        )
        {
            doubleSidewall();
        }
    }
}

module doubleSidewall()
{
    sidewallMaxThickness = 2;
    sidewallMinThickness = 1;
    singleSidewall(sidewallMaxThickness, sidewallMinThickness);
    translate
    (
        [
            0,
            height,
            0
        ]
    )
    {
        singleSidewall(sidewallMaxThickness, sidewallMinThickness);
    }
}

module singleSidewall
(
    sidewallMaxThickness,
    sidewallMinThickness
)
{
    hull()
    {
        //Left
        translate
        (
            [
                0,
                0,
                0
            ]
        )
        {
            cylinder
            (
                depth,
                sidewallMinThickness / 2,
                sidewallMaxThickness / 2,
                center = false
            );
        }

        //Right
        translate
        (
            [
                width,
                0,
                0
            ]
        )
        {
            cylinder
            (
                depth,
                sidewallMinThickness / 2,
                sidewallMaxThickness / 2,
                center = false
            );
        }
    }
}


module roundedCorners
(
    x = 0,
    y = 0,
    z = 0
)
{
    translate
    (
        [
            x + widthOffset,
            y + heightOffset,
            z + 0
        ]
    )
    {
        minkowski()
        {
            cylinder
            (
                1,
                cornerRadius,
                cornerRadius,
                center = false
            );

            cube
            (
                size =
                [
                    sidewallWidth,
                    sidewallHeight,
                    1
                ],
                center = false
            );
        }
    }
}

module newSidewalls()
{
    difference()
    {
        hull()
        {
            roundedCorners();
            roundedCorners
            (
                0,
                0,
                depth
            );
        }

        translate
        (
            [
                widthOffset,
                heightOffset,
                -1
            ]
        )
        {
            cube
            (
                [
                    sidewallWidth,
                    sidewallHeight,
                    depth + 1
                ],
                center = false
            );
        }
    }
}

module roof()
{
    roofWidth = 50;
    roofHeight = roofWidth;

    offsetWidth = width/2 - roofWidth/2;
    offsetHeight = offsetWidth;
    translate
    (
        [
            offsetWidth,
            offsetHeight,
            depth
        ]
    )
    {
        cube
        (
            [
                roofWidth,
                roofHeight,
                roofDepth
            ],
            center = false
        );
    }
}

module main()
{
    //Main structural body
    rotate
    (
        [
            180,
            0,
            0
        ]
    )
    {
        newSidewalls();
        //sidewalls();
        roof();
    }
}

main();

use <teamteamusa-ruler.scad>;
translate([+2,-47.5,-15])
{
ruler(50);
}