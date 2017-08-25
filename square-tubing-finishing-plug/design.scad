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
heightOffset = (height - sidewallHeight) / 2;

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

module sidewalls()
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
    rotate
    (
        [
            180,
            0,
            0
        ]
    )
    {
        sidewalls();
        roof();
    }
}

main();