// Feather disable all

/// Create a BeadyEye struct and a GameMaker camera for it. The x/y position defines the centre
/// of the camera's point of view. The width and height defines the size of the camera's
/// point-of-view in room space. The camera is then applied to the target view (by default, view 0)
/// which overwrites whatever camera has already been set for that view.
/// 
/// N.B. You must call the `.Destroy()` method on the returned BeadyEye struct when you're done
///      using it or you will create a memory leak.
/// 
/// The retured BeadyEye struct can be controlled and manipulated using methods on the struct. For
/// a list of methods, please see `BeadyEyeCreate()`.
/// 
/// @param x
/// @param y
/// @param width
/// @param height
/// @param viewIndex

function BeadyEyeCreateOnView(_x, _y, _width, _height, _viewIndex)
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