using Godot;
using System;

public partial class Cursor : Node2D
{
    [Export]
    public Resource ClickableAnimation;
    private enum CursorStatus
    {
        Normal,
        Click,
        Clickable,
        Catched,
        Catchable
    }
    public enum CursorAnimationStatus
    {
        Normal,
        Click,
        Catch
    }

    public static Cursor Singleton { get; private set; }

    private CursorStatus _status = CursorStatus.Normal;
    public CursorAnimationStatus _animationStatus = CursorAnimationStatus.Normal;
    private CursorStatus _clickPreStatus;
    private AnimationPlayer _animationPlayer;
    private Timer _timer;

    public bool isDrag;

    public override void _Ready()
    {
        // 注册单例
        Singleton = this;
        TopLevel = true;
        // 初始化 on-ready 变量
        _animationPlayer = GetNode<AnimationPlayer>("AnimationPlayer");
        _animationPlayer.Play(_status.ToString());
        // _timer = new Timer
        // {
        //     OneShot = true,
        //     WaitTime = 0.5f
        // };
        // AddChild(_timer);
        // _timer.Timeout += () => ChangeState(CursorStatus.Normal);
        // 隐藏鼠标，这样才能使用我们自定义的带动画的鼠标图案
        Input.MouseMode = Input.MouseModeEnum.Hidden;
    }

    public override void _Input(InputEvent @event)
    {
        switch (@event)
        {
            //点击鼠标
            case InputEventMouseButton:
                {
                    InputEventMouseButton mouseEvent = (InputEventMouseButton)@event;
                    switch (Input.GetCurrentCursorShape())
                    {
                        case Input.CursorShape.Cross:
                            {
                                if (mouseEvent.ButtonIndex == MouseButton.Left && (!mouseEvent.IsPressed() || mouseEvent.IsReleased()))
                                {
                                    ChangeState(CursorStatus.Catched);
                                    return;
                                }
                                ChangeState(CursorStatus.Catchable);
                                break;
                            }
                        case Input.CursorShape.Arrow:
                        default:
                            {
                                if (mouseEvent.ButtonIndex == MouseButton.Left && (!mouseEvent.IsPressed() || mouseEvent.IsReleased()))
                                {
                                    ChangeState(CursorStatus.Normal);
                                    return;
                                };
                                ChangeState(CursorStatus.Click);
                                break;
                            }
                    }
                    break;
                }
            //移动鼠标
            case InputEventMouseMotion:
                {
                    InputEventMouseMotion mouseEvent = (InputEventMouseMotion)@event;
                    switch (Input.GetCurrentCursorShape())
                    {
                        case Input.CursorShape.Cross:
                            {
                                ChangeState(CursorStatus.Catchable);
                                break;
                            }
                        default:
                            {
                                ChangeState(CursorStatus.Normal);
                                break;
                            }
                    }
                    break;
                }

        }


        // _timer.Start();
    }

    public override void _Process(double _delta)
    {
        GlobalPosition = GetGlobalMousePosition();
        // GD.Print("isDrag: " + isDrag);
    }

    private void ChangeState(CursorStatus status)
    {
        if (isDrag)
            status = CursorStatus.Catched;
        _clickPreStatus = _status;
        _status = status;
        _animationPlayer.Play(status.ToString());
    }


}