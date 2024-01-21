
GUILib = GUILib or {}

function GUILib.AddDNACounter()
  local randoUI = GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.LowerComposition.LowerInfoComposition.DNAMechIconRando")
  if randoUI ~= nil then
    return
  end
     
  local lowerInfo =  GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.LowerComposition.LowerInfoComposition")
  lowerInfo:AddChild((GUI.CreateDisplayObjectEx("DNAMechIconRando", "CSprite", {
    X = "0.17188",
    Y = "0.02500",
    SizeX = "0.06562",
    SizeY = "0.09166",
    ScaleX = "1.00000",
    ScaleY = "1.00000",
    Angle = "0.00000",
    FlipX = false,
    FlipY = false,
    Enabled = true,
    Visible = true,
    SkinItemType = "",
    Autosize = false,
    SpriteSheetItem = "IconL_MetroidDNAData",
    BlendMode = "AlphaBlend",
    USelMode = "Scale",
    VSelMode = "Scale"
  })))
  lowerInfo:AddChild((GUI.CreateDisplayObjectEx("DNAMechCounterRando", "CText", {
    X = "0.24688",
    Y = "0.02500",
    SizeX = "0.12499",
    SizeY = "0.05833",
    ScaleX = "1.00000",
    ScaleY = "1.00000",
    Angle = "0.00000",
    FlipX = false,
    FlipY = false,
    ColorR = "0.68000",
    ColorG = "0.83000",
    ColorB = "0.93000",
    ColorA = "1.00000",
    Enabled = true,
    Visible = true,
    SkinItemType = "",
    Text = "10 / 10",
    Font = "digital_hefty",
    TextAlignment = "Left",
    Autosize = true,
    Outline = true,
    EmbeddedSpritesSuffix = "",
    BlinkColorR = "1.00000",
    BlinkColorG = "1.00000",
    BlinkColorB = "1.00000",
    BlinkAlpha = "1.00000",
    Blink = "-1.00000"
  })))
  local dnaCounterVanilla =  GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.LowerComposition.LowerInfoComposition.DNAMechCounter")
  local dnaIconVanilla =  GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.LowerComposition.LowerInfoComposition.DNAMechIcon")
  GUI.SetProperties(dnaCounterVanilla, {
    Enabled = false,
    Visible = false
  })
  GUI.SetProperties(dnaIconVanilla, {
    Enabled = false,
    Visible = false
  })

  local mapDNA = GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.PercentComposition")
  mapDNA:AddChild((GUI.CreateDisplayObjectEx("MapDNABase", "CSprite", {
    X = "0.73963",
    Y = "-0.02083",
    SizeX = "0.24375",
    SizeY = "0.10417",
    ScaleX = "1.00000",
    ScaleY = "1.00000",
    Angle = "0.00000",
    FlipX = false,
    FlipY = false,
    Enabled = true,
    SkinItemType = "",
    Autosize = false,
    SpriteSheetItem = "PercentBox",
    BlendMode = "AlphaBlend",
    USelMode = "Scale",
    VSelMode = "Scale"
  })))
  mapDNA:AddChild((GUI.CreateDisplayObjectEx("MapDNAIcon", "CSprite", {
    X = "0.76963",
    Y = "0.01233",
    SizeX = "0.0234345",
    SizeY = "0.037500",
    ScaleX = "1.00000",
    ScaleY = "1.00000",
    Angle = "0.00000",
    FlipX = false,
    FlipY = false,
    Enabled = true,
    SkinItemType = "",
    Autosize = false,
    SpriteSheetItem = "Icon_MetroidDNACount",
    BlendMode = "AlphaBlend",
    USelMode = "Scale",
    VSelMode = "Scale"
  })))
  mapDNA:AddChild((GUI.CreateDisplayObjectEx("MapDNALabel", "CText", {
    X = "0.83563",
    Y = "0.00833",
    SizeX = "0.12499",
    SizeY = "0.06666",
    ScaleX = "1.00000",
    ScaleY = "1.00000",
    Angle = "0.00000",
    FlipX = false,
    FlipY = false,
    ColorR = "0.76000",
    ColorG = "0.89000",
    ColorB = "1.00000",
    ColorA = "1.00000",
    Enabled = true,
    SkinItemType = "",
    Text = "10 / 10 DNA",
    Font = "digital_small",
    TextAlignment = "Right",
    Autosize = false,
    Outline = false,
    EmbeddedSpritesSuffix = "",
    BlinkColorR = "1.00000",
    BlinkColorG = "1.00000",
    BlinkColorB = "1.00000",
    BlinkAlpha = "1.00000",
    Blink = "-1.00000"
  })))
end

function GUILib.UpdateDNACounterHUD(currentDNA, maxDNA)
  local dna =  GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.LowerComposition.LowerInfoComposition.DNAMechCounterRando")
  if dna ~= nil then
    GUI.SetTextText(dna, tostring(currentDNA) .. " / " .. tostring(maxDNA))
    dna:ForceRedraw()
  end
end

function GUILib.UpdateDNACounterMap(currentDNA, maxDNA)
  local dna = GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.PercentComposition.MapDNALabel")
  if dna ~= nil then
      GUI.SetTextText(dna, tostring(currentDNA) .. " / " .. tostring(maxDNA) .. " DNA")
      dna:ForceRedraw()
  end
end

function GUILib.UpdateTotalDNAColor()
  if Game.GetItemAmount(Game.GetPlayerName(), "ITEM_ADN") < 39 then
    local dnaCounter = GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.LowerComposition.LowerInfoComposition.DNACounter")
    GUI.SetProperties(dnaCounter, {
      ColorR = "0.68000",
      ColorG = "0.83000",
      ColorB = "0.93000",
    })
  end
end