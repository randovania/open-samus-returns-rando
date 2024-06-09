GUILib = GUILib or {}

function GUILib.InitCustomUI()
  GUILib.AddDNACounter()
  GUILib.AddMessageBox()
end


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
    Visible = true,
    SkinItemType = "",
    Autosize = false,
    SpriteSheetItem = "IconL_MetroidDNAData"
  })))
  lowerInfo:AddChild((GUI.CreateDisplayObjectEx("DNAMechCounterRando", "CText", {
    X = "0.24688",
    Y = "0.02500",
    SizeX = "0.12499",
    SizeY = "0.05833",
    ColorR = "0.68000",
    ColorG = "0.83000",
    ColorB = "0.93000",
    ColorA = "1.00000",
    Enabled = true,
    Visible = true,
    Text = "10 / 10",
    Font = "digital_hefty",
    TextAlignment = "Left",
    Autosize = true,
    Outline = true
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
end


function GUILib.UpdateDNACounter(currentDNA, maxDNA)
  local dna =  GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.LowerComposition.LowerInfoComposition.DNAMechCounterRando")
  if dna ~= nil then
      GUI.SetTextText(dna, tostring(currentDNA) .. " / " .. tostring(maxDNA))
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

function GUILib.AddMessageBox() 
  local randoUI = GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.USSEF.Outer")
  if randoUI ~= nil then
    GUI.DestroyDisplayObject(randoUI)
  end
  local ussef = GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.USSEF")
  local outer = GUI.CreateDisplayObjectEx("Outer", "CDisplayObjectContainer", {
      StageID = "Up",
      X = "0.038",
      Y = "0.829",
      Visible = false
  })
  local topL = GUI.CreateDisplayObjectEx("TopL",  "CSprite", {
    X = "0.0",
    Y = "0.0",
    Visible = true,
    SpriteSheetItem = "TutorialWindowTop"
  })
  local topR = GUI.CreateDisplayObjectEx("TopR",  "CSprite", {
    X = "0.462",
    Y = "0.0",
    FlipX = true,
    Visible = true,
    SpriteSheetItem = "TutorialWindowTop"
  })
  local hiMidL = GUI.CreateDisplayObjectEx("hiMidL",  "CSprite", {
    X = "0.0",
    Y = "0.024",
    Visible = true,
    SpriteSheetItem = "TutorialWindowMid"
  })
  local hiMidR = GUI.CreateDisplayObjectEx("hiMidR",  "CSprite", {
    X = "0.462",
    Y = "0.024",
    FlipX = true,
    Visible = true,
    SpriteSheetItem = "TutorialWindowMid"
  })
  local loMidL = GUI.CreateDisplayObjectEx("loMidL",  "CSprite", {
    X = "0.0",
    Y = "0.083",
    Visible = true,
    SpriteSheetItem = "TutorialWindowMid"
  })
  local loMidR = GUI.CreateDisplayObjectEx("loMidR",  "CSprite", {
    X = "0.462",
    Y = "0.083",
    FlipX = true,
    Visible = true,
    SpriteSheetItem = "TutorialWindowMid"
  })
  local bottomL = GUI.CreateDisplayObjectEx("BotL",  "CSprite", {
    X = "0.0",
    Y = "0.141",
    Visible = true,
    SpriteSheetItem = "TutorialWindowBot"
  })
  local bottomR = GUI.CreateDisplayObjectEx("BotR",  "CSprite", {
    X = "0.462",
    Y = "0.142",
    FlipX = true,
    Visible = true,
    SpriteSheetItem = "TutorialWindowBot"
  })
  local firstLine = GUI.CreateDisplayObjectEx("firstLine",  "CText", {
      X = "-0.038",
      Font = "digital_medium",
      TextAlignment = "Centered",
      Visible = true,
  })
  local secondLine = GUI.CreateDisplayObjectEx("secondLine",  "CText", {
      X = "-0.038",
      Y = "0.080",
      Font = "digital_medium",
      TextAlignment = "Centered",
      Visible = true
  })
  ussef:AddChild(outer)
  outer:AddChild(topL)
  outer:AddChild(topR)
  outer:AddChild(hiMidL)
  outer:AddChild(hiMidR)
  outer:AddChild(loMidL)
  outer:AddChild(loMidR)
  outer:AddChild(bottomL)
  outer:AddChild(bottomR)
  outer:AddChild(firstLine)
  outer:AddChild(secondLine)

  local disconnectLine = GUI.CreateDisplayObjectEx("disconnected",  "CText", {
      X = "-0.30",
      Y = "0.05",
      Font = "digital_medium",
      Text= "Disconnected!",
      TextAlignment = "Centered",
      ColorR = 0.9, ColorG = 0.1, ColorB = 0.1,
      BlinkColorR = "0.9", BlinkColorG = "0.1", BlinkColorB = "0.1", BlinkAlpha = "1.00000", Blink = "2.00000",
      Visible = false
  })
  ussef:AddChild(disconnectLine)
  local disconnectIcon = GUI.CreateDisplayObjectEx("disconnectedicon",  "CSprite", {
    X = "0.03",
    Y = "0.05",
    SizeX = "0.05",
    SizeY = "0.07",
    Visible = false,
    ColorR = 0.9, ColorG = 0.1, ColorB = 0.1,
    Blink = "2.00000",
    SpriteSheetItem = "IconX_01"
  })
  ussef:AddChild(disconnectIcon)

  GUILib.outer = outer
  GUILib.firstLine = firstLine
  GUILib.secondLine = secondLine
  GUILib.disconnectLine = disconnectLine
  GUILib.disconnectIcon = disconnectIcon
end

function GUILib.split(source, delimiters)
  local elements = {}
  local pattern = '([^'..delimiters..']+)'
  for word in source:gmatch(pattern) do
      elements[#elements + 1] =     word
  end
  return elements
end

function GUILib.ShowMessage(text)
  local splitted = GUILib.split(text, "\n")
  if #splitted == 2 then
    GUI.SetProperties(GUILib.firstLine, {
      Y = "0.015",
    })
    GUI.SetTextText(GUILib.firstLine, splitted[1])
    GUI.SetTextText(GUILib.secondLine, splitted[2])
  else
    GUI.SetProperties(GUILib.firstLine, {
      Y = "0.045",
    })
    GUI.SetTextText(GUILib.firstLine, text)
    GUI.SetTextText(GUILib.secondLine, "")
  end

  GUI.SetProperties(GUILib.outer, {
    Visible = true
  })
end

function GUILib.HideMessage() 
  GUI.SetProperties(GUILib.outer, {
    Visible = false
  })
end

function GUILib.UpdateConnected(visible)
  GUI.SetProperties(GUILib.disconnectLine, {
      Visible = visible
  })
  GUI.SetProperties(GUILib.disconnectIcon, {
      Visible = visible
  })
end