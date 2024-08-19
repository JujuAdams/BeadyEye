// Feather disable all

/// @param [viewIndex=0]

function BeadyEyeCreateFromView(_viewIndex = 0)
{
    return new __BeadyEyeClass(view_get_camera(_viewIndex), false);
}