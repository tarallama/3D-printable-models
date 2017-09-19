$fn = 100;
radius = 30;
structureHeight = 5;
detailHeight = 2;
rimThickness = 2;

module structure()
{
    cylinder
    (
        structureHeight,
        radius,
        radius,
        center = false
    );
}

module bothSurfaceDetails
(
    message,
    positiveText
)
{
    //Top
    singleSurfaceDetail
    (
        ZPosition  =  structureHeight,
        positiveText = positiveText,
        message = message
    );

    //Bottom
    singleSurfaceDetail
    (
        ZPosition  =  - detailHeight,
        positiveText = positiveText,
        message = message,
        flipped = true
    );
}

module rim
(
    position,
    removeInterior
)
{
    difference()
    {
        translate
        (
            position
        )
        {
            cylinder
            (
                detailHeight,
                radius,
                radius,
                center = false
            );
        }

        if(removeInterior)
        {
            translate
            (
                position
            )
            {
                cylinder
                (
                    detailHeight + 1,
                    radius - rimThickness,
                    radius - rimThickness,
                    center = false
                );
            }
        }
    }
}

module textFlipper
(
    position,
    string,
    needsFlipping = false
)
{
    if(needsFlipping)
    {
        mirror
        (
            [
                1,
                0,
                0
            ]
        )
        {
            3dtext
            (
                position = position,
                string = string
            );
        }
    }
    else
    {
        3dtext
        (
            position = position,
            string = string
        );
    }
}

module singleSurfaceDetail
(
    ZPosition,
    positiveText,
    message,
    flipped = false
)
{
    position = 
    [
        0,
        0,
        ZPosition
    ];
    if(positiveText)
    {
        rim
        (
            position,
            removeInterior = true
        );
        textFlipper
        (
            position,
            message,
            flipped
        );
    }
    else
    {
        difference()
        {
            rim
            (
                position,
                removeInterior = false
            );
            textFlipper
            (
                position,
                message,
                flipped
            );
        }
    }
}

module 3dtext
(
    position,
    string
)
{
    translate
    (
        position
    )
    {
        linear_extrude(detailHeight)
        {
            text
            (
                string,
                font="Liberation:style=Bold",
                valign = "center",
                halign = "center"
            );
        }
    }
}


module coin(message = "TEST", positiveText = true)
{
    translate
    (
        [
            0,
            0,
            detailHeight
        ]
    )
    {
        structure();
        bothSurfaceDetails
        (
            message = message,
            positiveText = positiveText
        );
    }
}

module testBothStyles()
{
    rotate(a=[0,0,0])
    {
        coin
        (
            message = "LEMON",
            positiveText = true
        );
    }

    translate
    (
        [
            radius * 2 + radius / 2,
            0,
            0
        ]
    )
    {
        coin
        (
            message = "LIME",
            positiveText = false
        );
    }
}

testBothStyles();