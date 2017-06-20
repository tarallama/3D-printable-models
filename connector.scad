$fs = .25;
radius = 15/2;
height = 25;
coneHeight = 6;
coneLowerDiam = 12/2;
coneZPos = height-coneHeight-1;
cylHeight = 4;
use <ISOThread.scad>; //Thanks a bunch to TrevM, downloaded from https://www.thingiverse.com/thing:311031

module mainBody () 
{
    //Main structural body
    cylinder
    (
        height,
        radius,
        radius,
        center = false,
        $fs = $fs
    );    
}

module slit ()
{
    width = 1.5;
    slitHeight = 12;
    translate
    (
        [
            -width/2,
            -radius,
            height-slitHeight+1
        ]
    )
    {
        cube
        (
            [
                width,
                (radius*2)+1,
                slitHeight
            ],
            center = false
        );
    }

    translate
    (
        [
            -radius,
            -1,
            height-slitHeight+1
        ]
    )
    {    
        cube
        (
            [
                (radius*2) + 1,
                width,
                slitHeight
            ],
            center = false
        );
    }
}

module core ()
{
    //Chop out the inner cone
    translate
    (
        [
            0,
            0,
            coneZPos
        ]
    )
    {
        cylinder
        (
            coneHeight,
            coneLowerDiam,
            2.5
        );
    }
}

module threadZone ()
{
    //Add space for the threads
    threadHeight = 16;
    translate
    (
        [
            0,
            0,
            -1
        ]
    )
    {
        cylinder
        (
            threadHeight,
            5,
            5
        );
    }
}

module innerCavity()
{
    //Chop out inner cavity
    translate
    (
        [
            0,
            0,
            coneZPos-cylHeight
        ]
    )
    {
        cylinder
        (
            cylHeight+0.5,
            coneLowerDiam,
            coneLowerDiam
        );
    }
}

module threads()
{
    difference()
    {
        translate
        (
            [
                0,
                0,
                -0.5
            ]
        )
        {
            thread_in(10,16,thr=30);
        }
        
        translate
        (
            [
                0,
                0,
                -1
            ]
        )
        {
            cylinder
            (
                1,
                radius+1,
                radius+1,
                center = false,
                $fs = $fs
            );
        }  
    }
}

module main()
{
    rotate(a=[180,0,0])
    {
        difference()
        {
            union()
            {
                difference()
                {
                    mainBody();
                    slit();
                    core();
                    threadZone();
                }
                threads();
            }
            innerCavity();
        }
    }
}

main();