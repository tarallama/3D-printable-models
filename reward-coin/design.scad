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
        message = message
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

module singleSurfaceDetail
(
    ZPosition,
    positiveText,
    message
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
        3dtext
        (
            position,
            message
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
            3dtext
            (
                position,
                message
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
    structure();
    bothSurfaceDetails
    (
        message = message,
        positiveText = positiveText
    );
}

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