// Feather disable all

/// @param x
/// @param y
/// @param width
/// @param height
/// @param [viewIndex=0]

function BeadyEyeCreateOnView(_x, _y, _width, _height, _viewIndex = 0)
{
    var _camera = camera_create();
    camera_set_view_pos(_camera, _x - _width/2, _y - _height/2);
    camera_set_view_size(_camera, _width, _height);
    
    view_enabled = true;
    view_set_camera(_viewIndex, _camera);
    view_set_visible(_viewIndex, true);
    view_set_xport(_viewIndex, 0);
    view_set_yport(_viewIndex, 0);
    view_set_wport(_viewIndex, surface_get_width(application_surface));
    view_set_hport(_viewIndex, surface_get_height(application_surface));
    
    return new __BeadyEyeClass(_camera, true);
}