$fn = 100;
radius = 25;
structureHeight = 5;
detailHeight = 2;

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

module rim(removeInterior)
{
    rimThickness = 2;
    difference()
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
                [
                    0,
                    0,
                    structureHeight
                ]
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

module coin(positiveText)
{
    structure();

    if(positiveText)
    {
        rim(true);
        3dtext("TEST");
    }
    else
    {
        difference()
        {
            rim(false);
            3dtext("TEST", extraHeight = 1);
        }
    }
}

rotate(a=[0,0,0])
{
    coin(true);
}