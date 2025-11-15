drawgauge = function ()
  lineprogram:setuniform4f(2, 207/255, 251/255, 236/255, 1) -- line colour (rgba, 0.0 - 1.0)

  -- set up elements
  local bars = bars.magic
  updatebarlist(bars, t)

  local ui = images['gauge-ui'].default
  local mage = ui.magic

  local sunimg = mage.sunshine[(buffs.sunshine.active and 'active') or (buffs.gsunshine.active and 'active') or 'inactive']
  local tsuimg = mage.tsunami[buffs.tsunami.active and 'active' or 'inactive']

  local geimg = mage['glacial-embrace'][buffs.incitefear.active and ((buffs.incitefear.parensnumber < 5) and '0' or '5') or '0']

  local btimg = mage['blood-tithe'][buffs.exsanguinate.active and ((buffs.exsanguinate.parensnumber < 12) and '0' or '12') or '0']

  ask = (buffs.exsanguinate.number == 20 and 'exsanguinate') or (buffs.incitefear.number == 20 and 'incite-fear') or (ask or 'no-spell')
  local asimg = mage['active-spell'][ask]

  local ceimg = mage['corruption-essence'][((not buffs.corruptionessence.active and '0') or (buffs.corruptionessence.parensnumber < 1 and '0') or (buffs.corruptionessence.parensnumber < 25 and '1') or (buffs.corruptionessence.parensnumber < 50 and '2') or '3') .. (not buffs.soulfire.active and "-ready" or "")]

  local dnessimg = ui.aspects.darkness[buffs.darkness.active and 'active']
  local taimg = ui.aspects['temporal-anomaly'][(buffs.temporalanomaly.active and 'active') or (models.temporalanomaly.foundoncheckframe and 'ta-activate')]
  local adimg = ui.aspects['animate-dead'][buffs.animatedead.active and 'active']

  local instimg = mage.instability[(buffs.instability.active and 'active') or (not buffs.instabilitycd.active and 'ready') or 'notready']

  local interface = mage[intname]

  -- elements are actually drawn here
  interface.surface:drawtoscreen(0, 0, interface.width, interface.height, gx, gy, gw, gh)

  if buffs.temporalanomaly.active then
    taimg.surface:drawtoscreen(0, 0, taimg.width, taimg.height, gx + math.floor(gw * 0.70), gy - ( 28 * scale / 2), 30 * scale, 30 * scale)
  elseif buffs.animatedead.active then
    adimg.surface:drawtoscreen(0, 0, adimg.width, adimg.height, gx + math.floor(gw * 0.70), gy - ( 28 * scale / 2), 30 * scale, 30 * scale)
  elseif buffs.darkness.active then
    dnessimg.surface:drawtoscreen(0, 0, dnessimg.width, dnessimg.height, gx + math.floor(gw * 0.70), gy - ( 28 * scale / 2), 30 * scale, 30 * scale)
  end

  sunimg.surface:drawtoscreen(0, 0, sunimg.width, sunimg.height, gx + math.floor(gw * 0.79), gy - ( 45 * scale / 2), 60 * scale, 60 * scale)
  if bars.sunshine.start ~= nil then
    local elapsed = t - bars.sunshine.start
    updatelinesurface(elapsed, bars.sunshine.max, lineprogram, linesurface, 100)
    linesurface:drawtoscreen(0, 0, linesurfacesize, linesurfacesize, gx + math.floor(gw * 0.79), gy - ( 45 * scale / 2), 60 * scale, 60 * scale)
  end
  if bars.gsunshine.start ~= nil then
    local elapsed = t - bars.gsunshine.start
    updatelinesurface(elapsed, bars.gsunshine.max, lineprogram, linesurface, 100)
    linesurface:drawtoscreen(0, 0, linesurfacesize, linesurfacesize, gx + math.floor(gw * 0.79), gy - ( 45 * scale / 2), 60 * scale, 60 * scale)
  end

  tsuimg.surface:drawtoscreen(0, 0, tsuimg.width, tsuimg.height, gx + math.floor(gw * 0.87), gy + ( 22 * scale), 60 * scale, 60 * scale)
  if bars.tsunami.start ~= nil then
    local elapsed = t - bars.tsunami.start
    updatelinesurface(elapsed, bars.tsunami.max, lineprogram, linesurface, 100)
    linesurface:drawtoscreen(0, 0, linesurfacesize, linesurfacesize, gx + math.floor(gw * 0.87), gy + ( 22 * scale), 60 * scale, 60 * scale)
  end

  ceimg.surface:drawtoscreen(0, 0, ceimg.width, ceimg.height, gx + math.floor(gw * 0.2), gy - (14 * scale), 27 * scale * 3, 27 * scale)
  if bars.corruptionessence.start ~= nil then
    local cebar = mage['corruption-essence'].cebar
    local elapsed = bars.corruptionessence.max - (buffs.corruptionessence.number * 1000000)
    local width = math.floor(barfill(bars.corruptionessence.max, elapsed, 180) * scale)
    cebar.surface:drawtoscreen(0, 0, cebar.width, cebar.height, gx + math.floor(gw * 0.2), gy + (18 * scale), width, 6 * scale)
  end

  btimg.surface:drawtoscreen(0, 0, btimg.width, btimg.height, gx + (-2 * scale), gb - ( 15 * scale), 20 * scale, 20 * scale)
  if bars.exsanguinate.start ~= nil then
    local btbar = mage['blood-tithe'].btbar
    local elapsed = bars.exsanguinate.max - (buffs.exsanguinate.number * 1000000)
    local width = math.floor(barfill(bars.exsanguinate.max, elapsed, 180) * scale)
    btbar.surface:drawtoscreen(0, 0, btbar.width, btbar.height, gx + math.floor(gw * 0.2), gy + (8 * scale) + (22 * scale), width, 3 * scale)
  end

  geimg.surface:drawtoscreen(0, 0, geimg.width, geimg.height, gx + (42 * scale), gb - ( 15 * scale), 20 * scale, 20 * scale)
  if bars.incitefear.start ~= nil then
    local gebar = mage['glacial-embrace'].gebar
    local elapsed = bars.incitefear.max - (buffs.incitefear.number * 1000000)
    local width = math.floor(barfill(bars.incitefear.max, elapsed, 180) * scale)
    gebar.surface:drawtoscreen(0, 0, gebar.width, gebar.height, gx + math.floor(gw * 0.2), gy + (6 * scale) + (28 * scale), width, 3 * scale)
  end

  instimg.surface:drawtoscreen(0, 0, instimg.width, instimg.height, gx + math.floor(gw * 0.75), gb - ( 25 * scale), 32 * scale, 32 * scale)
  if bars.instability.start ~= nil then
    local instbar = mage.instability.instbar
    local elapsed = t - bars.instability.start
    local width = math.floor(barfill(bars.instability.max, elapsed, 180) * scale)
    instbar.surface:drawtoscreen(0, 0, instbar.width, instbar.height, gx + math.floor(gw * 0.2), gy + (6 * scale) + (34 * scale), width, 3 * scale)
  end

  asimg.surface:drawtoscreen(0, 0, asimg.width, asimg.height, gx - (7 * scale), gy - (12 * scale), 75 * scale, 75 * scale)
end