module structure
(
    radius,
    structureHeight
)
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
    positiveText,
    structureHeight,
    detailHeight,
    rimThickness,
    radius,
    textSize
)
{
    //Top
    singleSurfaceDetail
    (
        ZPosition  =  structureHeight,
        positiveText = positiveText,
        message = message,
        detailHeight = detailHeight,
        rimThickness = rimThickness,
        radius = radius,
        textSize = textSize,
        flipped = false
    );

    //Bottom
    singleSurfaceDetail
    (
        ZPosition  =  - detailHeight,
        positiveText = positiveText,
        message = message,
        detailHeight = detailHeight,
        rimThickness = rimThickness,
        radius = radius,
        textSize = textSize,
        flipped = true
    );
}

module rim
(
    position,
    removeInterior,
    detailHeight,
    radius,
    rimThickness
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
    detailHeight,
    textSize,
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
                string = string,
                detailHeight = detailHeight,
                textSize = textSize
            );
        }
    }
    else
    {
        3dtext
        (
            position = position,
            string = string,
            detailHeight = detailHeight,
            textSize = textSize
        );
    }
}

module singleSurfaceDetail
(
    ZPosition,
    positiveText,
    message,
    detailHeight,
    rimThickness,
    radius,
    textSize,
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
            position = position,
            removeInterior = true,
            detailHeight = detailHeight,
            radius = radius,
            rimThickness = rimThickness
        );
        textFlipper
        (
            position = position,
            string = message,
            detailHeight = detailHeight,
            needsFlipping = flipped,
            textSize = textSize
        );
    }
    else
    {
        difference()
        {
            rim
            (
                position = position,
                removeInterior = false,
                detailHeight = detailHeight,
                radius = radius,
                rimThickness = rimThickness
            );
            textFlipper
            (
                position = position,
                string = message,
                detailHeight = detailHeight,
                needsFlipping = flipped,
                textSize = textSize
            );
        }
    }
}

module 3dtext
(
    position,
    string,
    detailHeight,
    textSize
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
                text = string,
                size = textSize,
                font = "Liberation:style=Bold",
                valign = "center",
                halign = "center"
            );
        }
    }
}

module coin
(
    message = "TEST",
    positiveText = true,
    radius = 30,
    structureHeight = 5,
    detailHeight = 2,
    rimThickness = 2,
    textSize = 12
)
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
        structure
        (
            radius = radius,
            structureHeight = structureHeight
        );
        bothSurfaceDetails
        (
            message = message,
            positiveText = positiveText,
            structureHeight = structureHeight,
            detailHeight = detailHeight,
            rimThickness = rimThickness,
            radius = radius,
            textSize = textSize
        );
    }
}
