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
    }

    public static Cursor Singleton { get; private set; }

    private CursorStatus _status = CursorStatus.Normal;
    private CursorStatus _clickPreStatus;
    private AnimationPlayer _animationPlayer;
    private Timer _timer;

    public override void _Ready()
    {
        // 注册单例
        Singleton = this;
        TopLevel = true;
        // 初始化 on-ready 变量
        _animationPlayer = GetNode<AnimationPlayer>("AnimationPlayer");
        _animationPlayer.Play(_status.ToString());
        _timer = new Timer
        {
            OneShot = true,
            WaitTime = 0.5f
        };
        AddChild(_timer);
        _timer.Timeout += () => ChangeState(CursorStatus.Normal);
        // 隐藏鼠标，这样才能使用我们自定义的带动画的鼠标图案
        Input.MouseMode = Input.MouseModeEnum.Hidden;
    }

    public override void _Input(InputEvent @event)
    {
        // GD.Print("IN");
        if (@event is not InputEventMouseButton mouseEvent) return;
        if (mouseEvent.ButtonIndex != MouseButton.Left || !mouseEvent.IsPressed() || mouseEvent.IsReleased())
        {
            ChangeState(CursorStatus.Normal);
            return;
        };
        ChangeState(CursorStatus.Click);
        // _timer.Start();
    }

    public override void _Process(double delta)
    {
        GlobalPosition = GetGlobalMousePosition();
    }

    private void ChangeState(CursorStatus status)
    {
        _clickPreStatus = _status;
        _status = status;
        _animationPlayer.Play(status.ToString());
    }

}