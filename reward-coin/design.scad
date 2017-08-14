$fs = .1;
radius = 25;
height = 10;

module coin()
{
    rimHeight = 1;
    rimThickness = 2;
    difference()
    {
        cylinder
        (
            height,
            radius,
            radius,
            center = false,
            $fs = $fs
        );

        translate
        (
            [
                0,
                0,
                height - rimHeight
            ]
        )
        {
            cylinder
            (
                rimHeight + 1,
                radius - rimThickness,
                radius - rimThickness,
                center = false,
                $fs = $fs
            );
        }
    }
}

module main()
{
    rotate(a=[0,0,0])
    {
        coin();
    }
}

main();