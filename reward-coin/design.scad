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

module rim();
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

module coin()
{
    structure();
    rim();
    3dtext("TEST");
}

module 3dtext(string)
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
        linear_extrude(detailHeight)
        {
            text(
                string,
                font="Liberation:style=Bold",
                valign = "center",
                halign = "center"
            );
        }
    }
}

rotate(a=[0,0,0])
{
    coin();
}