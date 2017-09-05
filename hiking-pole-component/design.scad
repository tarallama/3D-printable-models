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

slitHeight = 12;
module slit ()
{
    width = 1.5;
    translate
    (
        [
            -width / 2,
            -radius,
            height - slitHeight + 1
        ]
    )
    {
        cube
        (
            [
                width,
                (radius * 2) + 1,
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
            height - slitHeight + 1
        ]
    )
    {    
        cube
        (
            [
                (radius * 2) + 1,
                width,
                slitHeight
            ],
            center = false
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
    //Cylinder
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

    //Cone
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

module install_gap()
{
    install_gap_width = 8;
    install_gap_length = install_gap_width;
    install_gap_height = height - slitHeight + 4;

    translate
    (
        [
            -radius,
            -install_gap_width / 2,
            -1
        ]
    )
    {
        cube
        (
            [
                install_gap_length,
                install_gap_width,
                install_gap_height
            ],
            center = false
        );
    }

    cone_height = 8;
    cone_max_width = 12 / 2;
    translate
    (
        [
            -(radius * 3 / 4) - 0.25,
            0,
            height - cone_height - 2
        ]
    )
    {
        cylinder
        (
            h = cone_height,
            r1 = cone_max_width,
            r2 = 2,
            center = false
        );

        second_cone_height = 3;
        translate
        (
            [
                0,
                0,
                -second_cone_height
            ]
        )
        {
            cylinder
            (
                h = second_cone_height,
                r1 = 1,
                r2 = cone_max_width,
                center = false
            );
        }
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
    rotate(a=[0,0,90])
    {
        difference()
        {
            union()
            {
                difference()
                {
                    mainBody();
                    slit();
                    threadZone();
                }
                threads();
            }
            innerCavity();
            install_gap();
            ribs();
        }
    }
}

main();