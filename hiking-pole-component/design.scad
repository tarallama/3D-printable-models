$fs = .25;
radius = 16/2;
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


module split()
{
    split_width = 2;
    split_length = 4;
    split_height = height + 1;
    //leave a gap for assembley
    translate
    (
        [
            -radius,
            -split_width/2,
            -1
        ]
    )
    {
        cube
        (
            [
                split_length,
                split_width,
                split_height
            ],
            center = false
        );
    }
}


module single_rib(offset = 0)
{
    size = 1;
    rotate_extrude(angle = 360, convexity = 2)
    {
        translate
        (
            [
                radius - 0.5,
                height - size - 1 - offset,
                0
            ]
        )
        {
            square( size, center = false);
        }
    }
}

module ribs()
{
    single_rib();
    single_rib(2);
    single_rib(4);
    single_rib(6);
    single_rib(8);
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
            split();
            ribs();
        }
    }
}

main();