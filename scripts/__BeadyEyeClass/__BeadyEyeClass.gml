// Feather disable all

/// @param camera
/// @param cleanUpCamera

function __BeadyEyeClass(_camera, _cleanUpCamera) constructor
{
    __camera        = _camera;
    __cleanUpCamera = _cleanUpCamera;
    
    __width  = camera_get_view_width(_camera);
    __height = camera_get_view_height(_camera);
    __x      = camera_get_view_x(_camera) + __width/2;
    __y      = camera_get_view_y(_camera) + __height/2;
    
    __time = 0;
    
    
    
    __timeSource = time_source_create(time_source_global, 1, time_source_units_frames, function()
    {
        if (__pause) return;
        
        __time += delta_time/1000;
        
        var _positionChanged = false;
        
        if (__tweenMoveDo)
        {
            var _q = (__time - __tweenMoveStartTime) / __tweenMoveDuration;
            
            if (_q >= 1)
            {
                __tweenMoveDo = false;
                _q = 1;
            }
            
            if (__tweenMoveCurve != undefined)
            {
                _q = animcurve_channel_evaluate(animcurve_get_channel(__tweenMoveCurve, 0), _q);
            }
            
            __x = lerp(__tweenMoveStartX, __tweenMoveEndX, _q);
            __y = lerp(__tweenMoveStartY, __tweenMoveEndY, _q);
            
            _positionChanged = true;
        }
        
        if (__tweenZoomDo)
        {
            var _q = (__time - __tweenZoomStartTime) / __tweenZoomDuration;
            
            if (_q >= 1)
            {
                __tweenZoomDo = false;
                _q = 1;
            }
            
            if (__tweenZoomCurve != undefined)
            {
                _q = animcurve_channel_evaluate(animcurve_get_channel(__tweenZoomCurve, 0), _q);
            }
            
            __zoom = lerp(__tweenZoomStart, __tweenZoomEnd, _q);
            
            _positionChanged = true;
        }
        
        if (__tweenAngleDo)
        {
            var _q = (__time - __tweenAngleStartTime) / __tweenAngleDuration;
            
            if (_q >= 1)
            {
                __tweenAngleDo = false;
                _q = 1;
            }
            
            if (__tweenAngleCurve != undefined)
            {
                _q = animcurve_channel_evaluate(animcurve_get_channel(__tweenAngleCurve, 0), _q);
            }
            
            camera_set_view_angle(__camera, lerp(__tweenAngleStart, __tweenAngleEnd, _q));
        }
        
        if (__shakeState == 0)
        {
            //Do nothing!
        }
        else
        {
            _positionChanged = true;
            
            if (__shakeState == 1)
            {
                var _angle        = BEADY_RANDOM_FUNCTION(360);
                var _displacement = BEADY_RANDOM_FUNCTION(__shakeMagnitude);
                __shakeX = lengthdir_x(_displacement, _angle);
                __shakeY = lengthdir_y(_displacement, _angle);
                
            }
            else if (__shakeState == 2)
            {
                var _displacement = BEADY_RANDOM_FUNCTION(__shakeMax - __shakeMin) + __shakeMin;
                __shakeX = lengthdir_x(_displacement, __shakeAngle);
                __shakeY = lengthdir_y(_displacement, __shakeAngle);
            }
            else if (__shakeState == 3)
            {
                __shakeX = BEADY_RANDOM_FUNCTION(__shakeWidth ) - 0.5*__shakeWidth;
                __shakeY = BEADY_RANDOM_FUNCTION(__shakeHeight) - 0.5*__shakeHeight;
            }
            
            var _q = min((__time - __shakeStartTime) / __shakeDuration, 1);
            
            if (_q >= 1)
            {
                __shakeState = 0;
            }
            else if (__shakeCurve != undefined)
            {
                _q = animcurve_channel_evaluate(animcurve_get_channel(__shakeCurve, 0), _q);
            }
            
            __shakeX *= (1 - _q);
            __shakeY *= (1 - _q);
        }
        
        if (__knockbackState == 0)
        {
            //Do nothing!
        }
        else if (__knockbackState == 1)
        {
            var _q = min((__time - __knockbackStartTime) / __knockbackDuration, 1);
            
            if ((_q < 1) && (__knockbackCurve != undefined))
            {
                _q = animcurve_channel_evaluate(animcurve_get_channel(__knockbackCurve, 0), _q);
            }
            
            __knockbackX = lerp(__knockbackStartX, __knockbackEndX, _q);
            __knockbackY = lerp(__knockbackStartY, __knockbackEndY, _q);
            
            _positionChanged = true;
            
            if (_q >= 1)
            {
                __knockbackState     = 2;
                __knockbackStartTime = __time;
                __knockbackStartX    = __knockbackX;
                __knockbackStartY    = __knockbackY;
            }
        }
        else if (__knockbackState == 2)
        {
            var _q = min((__time - __knockbackStartTime) / __knockbackRecoverDuration, 1);
            
            if ((_q < 1) && (__knockbackRecoverCurve != undefined))
            {
                _q = animcurve_channel_evaluate(animcurve_get_channel(__knockbackRecoverCurve, 0), _q);
            }
            
            __knockbackX = (1-_q)*__knockbackStartX;
            __knockbackY = (1-_q)*__knockbackStartY;
            
            _positionChanged = true;
            
            if (_q >= 1)
            {
                __knockbackState = 0;
            }
        }
        
        __AutomationUpdate();
        
        if (_positionChanged)
        {
            __Update();
        }
    },
    [], -1);
    
    time_source_start(__timeSource);
    
    
    
    Destroy = function()
    {
        Destroy = function() {}
        
        if (__cleanUpCamera) camera_destroy(__camera);
        time_source_destroy(__timeSource);
    }
    
    ////////////////////
    //                //
    //                //
    //                //
    ////////////////////
    
    __pause = false;
    
    __cameraIntegerPosition = false;
    
    SetCameraIntegerPosition = function(_state)
    {
        __cameraIntegerPosition = _state;
        
        return self;
    }
    
    GetCameraIntegerPosition = function()
    {
        return __cameraIntegerPosition;
    }
    
    SetSize = function(_width, _height)
    {
        __width  = _width;
        __height = _height;
        
        __Update();
        
        return self;
    }
    
    GetBaseWidth = function()
    {
        return __width;
    }
    
    GetBaseHeight = function()
    {
        return __height;
    }
    
    GetXRemainder = function()
    {
        return frac(__x + __shakeX + __knockbackX - 0.5*__width/__zoom);
    }
    
    GetYRemainder = function()
    {
        return frac(__y + __shakeY + __knockbackY - 0.5*__height/__zoom);
    }
    
    SetPause = function(_state)
    {
        __pause = _state;
        
        return self;
    }
    
    GetPause = function()
    {
        return __pause;
    }
    
    StopAll = function()
    {
        __tweenMoveDo    = false;
        __tweenZoomDo    = false;
        __tweenAngleDo   = false;
        __shakeState     = 0;
        __knockbackState = 0;
        
        StopAutomation();
        
        return self;
    }
    
    ////////////////
    //            //
    // Automation //
    //            //
    ////////////////
    
    __automation      = undefined;
    __automationIndex = 0;
    __automationBlock = BEADY_BLOCK_NONE; 
    
    AutomationPlay = function(_automationTrack, _block = BEADY_BLOCK_MOVE)
    {
        __automation      = variable_clone(_automationTrack);
        __automationIndex = 0;
        __automationBlock = _block
        
        __AutomationUpdate();
    }
    
    AutomationIsPlaying = function()
    {
        return (__automation != undefined);
    }
    
    AutomationStop = function()
    {
        if (__automation == undefined) return;
        
        __automation      = undefined;
        __automationBlock = BEADY_BLOCK_NONE;
    }
    
    __AutomationWait = function(_duration)
    {
        __automationWait = 1000*_duration;
    }
    
    __AutomationUpdate = function()
    {
        if (__automation != undefined)
        {
            if (__automationIndex >= array_length(__automation))
            {
                __automation = undefined;
            }
            else if (__automationWait > 0)
            {
                __automationWait -= delta_time/1000;
            }
            else
            {
                var _instruction = __automation[__automationIndex];
                
                if (is_numeric(_instruction))
                {
                    __AutomationWait(_instruction);
                }
                else if (is_callable(_instruction))
                {
                    _method(self);
                }
                else if (is_array(_method))
                {
                    var _method = _instruction[0];
                    if (not is_callable(_method))
                    {
                        if (_method == "Wait")
                        {
                            _method = __AutomationWait;
                        }
                        else
                        {
                            _method = self[$ _method];
                        
                            if (_method == undefined)
                            {
                                show_error("Method \"" + string(_instruction[0]) + "\" not recognised\n ", true);
                            }
                        }
                    }
                    
                    method_call(_method, _instruction, 1);
                }
                else
                {
                    show_error("Datatype " + typeof(_instruction) + "unsupported (should be number, method, or array)\n ", true);
                }
                
                ++__automationIndex;
            }
        }
    }
    
    //////////
    //      //
    // Move //
    //      //
    //////////
    
    __tweenMoveDo        = false;
    __tweenMoveCurve     = undefined;
    __tweenMoveStartTime = undefined;
    __tweenMoveStartX    = undefined;
    __tweenMoveStartY    = undefined;
    __tweenMoveDuration  = undefined;
    __tweenMoveEndX      = undefined;
    __tweenMoveEndY      = undefined;
    
    Move = function(_x, _y)
    {
        if (__automationBlock & BEADY_BLOCK_MOVE) return;
        
        __tweenMoveDo = false;
        
        __x = _x;
        __y = _y;
        
        __Update();
        
        return self;
    }
    
    MoveApproach = function(_x, _y, _speed)
    {
        var _dX = _x - __x;
        var _dY = _y - __y;
        
        var _inverseDistance = min(1, _speed / sqrt(_dX*_dX + _dY*_dY));
        if (not is_nan(_inverseDistance) && not is_infinity(_inverseDistance))
        {
            Move(__x + _dX*_inverseDistance, __y + _dY*_inverseDistance);
        }
        else
        {
            Move(_x, _y);
        }
        
        return self;
    }
    
    MoveEase = function(_x, _y, _factor)
    {
        Move(lerp(__x, _x, _factor), lerp(__y, _y, _factor));
        
        return self;
    }
    
    GetMoveX = function()
    {
        return __x;
    }
    
    GetMoveY = function()
    {
        return __y;
    }
    
    MoveTo = function(_targetX, _targetY, _duration = BEADY_DEFAULT_MOVE_TO_DURATION, _curve = BEADY_DEFAULT_MOVE_TO_CURVE)
    {
        if (__automationBlock & BEADY_BLOCK_MOVE) return;
        
        __tweenMoveDo        = true;
        __tweenMoveCurve     = _curve;
        __tweenMoveStartTime = __time;
        __tweenMoveStartX    = __x;
        __tweenMoveStartY    = __y;
        __tweenMoveDuration  = 1000*_duration;
        __tweenMoveEndX      = _targetX;
        __tweenMoveEndY      = _targetY;
        
        return self;
    }
    
    IsMoving = function()
    {
        return __tweenMoveDo;
    }
    
    //////////
    //      //
    // Zoom //
    //      //
    //////////
    
    __zoom = 1;
    
    __tweenZoomDo        = false;
    __tweenZoomCurve     = undefined;
    __tweenZoomStartTime = undefined;
    __tweenZoomStart     = undefined;
    __tweenZoomDuration  = undefined;
    __tweenZoomEnd       = undefined;
    
    GetZoomedWidth = function()
    {
        return __width / __zoom;
    }
    
    GetZoomedHeight = function()
    {
        return __height / __zoom;
    }
    
    SetZoom = function(_scale)
    {
        if (__automationBlock & BEADY_BLOCK_ZOOM) return;
        
        __tweenZoomDo = false;
        
        __zoom = _scale;
        __Update();
    }
    
    CalculateZoomFit = function(_width, _height)
    {
        return min(__width / _width, __height / _height);
    }
    
    CalculateZoomCrop = function(_width, _height)
    {
        return max(__width / _width, __height / _height);
    }
    
    GetZoom = function()
    {
        return __zoom;
    }
    
    ZoomTo = function(_target, _duration = BEADY_DEFAULT_ZOOM_TO_DURATION, _curve = BEADY_DEFAULT_ZOOM_TO_CURVE)
    {
        if (__automationBlock & BEADY_BLOCK_ZOOM) return;
        
        __tweenZoomDo        = true;
        __tweenZoomCurve     = _curve;
        __tweenZoomStartTime = __time;
        __tweenZoomStart     = __zoom;
        __tweenZoomDuration  = 1000*_duration;
        __tweenZoomEnd       = _target;
        
        return self;
    }
    
    IsZooming = function()
    {
        return __tweenZoomDo;
    }
    
    ///////////
    //       //
    // Angle //
    //       //
    ///////////
    
    __tweenAngleDo        = false;
    __tweenAngleCurve     = undefined;
    __tweenAngleStartTime = undefined;
    __tweenAngleStart     = undefined;
    __tweenAngleDuration  = undefined;
    __tweenAngleEnd       = undefined;
    
    GetAngle = function()
    {
        return camera_get_view_angle(__camera);
    }
    
    SetAngle = function(_angle)
    {
        if (__automationBlock & BEADY_BLOCK_ANGLE) return;
        
        __tweenAngleDo = false;
        
        camera_set_view_angle(__camera, _angle);
    }
    
    RotateTo = function(_target, _duration = BEADY_DEFAULT_ROTATE_TO_DURATION, _curve = BEADY_DEFAULT_ROTATE_TO_CURVE)
    {
        if (__automationBlock & BEADY_BLOCK_ANGLE) return;
        
        __tweenAngleDo        = true;
        __tweenAngleCurve     = _curve;
        __tweenAngleStartTime = __time;
        __tweenAngleStart     = __zoom;
        __tweenAngleDuration  = 1000*_duration;
        __tweenAngleEnd       = _target;
        
        return self;
    }
    
    IsRotating = function()
    {
        return __tweenAngleDo;
    }
    
    ////////////////////
    //                //
    // Camera Getters //
    //                //
    ////////////////////
    
    GetCamera = function()
    {
        return __camera;
    }
    
    GetCameraLeft = function()
    {
        return camera_get_view_x(__camera);
    }
    
    GetCameraTop = function()
    {
        return camera_get_view_y(__camera);
    }
    
    GetCameraCenterX = function()
    {
        return camera_get_view_x(__camera) + camera_get_view_width(__camera)/2;
    }
    
    GetCameraCenterY = function()
    {
        return camera_get_view_y(__camera) + camera_get_view_height(__camera)/2;
    }
    
    GetCameraRight = function()
    {
        return camera_get_view_x(__camera) + camera_get_view_width(__camera) - 1;
    }
    
    GetCameraBottom = function()
    {
        return camera_get_view_y(__camera) + camera_get_view_height(__camera) - 1;
    }
    
    GetCameraWidth = function()
    {
        return camera_get_view_width(__camera);
    }
    
    GetCameraHeight = function()
    {
        return camera_get_view_height(__camera);
    }
    
    GetCameraDirection = function(_x, _y)
    {
        return point_direction(GetCameraCenterX(), GetCameraCenterY(), _x, _y);
    }
    
    GetCameraDistance = function(_x, _y)
    {
        return point_distance(GetCameraCenterX(), GetCameraCenterY(), _x, _y);
    }
    
    ///////////////
    //           //
    // Knockback //
    //           //
    ///////////////
    
    __knockbackState     = 0; //0 = idle, 1 = knocked, 2 = recover
    __knockbackX         = 0;
    __knockbackY         = 0;
    __knockbackCurve     = undefined;
    __knockbackStartTime = undefined;
    __knockbackStartX    = undefined;
    __knockbackStartY    = undefined;
    __knockbackDuration  = undefined;
    __knockbackEndX      = undefined;
    __knockbackEndY      = undefined;
    
    __knockbackMaxDistance     = infinity;
    __knockbackRecoverDuration = BEADY_DEFAULT_KNOCKBACK_DURATION;
    __knockbackRecoverCurve    = BEADY_DEFAULT_KNOCKBACK_CURVE;
    
    KnockbackParams = function(_maxDistance = __knockbackMaxDistance, _recoverDuration = __knockbackRecoverDuration/1000, _recoverCurve = __knockbackRecoverCurve)
    {
        __knockbackMaxDistance     = _maxDistance;
        __knockbackRecoverDuration = 1000*_recoverDuration;
        __knockbackRecoverCurve    = _recoverCurve;
        
        return self;
    }
    
    Knockback = function(_direction, _magnitude, _duration = BEADY_DEFAULT_KNOCKBACK_DURATION, _curve = BEADY_DEFAULT_KNOCKBACK_CURVE)
    {
        if (__automationBlock & BEADY_BLOCK_KNOCKBACK) return;
        
        __knockbackState     = 1;
        __knockbackCurve     = _curve;
        __knockbackStartTime = __time;
        __knockbackStartX    = __knockbackX;
        __knockbackStartY    = __knockbackY;
        __knockbackDuration  = 1000*_duration;
        __knockbackEndX      = __knockbackX + lengthdir_x(_magnitude, _direction);
        __knockbackEndY      = __knockbackY + lengthdir_y(_magnitude, _direction);
        
        var _inverseDistance = min(1, __knockbackMaxDistance / sqrt(__knockbackEndX*__knockbackEndX + __knockbackEndY*__knockbackEndY));
        if (not is_nan(_inverseDistance) && not is_infinity(_inverseDistance))
        {
            __knockbackEndX *= _inverseDistance;
            __knockbackEndY *= _inverseDistance;
        }
        
        return self;
    }
    
    GetKnockback = function()
    {
        return (__knockbackState != 0);
    }
    
    /////////////
    //         //
    // Shaking //
    //         //
    /////////////
    
    __shakeState     = 0; //0 = idle, 1 = circle, 2 = axis, 3 = rectangle
    __shakeX         = 0;
    __shakeY         = 0;
    __shakeMagnitude = undefined;
    __shakeStartTime = undefined;
    __shakeDuration  = undefined;
    __shakeCurve     = undefined;
    __shakeAngle     = undefined;
    __shakeMin       = undefined;
    __shakeMax       = undefined;
    __shakeWidth     = undefined;
    __shakeHeight    = undefined;
    
    ShakeCircle = function(_magnitude, _duration = BEADY_DEFAULT_SHAKE_DURATION, _curve = BEADY_DEFAULT_SHAKE_CURVE)
    {
        if (__automationBlock & BEADY_BLOCK_SHAKE) return;
        
        __shakeState     = 1;
        __shakeMagnitude = _magnitude
        __shakeStartTime = __time;
        __shakeDuration  = 1000*_duration;
        __shakeCurve     = _curve;
        
        return self;
    }
    
    ShakeAxis = function(_direction, _min, _max, _duration = BEADY_DEFAULT_SHAKE_DURATION, _curve = BEADY_DEFAULT_SHAKE_CURVE)
    {
        if (__automationBlock & BEADY_BLOCK_SHAKE) return;
        
        __shakeState     = 2;
        __shakeAngle     = _direction;
        __shakeMin       = _min;
        __shakeMax       = _max;
        __shakeStartTime = __time;
        __shakeDuration  = 1000*_duration;
        __shakeCurve     = _curve;
        
        return self;
    }
    
    ShakeRectangle = function(_width, _height, _duration = BEADY_DEFAULT_SHAKE_DURATION, _curve = BEADY_DEFAULT_SHAKE_CURVE)
    {
        if (__automationBlock & BEADY_BLOCK_SHAKE) return;
        
        __shakeState     = 3;
        __shakeWidth     = _width;
        __shakeHeight    = _height;
        __shakeStartTime = __time;
        __shakeDuration  = 1000*_duration;
        __shakeCurve     = _curve;
        
        return self;
    }
    
    GetShaking = function()
    {
        return (__shakeState != 0);
    }
    
    /////////////
    //         //
    // Private //
    //         //
    /////////////
    
    __Update = function()
    {
        if (__cameraIntegerPosition)
        {
            camera_set_view_pos(__camera, floor(__x + __shakeX + __knockbackX - 0.5*__width/__zoom), floor(__y + __shakeY + __knockbackY - 0.5*__height/__zoom));
        }
        else
        {
            camera_set_view_pos(__camera, floor(__x + __shakeX + __knockbackX - 0.5*__width/__zoom), floor(__y + __shakeY + __knockbackY - 0.5*__height/__zoom));
        }
        
        camera_set_view_size(__camera, __width/__zoom, __height/__zoom);
    }
}