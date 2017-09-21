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
roofWidth = width + (widthOffset * 2);
roofHeight = height + (heightOffset * 2);

module roundedCorners
(
    x = 0,
    y = 0,
    z = 0,
    width = width,
    height = height
)
{
    translate
    (
        [
            x + widthOffset,
            y + heightOffset,
            z
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
                    width,
                    height,
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
            //Top
            roundedCorners
            (
                x = 0,
                y = 0,
                z = 0,
                width = sidewallWidth,
                height = sidewallHeight
            );

            //Bottom
            roundedCorners
            (
                x = 0,
                y = 0,
                z = depth,
                width = sidewallWidth,
                height = sidewallHeight
            );
        }

        translate
        (
            [
                sidewallThickness,
                sidewallThickness,
                -1
            ]
        )
        {
            hull()
            {
                //Top
                roundedCorners
                (
                    width = sidewallWidth - (sidewallThickness * 2),
                    height = sidewallHeight - (sidewallThickness * 2)
                );

                //Bottom
                roundedCorners
                (
                    width = sidewallWidth - (sidewallThickness * 2),
                    height = sidewallHeight - (sidewallThickness * 2),
                    z = depth
                );
            }
        }
    }
}

module chamfer
(
    angle = 45
)
{
    half_chamfer( angle = angle );
    translate
    (
        [
            width,
            height,
            0
        ]
    )
    {
        rotate
        (
            [
                0,
                0,
                180
            ]
        )
        {
            half_chamfer( angle = angle );
        }
    }
}

module half_chamfer
(
    angle = 45
)
{
    translate
    (
        [
            -widthOffset,
            -heightOffset,
            depth
        ]
    )
    {
        rotate
        (
            [
                90 - angle,
                0,
                0
            ]
        )
        {
            cube
            (
                [
                    roofWidth,
                    roofDepth * 2,
                    roofDepth * 2
                ],
                center = false
            );
        }
    }

    translate
    (
        [
            -widthOffset,
            -heightOffset,
            depth
        ]
    )
    {
        rotate
        (
            [
                angle,
                0,
                90
            ]
        )
        {
            cube
            (
                [
                    roofWidth,
                    roofDepth * 2,
                    roofDepth * 2
                ],
                center = false
            );
        }
    }
}

module roof()
{
    difference()
    {
        translate
        (
            [
                -widthOffset,
                -heightOffset,
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

        chamfer(30);
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