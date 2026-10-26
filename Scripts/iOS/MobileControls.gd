
extends CanvasLayer

var controls: Control
var buttons := {}

func _ready() -> void:
    if OS.get_name() != "iOS":
        return

    controls = Control.new()
    controls.set_anchors_and_offsets_preset(
        Control.PRESET_FULL_RECT
    )
    controls.mouse_filter = Control.MOUSE_FILTER_IGNORE
    add_child(controls)

    _add_button("LEFT", "move_left_0")
    _add_button("RIGHT", "move_right_0")
    _add_button("DOWN", "ui_down")
    _add_button("A", "jump_0")
    _add_button("B", "run_0")
    _add_button("START", "pause")

    get_viewport().size_changed.connect(_layout)
    _layout()


func _add_button(title: String, action: String) -> void:
    var button := Button.new()
    button.text = title
    button.mouse_filter = Control.MOUSE_FILTER_STOP
    button.focus_mode = Control.FOCUS_NONE
    controls.add_child(button)
    buttons[title] = button

    button.button_down.connect(
        func(): Input.action_press(action)
    )
    button.button_up.connect(
        func(): Input.action_release(action)
    )


func _layout() -> void:
    var view := get_viewport().get_visible_rect().size
    var size := Vector2(40, 36)
    var bottom := view.y - 44.0

    _place("LEFT", Vector2(8, bottom), size)
    _place("RIGHT", Vector2(52, bottom), size)
    _place("DOWN", Vector2(30, bottom - 40), size)
    _place("B", Vector2(view.x - 94, bottom), size)
    _place("A", Vector2(view.x - 48, bottom - 30), size)
    _place("START", Vector2(view.x / 2 - 24, 8),
        Vector2(48, 24))


func _place(title: String, pos: Vector2,
        size: Vector2) -> void:
    var button: Button = buttons[title]
    button.position = pos
    button.size = size
