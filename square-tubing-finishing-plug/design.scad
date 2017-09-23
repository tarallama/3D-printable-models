$fn = 100;
width = 45;
height = width;
depth = 13;

cornerRadius = 4;
cornerDiameter = cornerRadius * 2;
sidewallThickness = 1.5;
sidewallWidth = width - cornerDiameter;
sidewallHeight = height - cornerDiameter;

roofDepth = 3;
roofOverhang = 2.75;
roofWidth = width + (roofOverhang * 2);
roofHeight = height + (roofOverhang * 2);

module roundedCorners
(
    x = 0,
    y = 0,
    z = 0,
    width = 10,
    height = 10
)
{
    translate
    (
        [
            x + roofOverhang,
            y + roofOverhang,
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

        //Interior
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
                wide = sidewallWidth - (sidewallThickness * 2);
                hide = sidewallHeight - (sidewallThickness * 2);
                //Top
                roundedCorners
                (
                    width = wide,
                    height = hide,
                    z = 0
                );

                //Bottom
                roundedCorners
                (
                    width = wide,
                    height = hide,
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
            roofWidth,
            roofHeight,
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

module roof()
{
    translate
    (
        [
            -roofOverhang,
            -roofOverhang,
            depth
        ]
    )
    {
        difference()
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

            chamfer(angle = 30);
        }
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