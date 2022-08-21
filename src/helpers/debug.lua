function PortalPower.Addon:Debug(text)
  if PortalPower.Settings:Get('debugEnabled') == true then
    self:Print(text)
  end
end
