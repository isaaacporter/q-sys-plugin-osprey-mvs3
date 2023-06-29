local CurrentPage = PageNames[props["page_index"].Value]
if CurrentPage == "Scaling/Output" then
  table.insert(graphics,{
    Type = "GroupBox",
    Fill = {0, 0, 0, 0},
    StrokeColor = {0, 0, 0},
    StrokeWidth = 1,
    CornerRadius = 8,
    Position = {0, 0},
    Size = {730,220}
  })
  table.insert(graphics,{
    Type = "Text",
    Text = "Output Format",
    FontSize = 12,
    HTextAlign = "Right",
    Position = {5, 15},
    Size = {120, 25}
  })
  layout["output_format"] = {
    PrettyName = "Output~Format",
    Style = "ComboBox",
    Margin = 0,
    CornerRadius = 0,
    Position = {125, 15},
    Size = {120, 25}
  }
  table.insert(graphics,{
    Type = "Text",
    Text = "Border Enable",
    FontSize = 12,
    HTextAlign = "Right",
    Position = {245, 15},
    Size = {120, 25}
  })
  layout["border_enable"] = {
    PrettyName = "Output~Border Enable",
    Style = "ComboBox",
    Margin = 0,
    CornerRadius = 0,
    Position = {365, 15},
    Size = {120, 25}
  }
  table.insert(graphics,{
    Type = "Text",
    Text = "Border Color",
    FontSize = 12,
    HTextAlign = "Right",
    Position = {485, 15},
    Size = {120, 25}
  })
  layout["border_color"] = {
    PrettyName = "Output~Border Color",
    Style = "ComboBox",
    Margin = 0,
    CornerRadius = 0,
    Position = {605, 15},
    Size = {120, 25}
  }
  for idx = 1, 8 do
    layout["layout_"..idx.."_recall"] = {
      PrettyName = "Layout~Recall "..idx,
      ButtonVisualStyle = "Flat",
      Style = "Button",
      Margin = 0,
      Position = {(82 * idx) - 32, 65},
      Size = {50, 50}
    }
  end
  for idx = 9, 16 do
    layout["layout_"..idx.."_recall"] = {
      PrettyName = "Layout~Recall "..idx,
      ButtonVisualStyle = "Flat",
      Style = "Button",
      Margin = 0,
      Position = {(82 * (idx-8)) - 32, 148},
      Size = {50, 50}
    }
  end
end
if CurrentPage == "UMD Overlay" then
  table.insert(graphics,{
    Type = "GroupBox",
    Fill = {0, 0, 0, 0},
    StrokeColor = {0, 0, 0},
    StrokeWidth = 1,
    CornerRadius = 8,
    Position = {0, 0},
    Size = {730,220}
  })
  table.insert(graphics,{
    Type = "Text",
    Text = "UMD Enable",
    FontSize = 12,
    HTextAlign = "Center",
    Position = {125, 25},
    Size = {120, 25}
  })
  table.insert(graphics,{
    Type = "Text",
    Text = "Position",
    FontSize = 12,
    HTextAlign = "Center",
    Position = {245, 25},
    Size = {120, 25}
  })
  table.insert(graphics,{
    Type = "Text",
    Text = "Text Color",
    FontSize = 12,
    HTextAlign = "Center",
    Position = {365, 25},
    Size = {120, 25}
  })
  table.insert(graphics,{
    Type = "Text",
    Text = "Background Color",
    FontSize = 12,
    HTextAlign = "Center",
    Position = {485, 25},
    Size = {120, 25}
  })
  table.insert(graphics,{
    Type = "Text",
    Text = "Content",
    FontSize = 12,
    HTextAlign = "Center",
    Position = {605, 25},
    Size = {120, 25}
  })
  for idx = 1, 4 do
    table.insert(graphics,{
      Type = "Text",
      Text = "SDI IN "..idx,
      FontSize = 12,
      HTextAlign = "Right",
      Position = {5, 50 + (40 * (idx-1))},
      Size = {120, 25}
    })
    layout["window_"..idx.."_umd_enable"] = {
      PrettyName = "Umd~Enable",
      Style = "ComboBox",
      Margin = 0,
      CornerRadius = 0,
      Position = {125, 50 + (40 * (idx-1))},
      Size = {120, 25}
    }
    layout["window_"..idx.."_umd_position"] = {
      PrettyName = "Umd~Position",
      Style = "ComboBox",
      Margin = 0,
      CornerRadius = 0,
      Position = {245, 50 + (40 * (idx-1))},
      Size = {120, 25}
    }
    layout["window_"..idx.."_umd_text_color"] = {
      PrettyName = "Umd~Text Color",
      Style = "ComboBox",
      Margin = 0,
      CornerRadius = 0,
      Position = {365, 50 + (40 * (idx-1))},
      Size = {120, 25}
    }
    layout["window_"..idx.."_umd_background_color"] = {
      PrettyName = "Umd~Background Color",
      Style = "ComboBox",
      Margin = 0,
      CornerRadius = 0,
      Position = {485, 50 + (40 * (idx-1))},
      Size = {120, 25}
    }
    layout["window_"..idx.."_umd_text"] = {
      PrettyName = "Umd~Text",
      Style = "Text",
      Margin = 0,
      CornerRadius = 0,
      Position = {605, 50 + (40 * (idx-1))},
      Size = {120, 25}
    }
  end
end
if CurrentPage == "Audio Meter" then
  table.insert(graphics,{
    Type = "GroupBox",
    Fill = {0, 0, 0, 0},
    StrokeColor = {0, 0, 0},
    StrokeWidth = 1,
    CornerRadius = 8,
    Position = {0, 0},
    Size = {730,220}
  })
  table.insert(graphics,{
    Type = "Text",
    Text = "Meter Enable",
    FontSize = 12,
    HTextAlign = "Center",
    Position = {125, 25},
    Size = {120, 25}
  })
  table.insert(graphics,{
    Type = "Text",
    Text = "Position",
    FontSize = 12,
    HTextAlign = "Center",
    Position = {245, 25},
    Size = {120, 25}
  })
  table.insert(graphics,{
    Type = "Text",
    Text = "Channel",
    FontSize = 12,
    HTextAlign = "Center",
    Position = {365, 25},
    Size = {120, 25}
  })

  for idx = 1, 4 do
    table.insert(graphics,{
      Type = "Text",
      Text = "SDI IN "..idx,
      FontSize = 12,
      HTextAlign = "Right",
      Position = {5, 50 + (40 * (idx-1))},
      Size = {120, 25}
    })
    layout["window_"..idx.."_audiometer_enable"] = {
      PrettyName = "Audio Meter~Enable",
      Style = "ComboBox",
      Margin = 0,
      CornerRadius = 0,
      Position = {125, 50 + (40 * (idx-1))},
      Size = {120, 25}
    }
    layout["window_"..idx.."_audiometer_position"] = {
      PrettyName = "Audio Meter~Position",
      Style = "ComboBox",
      Margin = 0,
      CornerRadius = 0,
      Position = {245, 50 + (40 * (idx-1))},
      Size = {120, 25}
    }
    layout["window_"..idx.."_audiometer_channel"] = {
      PrettyName = "Audio Meter~Channel",
      Style = "ComboBox",
      Margin = 0,
      CornerRadius = 0,
      Position = {365, 50 + (40 * (idx-1))},
      Size = {120, 25}
    }
  end
end
if CurrentPage == "Status Display" then
  table.insert(graphics,{
    Type = "GroupBox",
    Fill = {0, 0, 0, 0},
    StrokeColor = {0, 0, 0},
    StrokeWidth = 1,
    CornerRadius = 8,
    Position = {0, 0},
    Size = {730,220}
  })
  table.insert(graphics,{
    Type = "Text",
    Text = "Status Enable",
    FontSize = 12,
    HTextAlign = "Center",
    Position = {125, 25},
    Size = {120, 25}
  })
  table.insert(graphics,{
    Type = "Text",
    Text = "Position",
    FontSize = 12,
    HTextAlign = "Center",
    Position = {245, 25},
    Size = {120, 25}
  })
  table.insert(graphics,{
    Type = "Text",
    Text = "Text Color",
    FontSize = 12,
    HTextAlign = "Center",
    Position = {365, 25},
    Size = {120, 25}
  })
  table.insert(graphics,{
    Type = "Text",
    Text = "Background Color",
    FontSize = 12,
    HTextAlign = "Center",
    Position = {485, 25},
    Size = {240, 25}
  })
  for idx = 1, 4 do
    table.insert(graphics,{
      Type = "Text",
      Text = "SDI IN "..idx,
      FontSize = 12,
      HTextAlign = "Right",
      Position = {5, 50 + (40 * (idx-1))},
      Size = {120, 25}
    })
    layout["window_"..idx.."_osd_enable"] = {
      PrettyName = "Osd~Enable",
      Style = "ComboBox",
      Margin = 0,
      CornerRadius = 0,
      Position = {125, 50 + (40 * (idx-1))},
      Size = {120, 25}
    }
    layout["window_"..idx.."_osd_position"] = {
      PrettyName = "Osd~Position",
      Style = "ComboBox",
      Margin = 0,
      CornerRadius = 0,
      Position = {245, 50 + (40 * (idx-1))},
      Size = {120, 25}
    }
    layout["window_"..idx.."_osd_text_color"] = {
      PrettyName = "Osd~Text Color",
      Style = "ComboBox",
      Margin = 0,
      CornerRadius = 0,
      Position = {365, 50 + (40 * (idx-1))},
      Size = {120, 25}
    }
    layout["window_"..idx.."_osd_background_color"] = {
      PrettyName = "Osd~Background Color",
      Style = "ComboBox",
      Margin = 0,
      CornerRadius = 0,
      Position = {485, 50 + (40 * (idx-1))},
      Size = {240, 25}
    }
  end
end