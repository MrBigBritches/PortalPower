function PortalPower.Addon:Debug(text)
  if self.settings:get('debugEnabled') == true then
    self:Print(text)
  end
end