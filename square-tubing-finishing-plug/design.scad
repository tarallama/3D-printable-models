$fs = .25;
width = 45;
height = width;
depth = 15;
cornerRadius = 4;

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
                center = false,
                $fs = $fs
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
                center = false,
                $fs = $fs
            );
        }
    }
}

module singleCorner
(
    x = 0,
    y = 0,
    z = 0
)
{
    offset = 3;
    translate
    (
        [
            x + offset,
            y + offset,
            z
        ]
    )
    {
        cylinder
        (
            depth,
            cornerRadius,
            cornerRadius,
            center = false,
            $fs = $fs
        );
    }
}


module roundedCorners()
{
    cornerDiameter = cornerRadius * 2;
    singleCorner
    (
        0,
        0,
        0
    );
    
    singleCorner
    (
        0,
        height - cornerDiameter,
        0
    );
    
    /*singleCorner
    (
        width - cornerDiameter,
        0,
        0
    );
    
    singleCorner
    (
        width - cornerDiameter,
        height - cornerDiameter,
        0
    );*/
}

module roof()
{
    roofWidth = 50;
    roofHeight = roofWidth;
    roofDepth = 3;

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
        %roundedCorners();
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