width = 45;
height = width;
depth = 15;

module mainBody() 
{
    //Main structural body
    cube
    (
        [
            width,
            height,
            depth
        ],
        center = false
    );
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
    mainBody();
    lip();
}

main();