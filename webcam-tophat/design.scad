$fs = .1;
radius = 45/2;
height = 60;

module hat()
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
        hat();
    }
}

main();