// Feather disable all

/// @param x
/// @param y
/// @param width
/// @param height

function BeadyEyeCreate(_x, _y, _width, _height)
{
    var _camera = camera_create();
    camera_set_view_pos(_camera, _x - _width/2, _y - _height/2);
    camera_set_view_size(_camera, _width, _height);
    
    return new __BeadyEyeClass(_camera, true);
}