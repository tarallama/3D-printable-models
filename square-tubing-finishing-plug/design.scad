$fn = 100;

module roundedCorners
(
    x = 0,
    y = 0,
    z = 0,
    width,
    height,
    cornerRadius
)
{
    translate
    (
        [
            x + cornerRadius,
            y + cornerRadius,
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

module sidewalls
(
    cornerRadius,
    sidewallThickness,
    width,
    height,
    depth
)
{
    cornerDiameter = cornerRadius * 2;
    sidewallWidth = width - cornerDiameter;
    sidewallHeight = height - cornerDiameter;
    difference()
    {
        hull()
        {
            //Top
            roundedCorners
            (
                z = 0,
                width = sidewallWidth,
                height = sidewallHeight,
                cornerRadius = cornerRadius
            );

            //Bottom
            roundedCorners
            (
                z = depth,
                width = sidewallWidth,
                height = sidewallHeight,
                cornerRadius = cornerRadius
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
                    z = 0,
                    cornerRadius = cornerRadius
                );

                //Bottom
                roundedCorners
                (
                    width = wide,
                    height = hide,
                    z = depth + 2,
                    cornerRadius = cornerRadius
                );
            }
        }
    }
}

module chamfer
(
    angle = 45,
    roofWidth,
    roofHeight,
    roofDepth
)
{
    half_chamfer
    (
        angle = angle,
        roofWidth = roofWidth,
        roofHeight = roofHeight,
        roofDepth = roofDepth
    );

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
            half_chamfer
            (
                angle = angle,
                roofWidth = roofWidth,
                roofHeight = roofHeight,
                roofDepth = roofDepth
            );
        }
    }
}

module half_chamfer
(
    angle = 45,
    roofWidth,
    roofHeight,
    roofDepth
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
                roofHeight,
                roofDepth * 2,
                roofDepth * 2
            ],
            center = false
        );
    }
}

module roof
(
    width,
    height,
    depth,
    roofDepth,
    roofOverhang
)
{
    roofWidth = width + (roofOverhang * 2);
    roofHeight = height + (roofOverhang * 2);
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

            chamfer
            (
                angle = 30,
                roofWidth = roofWidth,
                roofHeight = roofHeight,
                roofDepth = roofDepth
            );
        }
    }
}

module main
(
    depth = 13,
    width = 44.25,
    height = 44.25,
    roofDepth = 3,
    roofOverhang = 2.75,
    cornerRadius = 4,
    sidewallThickness = 1.5
)
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

        sidewalls
        (
            cornerRadius = cornerRadius,
            sidewallThickness = sidewallThickness,
            width = width,
            height = height,
            depth = depth
        );

        roof
        (
            width = width,
            height = height,
            depth = depth,
            roofDepth = roofDepth,
            roofOverhang = roofOverhang
        );
    }
}

main();