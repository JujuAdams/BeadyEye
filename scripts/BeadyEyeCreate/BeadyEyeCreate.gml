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
///     Destroys the BeadyEye struct, freeing any memory associated with it. This must be called
///     when you are done using the struct or you will create a memory leak.
/// 
/// `.SetBaseSize(width, height)`
///     Sets the base (i.e. unzoomed) width and height of the camera.
/// 
/// `.GetBaseWidth()`
///     Returns the base (i.e. unzoomed) width of the camera.
/// 
/// `.GetBaseHeight()`
///     Returns the base (i.e. unzoomed) height of the camera.
/// 
/// `.SetCameraIntegerPosition(state)`
///     Sets whether the GameMaker camera position should always be an integer. Interally within
///     the BeadyEye struct, camera position is always a floating point (decimal) number. However,
///     this can cause rendering issues if applied to the GameMaker camera, especially for pixel
///     art games.
/// 
/// `.GetCameraIntegerPosition()`
///     Returns whether the GameMaker camera position should always be an integer.
///
/// `.GetXRemainder()`
///     Returns the fractional component of the camera's x-coordinate. This is useful for
///     implementing smooth pixel perfect cameras.
/// 
/// `.GetYRemainder()`
///     Returns the fractional component of the camera's y-coordinate. This is useful for
///     implementing smooth pixel perfect cameras.
/// 
/// `.SetPause(state)`
///     Sets whether camera animations, effects, and automation are paused.
/// 
/// `.GetPause()`
///     Returns whether camera animations, effects, and automation are paused.
/// 
/// `.StopAll()`
///     Stops all animations, effects, and automation.
/// 
/// ////////////
/// //        //
/// //  Move  //
/// //        //
/// ////////////
/// 
/// `.Move(x, y)`
///     Instantly focuses the center of the camera on the given point, cancelling any in progress
///     move animation.
/// 
/// `.MoveApproach(x, y, speed)`
///     Applies one tick of a linear "approach" solution to move towards the target coordinate. A
///     higher `speed` will move further towards the target.
/// 
/// `.MoveEase(x, y, factor)`
///     Applies one tick of an exponential `lerp` solution to move towards the target coordinate. A
///     higher `factor` will move further towards the target faster, where a value of `1` will
///     instantly focus on the given coordinate.
/// 
/// `.GetMoveX()`
///     Returns the target focus x-coordinate.
/// 
/// `.GetMoveY()`
///     Returns the target focus y-coordinate.
/// 
/// `.MoveTo(targetX, targetY, [duration=BEADY_DEFAULT_MOVE_TO_DURATION], [curve=BEADY_DEFAULT_MOVE_TO_CURVE])`
///     Moves to a target focus position over a period of time. The duration of the zoom effect and
///     how quickly the angle changes can be controlled using the `duration` and `curve` parameters.
/// 
/// `.IsMoving()`
///     Returns whether the camera is moving to a target focus point.
/// 
/// ////////////
/// //        //
/// //  Zoom  //
/// //        //
/// ////////////
/// 
/// `.GetZoomedWidth()`
///     Returns the roomspace zoomed width of the camera.
/// 
/// `.GetZoomedHeight()`
///     Returns the roomspace zoomed height of the camera.
/// 
/// `.SetZoom(scale)`
///     Sets the angle of the camera, immediatley overriding any zoom animation.
/// 
/// `.CalculateZoomFit(width, height)`
///     Calculates a zoom level such that the given width and height fit inside the camera's
///     point-of-view. If the camera has a different aspect ratio to the specified dimensions then
///     extra space will be added around the edges so that the entire area will be shown by the
///     camera.
/// 
/// `.CalculateZoomCrop(width, height)`
///     Calculates a zoom level such that the camera's point-of-view fits inside the given width
///     and height. If the camera has a different aspect ratio to the specified dimensions then
///     space around the edges will be sacrificed.
/// 
/// `.GetZoom()`
///     Returns the current zoom level.
/// 
/// `.ZoomTo(target, [duration=BEADY_DEFAULT_ZOOM_TO_DURATION], [curve=BEADY_DEFAULT_ZOOM_TO_CURVE])`
///     Zooms to a target zoom level over a period of time. The duration of the zoom effect and
///     how quickly the angle changes can be controlled using the `duration` and `curve` parameters.
/// 
/// `.IsZooming()`
///     Returns whether the camera is zooming to a target zoom level.
/// 
/// /////////////
/// //         //
/// //  Angle  //
/// //         //
/// /////////////
/// 
/// `.GetAngle()`
///     Returns the current angle of the camera.
/// 
/// `.SetAngle(angle)`
///     Sets the angle of the camera, immediatley overriding any rotation animation.
/// 
/// `.RotateTo(target, [duration=BEADY_DEFAULT_ROTATE_TO_DURATION], [curve=BEADY_DEFAULT_ROTATE_TO_CURVE])`
///     Rotates the camera to a target angle over a period of time. The duration of the rotation
///     and how quickly the angle changes can be controlled using the `duration` and `curve`
///     parameters.
/// 
/// `.IsRotating()`
///     Returns whether the camera is rotating to a target angle.
/// 
/// ///////////////
/// //           //
/// //  Shaking  //
/// //           //
/// ///////////////
/// 
/// `.ShakeCircle(distance, [duration=BEADY_DEFAULT_SHAKE_DURATION], [curve=BEADY_DEFAULT_SHAKE_CURVE])`
///     Shakes the camera with a circular envelope. The duration of the shake and how the size of
///     the effect changes over time can be specified with the `duration` and `curve` parameters.
///     
/// `.ShakeAxis(direction, min, max, [duration=BEADY_DEFAULT_SHAKE_DURATION], [curve=BEADY_DEFAULT_SHAKE_CURVE])`
///     Shakes the camera along an axis. The `min` and `max` parameters control how far the centre
///     of the camera should move along the axis away from the current focus position. The duration
///     of the shake and how the size of the effect changes over time can be specified with the
///     `duration` and `curve` parameters.
/// 
/// `.ShakeRectangle(width, height, [duration=BEADY_DEFAULT_SHAKE_DURATION], [curve=BEADY_DEFAULT_SHAKE_CURVE])`
///     Shakes the camera with a rectangular envelope. The duration of the shake and how the size
///     of the effect changes over time can be specified with the `duration` and `curve` parameters.
/// 
/// `.GetShaking()`
///     Returns whether the camera is currently shaking.
/// 
/// /////////////////
/// //             //
/// //  Knockback  //
/// //             //
/// /////////////////
/// 
/// `.KnockbackParams([maxDistance], [recoverDuration], [recoverCurve])`
///     Sets parameters for the knockback animation effect. Any parameter not specified (or has
///     `undefined` passed) will not be set and the old value will persist.
/// 
/// `.Knockback(direction, distance, [duration=BEADY_DEFAULT_KNOCKBACK_DURATION], [curve=BEADY_DEFAULT_KNOCKBACK_CURVE])`
///     Starts a knockback animation. The camera will be pushed in the given direction by the
///     number of pixel specified. You can control the duration and particular animation curve
//.     used for the knockback with the `duration` and `curve` parameters. Only one knockback
///     animation can play at the same time.
/// 
/// `.GetKnockback()`
///     Returns whether a knockback effect is playing.
/// 
/// //////////////////
/// //              //
/// //  Automation  //
/// //              //
/// //////////////////
/// 
/// `.AutomationPlay(automationTrack, [block=BEADY_BLOCK_MOVE])`
///     Starts playback of an automation. You can see an example track in the `Automation Example`
///     Note asset. The `block` parameter controls which featuresets should be blocked whilst
///     the automation is playing. This value should be made from `BEADY_BLOCK_*` constants. To
///     block multiple features at the same time, binary OR the constants together.
/// 
/// `.AutomationIsPlaying()`
///     Returns whether an automation is playing.
/// 
/// `.AutomationStop()`
///     Stops any playing automation.
/// 
/// //////////////////////
/// //                  //
/// //  Camera Getters  //
/// //                  //
/// //////////////////////
/// 
/// `.GetCamera()`
///     Returns the GameMaker camera that this BeadyEye struct is attached to.
/// 
/// `.GetCameraLeft()`
///     Returns the roomspace position of the left of the camera. This includes the zoom level.
/// 
/// `.GetCameraTop()`
///     Returns the roomspace position of the top of the camera. This includes the zoom level.
/// 
/// `.GetCameraCenterX()`
///     Returns the roomspace centre x position of the bottom of the camera. This includes the
///     zoom level.
/// 
/// `.GetCameraCenterY()`
///     Returns the roomspace centre y position of the bottom of the camera. This includes the
///     zoom level.
/// 
/// `.GetCameraRight()`
///     Returns the roomspace position of the right of the camera. This includes the zoom level.
/// 
/// `.GetCameraBottom()`
///     Returns the roomspace position of the bottom of the camera. This includes the zoom level.
/// 
/// `.GetCameraWidth()`
///     Returns the current roomspace width of the camera. This includes the zoom level.
/// 
/// `.GetCameraHeight()`
///     Returns the current roomspace height of the camera. This includes the zoom level.
/// 
/// `.GetCameraDirection(x, y)`
///     Returns the direction from the centre of the camera's point-of-view to the given point.
/// 
/// `.GetCameraDistance(x, y)`
///     Returns the distance from the centre of the camera's point-of-view to the given point.



function BeadyEyeCreate(_x, _y, _width, _height)
{
    var _camera = camera_create();
    camera_set_view_pos(_camera, _x - _width/2, _y - _height/2);
    camera_set_view_size(_camera, _width, _height);
    
    return new __BeadyEyeClass(_camera, true);
}