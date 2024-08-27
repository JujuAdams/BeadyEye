// Feather disable all

/// Create a BeadyEye struct and a GameMaker camera for it. The x/y position defines the centre
/// of the camera's point of view. The width and height defines the size of the camera's
/// point-of-view in room space.
/// 
/// N.B. You must call the `.Destroy()` method on the returned BeadyEye struct when you're done
///      using it or you will create a memory leak.
/// 
/// @param x
/// @param y
/// @param width
/// @param height
/// 
/// The retured BeadyEye struct has the following methods:
/// 
/// //////////////
/// //          //
/// //  Basics  //
/// //          //
/// //////////////
/// 
/// `.Destroy()`
/// 
/// `.SetCameraIntegerPosition(state)
/// 
/// `.GetCameraIntegerPosition()`
/// 
/// `.SetBaseSize(width, height)
/// 
/// `.GetBaseWidth()`
/// 
/// `.GetBaseHeight()`
/// 
/// `.GetXRemainder()`
/// 
/// `.GetYRemainder()`
/// 
/// `.SetPause(state)`
/// 
/// `.GetPause()`
/// 
/// `.StopAll()`
/// 
/// ////////////
/// //        //
/// //  Move  //
/// //        //
/// ////////////
/// 
/// `.Move(x, y)`
/// 
/// `.MoveApproach(x, y, speed)`
/// 
/// `.MoveEase(x, y, factor)`
/// 
/// `.GetMoveX()`
/// 
/// `.GetMoveY()`
/// 
/// `.MoveTo(targetX, targetY, [duration=BEADY_DEFAULT_MOVE_TO_DURATION], [curve=BEADY_DEFAULT_MOVE_TO_CURVE])`
/// 
/// `.IsMoving()`
/// 
/// ////////////
/// //        //
/// //  Zoom  //
/// //        //
/// ////////////
/// 
/// `.GetZoomedWidth()`
/// 
/// `.GetZoomedHeight()`
/// 
/// `.SetZoom(scale)`
/// 
/// `.CalculateZoomFit(width, height)`
/// 
/// `.CalculateZoomCrop(width, height)`
/// 
/// `.GetZoom()`
/// 
/// `.ZoomTo(target, [duration=BEADY_DEFAULT_ZOOM_TO_DURATION], [curve=BEADY_DEFAULT_ZOOM_TO_CURVE])`
/// 
/// `.IsZooming()`
/// 
/// `.GetAngle()`
/// 
/// `.SetAngle(angle)`
/// 
/// `.RotateTo(target, [duration=BEADY_DEFAULT_ROTATE_TO_DURATION], [curve=BEADY_DEFAULT_ROTATE_TO_CURVE])`
/// 
/// `.IsRotating()`
/// 
/// ///////////////
/// //           //
/// //  Shaking  //
/// //           //
/// ///////////////
/// 
/// `.ShakeCircle(magnitude, [duration=BEADY_DEFAULT_SHAKE_DURATION], [curve=BEADY_DEFAULT_SHAKE_CURVE])`
/// 
/// `.ShakeAxis(direction, min, max, [duration=BEADY_DEFAULT_SHAKE_DURATION], [curve=BEADY_DEFAULT_SHAKE_CURVE])`
/// 
/// `.ShakeRectangle(width, height, [duration=BEADY_DEFAULT_SHAKE_DURATION], [curve=BEADY_DEFAULT_SHAKE_CURVE])`
/// 
/// `.GetShaking()`
/// 
/// /////////////////
/// //             //
/// //  Knockback  //
/// //             //
/// /////////////////
/// 
/// `.KnockbackParams([maxDistance=knockbackMaxDistance], [recoverDuration=knockbackRecoverDuration/1000], [recoverCurve=knockbackRecoverCurve])`
/// 
/// `.Knockback(direction, magnitude, [duration=BEADY_DEFAULT_KNOCKBACK_DURATION], [curve=BEADY_DEFAULT_KNOCKBACK_CURVE])`
/// 
/// `.GetKnockback()`
/// 
/// //////////////////
/// //              //
/// //  Automation  //
/// //              //
/// //////////////////
/// 
/// `.AutomationPlay(automationTrack, [block=BEADY_BLOCK_MOVE])`
/// 
/// `.AutomationIsPlaying()`
/// 
/// `.AutomationStop()`
/// 
/// //////////////////////
/// //                  //
/// //  Camera Getters  //
/// //                  //
/// //////////////////////
/// 
/// `.GetCamera()`
/// 
/// `.GetCameraLeft()`
/// 
/// `.GetCameraTop()`
/// 
/// `.GetCameraCenterX()`
/// 
/// `.GetCameraCenterY()`
/// 
/// `.GetCameraRight()`
/// 
/// `.GetCameraBottom()`
/// 
/// `.GetCameraWidth()`
/// 
/// `.GetCameraHeight()`
/// 
/// `.GetCameraDirection()`
/// 
/// `.GetCameraDistance()`

function BeadyEyeCreate(_x, _y, _width, _height)
{
    var _camera = camera_create();
    camera_set_view_pos(_camera, _x - _width/2, _y - _height/2);
    camera_set_view_size(_camera, _width, _height);
    
    return new __BeadyEyeClass(_camera, true);
}