drawgauge = function ()
  lineprogram:setuniform4f(2, 224/255, 47/255, 221/255, 1) -- line colour (rgba, 0.0 - 1.0)

  local bars = bars.necromancy
  updatebarlist(bars, t)

  local ui = images['gauge-ui']['modern-condensed']
  local necro = ui.necromancy
  local necrosisimg = necro.necrosis[buffs.necrosis.active and buffs.necrosis.number or 0]
  local ldicon = necro['living-death'].icon
  local ldbg = necro['living-death'].bg
  local ldbar = necro['living-death'].bar
  local ldbarbg = necro['living-death'].barbg
  local lddigitsbg = necro['living-death'].digitsbg

  local ssimg = necro.incantations['split-soul'].active
  local ssbar = necro.incantations['split-soul'].ssbar
  local ssbarbg = necro.incantations['split-soul'].ssbarbg

  local dmimg = necro.incantations['invoke-death'][buffs.deathmark.active and 'active' or 'inactive']
  local dnessimg = ui.aspects.darkness[buffs.darkness.active and 'active' or 'inactive']
  local taimg = ui.aspects['temporal-anomaly'][(buffs.temporalanomaly.active and 'active') or (models.temporalanomaly.foundoncheckframe and 'ta-activate')]
  local adimg = ui.aspects['animate-dead'][buffs.animatedead.active and 'active']


  dmimg.surface:drawtoscreen(0, 0, dmimg.width, dmimg.height, gm + ((105 - 12) * scale), gv + (8 * scale), dmimg.width * scale, dmimg.height * scale)

  if buffs.temporalanomaly.active then
    taimg.surface:drawtoscreen(0, 0, taimg.width, taimg.height, gm + ((110) * scale), gv - (20 * scale), taimg.width * scale, taimg.height * scale)
  elseif buffs.animatedead.active then
    adimg.surface:drawtoscreen(0, 0, adimg.width, adimg.height, gm + ((110 + 10) * scale), gv - (10 * scale), adimg.width * scale, adimg.height * scale)
  elseif buffs.darkness.active then
    dnessimg.surface:drawtoscreen(0, 0, dnessimg.width, dnessimg.height, gm + ((110 + 10) * scale), gv - (10 * scale), dnessimg.width * scale, dnessimg.height * scale)
  end

  if bars.splitsoul.start ~= nil then
    ssimg.surface:drawtoscreen(0, 0, ssimg.width, ssimg.height, gm - (100 * scale), gv + (8 * scale), ssimg.width * scale, ssimg.height * scale) 
    local ssbar = necro.incantations['split-soul'].ssbar
    local elapsed = t - bars.splitsoul.start
    local width = math.floor(barfill(bars.splitsoul.max, elapsed, 55) * scale)
--    ssbarbg.surface:drawtoscreen(0, 0, ssbarbg.width, ssbarbg.height, gm - ((105 - ssimg.width - 5) * scale), gv + ((10 + 8) * scale), ssbarbg.width, ssbarbg.height * scale)
    ssbar.surface:drawtoscreen(0, 0, ssbar.width, ssbar.height, gm - ((100 - ssimg.width - 5) * scale), gv + ((9 + 5) * scale), width, ssbar.height * scale)
  end

  if bars.livingdeath.start ~= nil then
    ldbg.surface:drawtoscreen(0, 0, ldbg.width, ldbg.height, gm - (105 * scale), gv - (50 * scale), ldbg.width * scale, ldbg.height * scale)
    ldicon.surface:drawtoscreen(0, 0, ldicon.width, ldicon.height, gm - (105 * scale), gv - (50 * scale), ldicon.width * scale, ldicon.height * scale)

    local nums = necro['living-death'].digits
    local digit1, digit2 = numparse(buffs.livingdeath.number, nums.width / 10)
    lddigitsbg.surface:drawtoscreen(0, 0, lddigitsbg.width, lddigitsbg.height, gm - ((105 - 30) * scale), gv - ((50 - 4) * scale), lddigitsbg.width * scale, lddigitsbg.height * scale)
    nums.surface:drawtoscreen(digit1, 0, nums.width / 10, nums.height, gm - ((105 - 30 - 8) * scale), gv - ((50 - 10) * scale), nums.width / 10 * scale, nums.height * scale)
    nums.surface:drawtoscreen(digit2, 0, nums.width / 10, nums.height, gm - ((105 - 30 - 8 - (nums.width / 10)) * scale), gv - ((50 - 10) * scale), nums.width / 10 * scale, nums.height * scale)

    local elapsed = t - bars.livingdeath.start
    local width = math.floor(barfill(bars.livingdeath.max, elapsed, 94) * scale)
    ldbarbg.surface:drawtoscreen(0, 0, ldbarbg.width, ldbarbg.height, gm - ((105-32) * scale), gv - ((50-26) * scale), ldbarbg.width * scale, ldbarbg.height * scale)
    ldbar.surface:drawtoscreen(0, 0, ldbar.width, ldbar.height, gm - ((105-32) * scale), gv - ((50-26) * scale), width, ldbar.height * scale)
  end

  local bloat = necro.bloat
  bloat.bloatbg.surface:drawtoscreen(0, 0, bloat.bloatbg.width, bloat.bloatbg.height, gm - (105 * scale), gv - (8 * scale), 221 * scale, 16 * scale)
  bloat.bloatframe.surface:drawtoscreen(0, 0, bloat.bloatframe.width, bloat.bloatframe.height, gm - (105 * scale), gv - (8 * scale), 221 * scale, 16 * scale)
  if bars.bloat.start then
    local ticker = images.interface.modern.ticker
    local elapsed = t - bars.bloat.start
    local width = math.floor(barfill(bars.bloat.max, elapsed, (bloat.bloatframe.width - 4)) * scale)
    local tickerx = gx + math.floor(gw * 0.2) + width - (7 * scale)
    bloat.bloatbar.surface:drawtoscreen(0, 0, bloat.bloatbar.width, bloat.bloatbar.height, gm - (102 * scale), gv - (8 * scale), width, 16 * scale)
    ticker.surface:drawtoscreen(0, 0, ticker.width, ticker.height, tickerx, gv - (8 * scale), ticker.width, 16 * scale)
  end

  necrosisimg.surface:drawtoscreen(0, 0, necrosisimg.width, necrosisimg.height, gm + (60 * scale), gv - (38 * scale), necrosisimg.width * scale, necrosisimg.height * scale)
end