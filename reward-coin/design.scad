$fn = 100;
radius = 25;
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

module surfaceDetail(removeInterior)
{
    singleSurfaceDetail
    (
        ZPosition  =  structureHeight,
        removeInterior = removeInterior
    );

    singleSurfaceDetail
    (
        ZPosition  =  - detailHeight,
        removeInterior = removeInterior
    );
}

module singleSurfaceDetail
(
    topSurface = true,
    removeInterior = false
)
{
    position = 
    [
        0,
        0,
        ZPosition
    ];
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

module 3dtext(string, extraHeight = 0)
{
    translate
    (
        [
            0,
            0,
            structureHeight
        ]
    )
    {
        linear_extrude(detailHeight + extraHeight)
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

    if(positiveText)
    {
        surfaceDetail(true);
        3dtext(message);
    }
    else
    {
        difference()
        {
            surfaceDetail(false);
            3dtext(message, extraHeight = 1);
        }
    }
}

rotate(a=[0,0,0])
{
    coin
    (
        message = "HEY",
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
        message = "TEST",
        positiveText = false
    );
}