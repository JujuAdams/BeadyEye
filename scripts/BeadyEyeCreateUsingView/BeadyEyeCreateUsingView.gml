// Feather disable all

/// Create a BeadyEye struct using the camera set up for a GameMaker view.
/// 
/// N.B. You must call the `.Destroy()` method on the returned BeadyEye struct when you're done
///      using it or you will create a memory leak.
/// 
/// The retured BeadyEye struct can be controlled and manipulated using methods on the struct. For
/// a list of methods, please see `BeadyEyeCreate()`.
/// 
/// @param viewIndex

function BeadyEyeCreateUsingView(_viewIndex)
{
    return new __BeadyEyeClass(view_get_camera(_viewIndex), false);
}