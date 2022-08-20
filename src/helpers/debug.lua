function PortalPower.Addon:Debug(text)
  if self.Settings:Get('debugEnabled') == true then
    self:Print(text)
  end
end
