$fs = .25;
radius = 15/2;
height = 25;

difference()
{
    cylinder(
        height,
        radius,
        radius,
        center = false,
        $fs = $fs
    );

    //Chop off half the cylinder
    translate(
        [
            -radius,
            0,
            -1
        ]
        )
    {
        cube(
            [
                radius*2,
                radius*2,
                height+2
            ],
            center = false
        );
    }
    
    //Slit
    width = 1.5;
    slitHeight = radius+1;
    translate(
        [
            -width/2,
            -radius,
            height-slitHeight
        ]
        )
    {
        cube(
            [
                width,
                radius+1,
                radius+2
            ],
            center = false
        );
    }
    
    //Inner cone
    coneHeight = 6;
    coneLowerDiam = 12/2;
    coneZPos = height-coneHeight-1;
    translate(
        [
            0,
            0,
            coneZPos
        ]
        )
        {
            cylinder(
                coneHeight,
                coneLowerDiam,
                2.5
            );
        }
        
    cylHeight = 4;
    translate(
        [
            0,
            0,
            coneZPos-cylHeight
        ]
        )
        {
            cylinder(
                cylHeight+0.5,
                coneLowerDiam,
                coneLowerDiam
            );
        }
}