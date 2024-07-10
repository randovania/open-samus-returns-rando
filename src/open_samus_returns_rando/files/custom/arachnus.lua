Game.ImportLibrary("actors/characters/arachnus/scripts/arachnus_original.lc")
function Arachnus.main()
  Game.AddSF(0.0, "Arachnus.RotatePickup", "")
end
function Arachnus.RotatePickup()
  local springball = Game.GetEntity("LE_PowerUp_Springball")
  if springball ~= nil then
    if springball.vAng ~= V3D(0, 0 ,0) then
      springball.vAng = V3D(0, 0, 0)
    else
      Game.AddSF(0.0, "Arachnus.RotatePickup", "")
    end
  end
end
