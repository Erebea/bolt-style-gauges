drawnecrogauge = function ()

  local bars = bars.necromancy
  updatebarlist(bars, t)


  local ui = images['gauge-ui']['modern-condensed']
  local necro = ui.necromancy

  local numssmall = necro.digitssmall
  local buffbg = necro.blackbg

  local necrosisimg = necro.necrosis[buffs.necrosis.active and buffs.necrosis.number or 0]
  local ldicon = necro['living-death'].icon
  local ldbg = necro['living-death'].bg
  local ldbar = necro['living-death'].bar
  local ldbarbg = necro['living-death'].barbg
  local lddigitsbg = necro['living-death'].digitsbg

  local ssimg = necro.incantations['split-soul'].active
  local ssbar = necro.incantations['split-soul'].ssbar
  local ssbarbg = necro.incantations['split-soul'].ssbarbg

  local soulsimg = necro['residual-souls'][buffs.residualsouls.active and ((buffs.residualsouls.parensnumber ~= nil) and buffs.residualsouls.parensnumber or buffs.residualsouls.number) or 0]

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

  local ssicon = necro.incantations['split-soul'].icon

-- quickly configure positions of the popup buffs
  local ldposx =  gm - 110
  local ldposy =  (gv - (96 + (numssmall.height / 2))) + 65

  local ssposx = ldposx + 65
  local ssposy = ldposy

-- ld

  if bars.livingdeath.start ~= nil then

    buffbg.surface:drawtoscreen(0, 0, buffbg.width, buffbg.height, ldposx - ( 4 * scale), (ldposy - 6) * scale, buffbg.width * scale, buffbg.height * scale)
    ldicon.surface:drawtoscreen(0, 0, ldicon.width, ldicon.height, ldposx * scale, ldposy * scale, ldicon.width * scale, ldicon.height * scale)

    local timeleft = math.floor((bars.livingdeath.max - (t - bars.livingdeath.start)) / 1000000)

    local lddigit1, lddigit2 = numparse(timeleft, numssmall.width / 10)
    numssmall.surface:drawtoscreen(lddigit1, 0, numssmall.width / 10, numssmall.height, ldposx + (20 * scale), ldposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
    numssmall.surface:drawtoscreen(lddigit2, 0, numssmall.width / 10, numssmall.height, ldposx + ((20 + (numssmall.width / 10)) * scale), ldposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)

  end

-- split soul
  if bars.splitsoul.start ~= nil then
    buffbg.surface:drawtoscreen(0, 0, buffbg.width, buffbg.height, ssposx - ( 4 * scale), (ssposy - 6) * scale, buffbg.width * scale, buffbg.height * scale)
    ssicon.surface:drawtoscreen(0, 0, ssicon.width, ssicon.height, ssposx * scale, ssposy, ssicon.width * scale, ssicon.height * scale)

    local timeleft = math.floor((bars.splitsoul.max - (t - bars.splitsoul.start)) / 1000000)
    local ssdigit1, ssdigit2 = numparse(timeleft, numssmall.width / 10)

    numssmall.surface:drawtoscreen(ssdigit1, 0, numssmall.width / 10, numssmall.height, ssposx + (20 * scale), ssposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
    numssmall.surface:drawtoscreen(ssdigit2, 0, numssmall.width / 10, numssmall.height, ssposx + ((20 + (numssmall.width / 10)) * scale), ssposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
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

  necrosisimg.surface:drawtoscreen(0, 0, necrosisimg.width, necrosisimg.height, gm + (58 * scale), gv - (39 * scale), necrosisimg.width * scale, necrosisimg.height * scale)

  soulsimg.surface:drawtoscreen(0, 0, soulsimg.width, soulsimg.height, gr - (32 * 5 * scale), gv + (8 * scale), soulsimg.width * scale, soulsimg.height * scale)

end