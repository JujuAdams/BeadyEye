// Feather disable all

if (mouse_check_button_pressed(mb_left))
{
    beadyEye.Knockback(beadyEye.GetCameraDirection(mouse_x, mouse_y), 50, 0.3, acHit);
}

if (keyboard_check_pressed(ord("I")))
{
    beadyEye.ShakeCircle(5, 2);
}

if (keyboard_check_pressed(ord("K")))
{
    beadyEye.ShakeAxis(beadyEye.GetCameraDirection(mouse_x, mouse_y), -10, 10, 1);
}

if (keyboard_check_pressed(ord("M")))
{
    beadyEye.ShakeRectangle(20, 20, 1);
}

if (keyboard_check_pressed(vk_space))
{
    beadyEye.MoveTo(0, 0, 0.5, acEase);
}

if (keyboard_check(vk_control))
{
    beadyEye.MoveApproach(mouse_x, mouse_y, 8);
}