drawgauge = function ()
  lineprogram:setuniform4f(2, 207/255, 251/255, 236/255, 1) -- line colour (rgba, 0.0 - 1.0)

  -- set up elements
  local bars = bars.magic
  updatebarlist(bars, t)

  local ui = images['gauge-ui']['modern-condensed']
  local mage = ui.magic

  local sunimg = mage.sunshine[(buffs.sunshine.active and 'active') or (buffs.gsunshine.active and 'active') or 'inactive']
  local tsuimg = mage.tsunami[buffs.tsunami.active and 'active' or 'inactive']

  local geimg = mage['glacial-embrace'][buffs.incitefear.active and ((buffs.incitefear.parensnumber < 5) and '0' or '5') or '0']
  local gebarbg = mage['glacial-embrace'].gebarbg

  local btimg = mage['blood-tithe'][buffs.exsanguinate.active and ((buffs.exsanguinate.parensnumber < 12) and '0' or '12') or '0']
  local btbarbg = mage['blood-tithe'].btbarbg

  ask = (buffs.exsanguinate.number == 20 and 'exsanguinate2') or (buffs.incitefear.number == 20 and 'incite-fear2') or (ask or 'no-spell')
  local asimg = mage['active-spell'][ask]

  local ceimg = mage['corruption-essence'][((not buffs.corruptionessence.active and '0') or (buffs.corruptionessence.parensnumber < 1 and '0') or (buffs.corruptionessence.parensnumber < 25 and '1') or (buffs.corruptionessence.parensnumber < 50 and '2') or '3') .. (not buffs.soulfire.active and "-ready" or "")]
  local cebarframe = mage['corruption-essence'].cebarframe
  local cebarbg = mage['corruption-essence'].cebarbg

  local dnessimg = ui.aspects.darkness[buffs.darkness.active and 'active']
  local taimg = ui.aspects['temporal-anomaly'][(models.temporalanomaly.foundoncheckframe and 'ta-activate') or (buffs.temporalanomaly.active and 'active')]
  local adimg = ui.aspects['animate-dead'][buffs.animatedead.active and 'active']

  local instimg = mage.instability[(buffs.instability.active and 'active') or (not buffs.instabilitycd.active and 'ready') or 'notready']

  if buffs.temporalanomaly.active then
    taimg.surface:drawtoscreen(0, 0, taimg.width, taimg.height, gm + ((110) * scale), gv - (20 * scale), taimg.width * scale, taimg.height * scale)
  elseif buffs.animatedead.active then
    adimg.surface:drawtoscreen(0, 0, adimg.width, adimg.height, gm + ((110 + 10) * scale), gv - (10 * scale), adimg.width * scale, adimg.height * scale)
  elseif buffs.darkness.active then
    dnessimg.surface:drawtoscreen(0, 0, dnessimg.width, dnessimg.height, gm + ((110 + 10) * scale), gv - (10 * scale), dnessimg.width * scale, dnessimg.height * scale)
  end

  cebarbg.surface:drawtoscreen(0, 0, cebarbg.width, cebarbg.height, gm - (105 * scale), gv - (8 * scale), 221 * scale, 16 * scale)
  if bars.corruptionessence.start ~= nil then
    local cebar = mage['corruption-essence'].cebar
    local elapsed = bars.corruptionessence.max - (buffs.corruptionessence.number * 1000000)
    local width = math.floor(barfill(bars.corruptionessence.max, elapsed, 216) * scale)
    cebar.surface:drawtoscreen(0, 0, cebar.width, cebar.height, gm - (102 * scale), gv - (8 * scale), width, 16 * scale)
  end
  cebarframe.surface:drawtoscreen(0, 0, cebarframe.width, cebarframe.height, gm - (105 * scale), gv - (8 * scale), 221 * scale, 16 * scale)
  ceimg.surface:drawtoscreen(0, 0, ceimg.width, ceimg.height, gm - (105 * scale), gv - (35 * scale), 80 * scale, 30 * scale)

  if bars.sunshine.start ~= nil then
    local sunbar = mage.sunshine.sunbar
    local elapsed = t - bars.sunshine.start
    local width = math.floor(barfill(bars.sunshine.max, elapsed, 216) * scale)
    sunbar.surface:drawtoscreen(0, 0, sunbar.width, sunbar.height, gm - (101 * scale), gv - ((8 + 7) * scale), width, 16 * scale)
  end
  if bars.gsunshine.start ~= nil then
    local sunbar = mage.sunshine.sunbar
    local elapsed = t - bars.gsunshine.start
    local width = math.floor(barfill(bars.gsunshine.max, elapsed, 216) * scale)
    sunbar.surface:drawtoscreen(0, 0, sunbar.width, sunbar.height, gm - (101 * scale), gv - ((8 + 7) * scale), width, 16 * scale)
  end

  if bars.tsunami.start ~= nil then
    local tsubar = mage.tsunami.tsubar
    local elapsed = bars.tsunami.max - (buffs.tsunami.number * 1000000)
    local width = math.floor(barfill(bars.tsunami.max, elapsed, 214) * scale)
    tsubar.surface:drawtoscreen(0, 0, tsubar.width, tsubar.height, gm - (101 * scale), gv - (8  * scale) + (4 * scale), width, 16 * scale)
  end

  btimg.surface:drawtoscreen(0, 0, btimg.width, btimg.height, gm - (12 * scale), gv + (8 * scale), btimg.width * scale, btimg.height * scale)
  btbarbg.surface:drawtoscreen(0, 0, btbarbg.width, btbarbg.height, gm - ((13 + 55) * scale), gv + (18 * scale), btbarbg.width * scale, btbarbg.height * scale)
  if bars.exsanguinate.start ~= nil then
    local btbar = mage['blood-tithe'].btbar
    local elapsed = bars.exsanguinate.max - (buffs.exsanguinate.number * 1000000)
    local width = -barfill(bars.exsanguinate.max, elapsed, 55)
    btbar.surface:drawtoscreen(0, 0, btbar.width, btbar.height, gm - (13 * scale), gv + (15 * scale), width * scale, 6 * scale)
  end

  geimg.surface:drawtoscreen(0, 0, geimg.width, geimg.height, gm + (12 * scale), gv + (8 * scale), geimg.width * scale, geimg.height * scale)
  gebarbg.surface:drawtoscreen(0, 0, btbarbg.width, btbarbg.height, gm + ((13  + 22)* scale), gv + (18 * scale), gebarbg.width * scale, gebarbg.height * scale)
  if bars.incitefear.start ~= nil then
    local gebar = mage['glacial-embrace'].gebar
    local elapsed = bars.incitefear.max - (buffs.incitefear.number * 1000000)
    local width = math.floor(barfill(bars.incitefear.max, elapsed, 55) * scale)
    gebar.surface:drawtoscreen(0, 0, gebar.width, gebar.height, gm + ((13 + 22) * scale), gv + (15 * scale), width, 6 * scale)
  end

  if bars.instability.start ~= nil then
    local instbar = mage.instability.instbar
    local elapsed = t - bars.instability.start
    local width = math.floor(barfill(bars.instability.max, elapsed, 180) * scale)
    instbar.surface:drawtoscreen(0, 0, instbar.width, instbar.height, gx + math.floor(gw * 0.2), gy + (6 * scale) + (34 * scale), width, 3 * scale)
  end

  asimg.surface:drawtoscreen(0, 0, asimg.width, asimg.height, gm - ((110 + 28) * scale), gv - (16 * scale), 32 * scale, 32 * scale)
end