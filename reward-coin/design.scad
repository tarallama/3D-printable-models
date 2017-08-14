$fs = .1;
radius = 25;
height = 10;

module coin()
{
    cylinder
    (
        height,
        radius,
        radius,
        center = false,
        $fs = $fs
    );
}

module main()
{
    rotate(a=[0,0,0])
    {
        coin();
    }
}

main();