drawhilights = function()

  abilities.combust.hilight = buffs.conflagrate.active
  abilities.sonic.hilight   = buffs.runiccharge.active
  abilities.conc.hilight    = buffs.runiccharge.active
  abilities.dbreath.hilight = (buffs.runiccharge.active or buffs.combust.active)
  abilities.assault.hilight = buffs.bloodlust.active and ((buffs.bloodlust.number or false) >= 4 and true or false) or false
  abilities.flurry.hilight = buffs.bloodlust.active and ((buffs.bloodlust.number or false) >= 4 and true or false) or false
  abilities.hurricane.hilight = buffs.bloodlust.active and ((buffs.bloodlust.number or false) >= 4 and true or false) or false
  abilities.gbarge.hilight = buffs.gbarge.active

  hilightabilities()

end