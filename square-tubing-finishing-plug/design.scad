$fs = .25;
width = 45;
height = width;
depth = 15;

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
    offset = sidewallMinThickness / sidewallMaxThickness;
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

module lip()
{
    lipWidth = 50;
    lipHeight = lipWidth;
    lipDepth = 3;

    offsetWidth = width/2 - lipWidth/2;
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
                lipWidth,
                lipHeight,
                lipDepth
            ],
            center = false
        );
    }
}

module main()
{
    //Main structural body
    sidewalls();
    lip();
}

main();