drawgauge = function ()
  lineprogram:setuniform4f(2, 224/255, 47/255, 221/255, 1) -- line colour (rgba, 0.0 - 1.0)

  local bars = bars.necromancy
  updatebarlist(bars, t)

  local ui = images['gauge-ui'].default
  local necro = ui.necromancy
  local necrosisimg = necro.necrosis[buffs.necrosis.active and buffs.necrosis.number or 0]
  local conjuresimg = necro['conjure-undead-army'][(buffs.skeletonwarrior.active and buffs.vengefulghost.active and buffs.putridzombie.active and buffs.phantomguardian.active) and 'active' or 'inactive']
  local soulsimg = necro['residual-souls'][buffs.residualsouls.active and ((buffs.residualsouls.parensnumber ~= nil) and buffs.residualsouls.parensnumber or buffs.residualsouls.number) or 0]
  local ldimg = necro['living-death'][buffs.livingdeath.active and 'active' or 'inactive']
  local threadsimg = necro.incantations['threads-of-fate'][buffs.threadsoffate.active and 'active' or 'inactive']
  local ssimg = necro.incantations['split-soul'][buffs.splitsoul.active and 'active' or 'inactive']
  local dmimg = necro.incantations['invoke-death'][buffs.deathmark.active and 'active' or 'inactive']
  local dnessimg = ui.aspects.darkness[buffs.darkness.active and 'active' or 'inactive']
  local taimg = ui.aspects['temporal-anomaly'][(buffs.temporalanomaly.active and 'active') or (models.temporalanomaly.foundoncheckframe and 'ta-activate')]
  local adimg = ui.aspects['animate-dead'][buffs.animatedead.active and 'active']

  local interface = necro[intname]
  interface.surface:drawtoscreen(0, 0, interface.width, interface.height, gx, gy, gw, gh)
  conjuresimg.surface:drawtoscreen(0, 0, conjuresimg.width, conjuresimg.height, gx - (8 * scale), gy - (8 * scale), 75 * scale, 75 * scale)

  dmimg.surface:drawtoscreen(0, 0, dmimg.width, dmimg.height, gm + ( 50 * scale), gb - (25 * scale), 30 * scale, 30 * scale)

  if buffs.temporalanomaly.active then
    taimg.surface:drawtoscreen(0, 0, taimg.width, taimg.height, gm + (85 * scale), gb - (25 * scale), 30 * scale, 30 * scale)
  elseif buffs.animatedead.active then
    adimg.surface:drawtoscreen(0, 0, adimg.width, adimg.height, gm + (85 * scale), gb - (25 * scale), 30 * scale, 30 * scale)
  else
    dnessimg.surface:drawtoscreen(0, 0, dnessimg.width, dnessimg.height, gm + (85 * scale), gb - (25 * scale), 30 * scale, 30 * scale)
  end

  threadsimg.surface:drawtoscreen(0, 0, threadsimg.width, threadsimg.height, gm - (50 * scale), gy - (10 * scale), 20 * scale, 20 * scale)
  if bars.threadsoffate.start ~= nil then
    local tofbar = necro.incantations['threads-of-fate'].tofbar
    local elapsed = t - bars.threadsoffate.start
    local tofwidth = math.floor(barfill(bars.threadsoffate.max, elapsed, 150) * scale)
    tofbar.surface:drawtoscreen(0, 0, tofbar.width, tofbar.height, gx + math.floor(gw * 0.2), gy + (30 * scale), tofwidth, 3 * scale)
  end

  ssimg.surface:drawtoscreen(0, 0, ssimg.width, ssimg.height, gm - (25 * scale), gy - ( 12 * scale), 24 * scale, 24 * scale)
  if bars.splitsoul.start ~= nil then
    local ssbar = necro.incantations['split-soul'].ssbar
    local elapsed = t - bars.splitsoul.start
    local sswidth = math.floor(barfill(bars.splitsoul.max, elapsed, 150) * scale)
    ssbar.surface:drawtoscreen(0, 0, ssbar.width, ssbar.height, gx + math.floor(gw * 0.2), gy + (24 * scale), sswidth, 3 * scale)
  end

  ldimg.surface:drawtoscreen(0, 0, ldimg.width, ldimg.height, gx + math.floor(gw * 0.83), gy - (8 * scale), 75 * scale, 75 * scale)
  if bars.livingdeath.start ~= nil then
    local elapsed = t - bars.livingdeath.start
    updatelinesurface(elapsed, bars.livingdeath.max, lineprogram, linesurface, 100)
    linesurface:drawtoscreen(0, 0, linesurfacesize, linesurfacesize, gx + math.floor(gw * 0.83), gy - (8 * scale), 75 * scale, 75 * scale)
  end

  soulsimg.surface:drawtoscreen(0, 0, soulsimg.width, soulsimg.height, gx + math.floor(gw * 0.2) - (2 * scale), gb - (27 * scale), 24 * scale * 5, 24 * scale)

  local bloat = necro.bloat
  bloat.bloatbg.surface:drawtoscreen(0, 0, bloat.bloatbg.width, bloat.bloatbg.height, gx + math.floor(gw * 0.2) - (2 * scale), gy + (13 * scale) - (2 * scale), 154 * scale, 12 * scale)
  bloat.bloatframe.surface:drawtoscreen(0, 0, bloat.bloatframe.width, bloat.bloatframe.height, gx + math.floor(gw * 0.2) - (2 * scale), gy + (13 * scale) - (2 * scale), 154 * scale, 12 * scale)
  if bars.bloat.start then
    local ticker = images.interface[intstyle].ticker
    local elapsed = t - bars.bloat.start
    local bloatbarwidth = math.floor(barfill(bars.bloat.max, elapsed, 150) * scale)
    local tickerx = gx + math.floor(gw * 0.2) + bloatbarwidth - (7 * scale)
    bloat.bloatbar.surface:drawtoscreen(0, 0, bloat.bloatbar.width, bloat.bloatbar.height, gx + math.floor(gw * 0.2), gy + (14 * scale), bloatbarwidth, 6 * scale)
    ticker.surface:drawtoscreen(0, 0, ticker.width, ticker.height, tickerx, gy + (13 * scale) - (2 * scale), 9 * scale, 10 * scale)
  end

  necrosisimg.surface:drawtoscreen(0, 0, necrosisimg.width, necrosisimg.height, gm + (50 * scale), gy - (16 * scale), 32 * scale * 2, 32 * scale)
end