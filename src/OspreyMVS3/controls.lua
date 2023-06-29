table.insert(ctrls, {
  Name = "output_format",
  ControlType = "Text",
  Type = "Text",
  UserPin = true,
  PinStyle = "Both",
})
table.insert(ctrls, {
  Name = "border_enable",
  ControlType = "Text",
  Type = "Text",
  UserPin = true,
  PinStyle = "Both",
})
table.insert(ctrls, {
  Name = "border_color",
  ControlType = "Text",
  Type = "Text",
  UserPin = true,
  PinStyle = "Both",
})
for idx = 1, 16 do
  table.insert(ctrls, {
    Name = "layout_"..idx.."_recall",
    ControlType = "Button",
    ButtonType = "Toggle",
    Count = 1,
    UserPin = true,
    PinStyle = "Input",
  })

end
for idx = 1, 4 do
  table.insert(ctrls, {
    Name = "window_"..idx.."_umd_enable",
    ControlType = "Text",
    UserPin = true,
    PinStyle = "Both",
  })
  table.insert(ctrls, {
    Name = "window_"..idx.."_umd_position",
    ControlType = "Text",
    Type = "ComboBox",
    UserPin = true,
    PinStyle = "Both",
  })
  table.insert(ctrls, {
    Name = "window_"..idx.."_umd_text_color",
    ControlType = "Text",
    Type = "ComboBox",
    UserPin = true,
    PinStyle = "Both",
  })
  table.insert(ctrls, {
    Name = "window_"..idx.."_umd_background_color",
    ControlType = "Text",
    Type = "ComboBox",
    UserPin = true,
    PinStyle = "Both",
  })
  table.insert(ctrls, {
    Name = "window_"..idx.."_umd_text",
    ControlType = "Text",
    Type = "Text",
    UserPin = true,
    PinStyle = "Both",
  })
  table.insert(ctrls, {
    Name = "window_"..idx.."_audiometer_enable",
    ControlType = "Text",
    Type = "Text",
    UserPin = true,
    PinStyle = "Both",
  })
  table.insert(ctrls, {
    Name = "window_"..idx.."_audiometer_position",
    ControlType = "Text",
    Type = "Text",
    UserPin = true,
    PinStyle = "Both",
  })
  table.insert(ctrls, {
    Name = "window_"..idx.."_audiometer_channel",
    ControlType = "Text",
    Type = "Text",
    UserPin = true,
    PinStyle = "Both",
  })
  table.insert(ctrls, {
    Name = "window_"..idx.."_osd_enable",
    ControlType = "Text",
    Type = "Text",
    UserPin = true,
    PinStyle = "Both",
  })
  table.insert(ctrls, {
    Name = "window_"..idx.."_osd_text_color",
    ControlType = "Text",
    Type = "Text",
    UserPin = true,
    PinStyle = "Both",
  })
  table.insert(ctrls, {
    Name = "window_"..idx.."_osd_background_color",
    ControlType = "Text",
    Type = "Text",
    UserPin = true,
    PinStyle = "Both",
  })
  table.insert(ctrls, {
    Name = "window_"..idx.."_osd_position",
    ControlType = "Text",
    Type = "Text",
    UserPin = true,
    PinStyle = "Both",
  })
end