drawmagegauge = function ()

  -- set up elements
  local bars = bars.magic
  updatebarlist(bars, t)

  local ui = images['gauge-ui']['modern-condensed']
  local mage = ui.magic

  local numssmall = mage.digitssmall
  local buffbg = mage.blackbg

  local sunicon =  mage.sunshine[buffs.sunshine.active and 'icon' or 'iconi']
  local gsunicon = mage.sunshine[buffs.gsunshine.active and 'gicon' or 'giconi']
  local metaicon = mage.metamorphosis.icon
  local tsuicon = mage.tsunami.icon
  local fsoaicon = mage.instability.icon

  local geimg_key
  if buffs.incitefear.active and buffs.incitefear.number then
    if buffs.incitefear.parensnumber < 5 then
      geimg_key = '0'
    else
      if not buffs.glacialembrace.active then
        geimg_key = 'ready'
      else
        geimg_key = '5'
      end
    end
  else
    geimg_key = '0'
  end

-- Use the determined key to get the image
  local geimg = mage['glacial-embrace'][geimg_key]
  local gebarbg = mage['glacial-embrace'].gebarbg

  local btimg = mage['blood-tithe'][buffs.exsanguinate.active and ((buffs.exsanguinate.parensnumber or 0) < 12 and '0' or '12') or '0']
  local btbarbg = mage['blood-tithe'].btbarbg

  ask = (buffs.exsanguinate.number == 20 and 'exsanguinate2') or (buffs.incitefear.number == 20 and 'incite-fear2') or (ask or 'no-spell')
  local asimg = mage['active-spell'][ask]

  local ceimg = mage['corruption-essence'][((not buffs.corruptionessence.active and '0') or ((buffs.corruptionessence.parensnumber or 0) < 1 and '0') or ((buffs.corruptionessence.parensnumber or 0) < 25 and '1') or ((buffs.corruptionessence.parensnumber or 0) < 50 and '2') or '3') .. (not buffs.soulfire.active and "-ready" or "")]
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
    cebar.surface:drawtoscreen(0, 0, width, cebar.height, gm - (102 * scale), gv - (8 * scale), width, 16 * scale)
  end
  cebarframe.surface:drawtoscreen(0, 0, cebarframe.width, cebarframe.height, gm - (105 * scale), gv - (8 * scale), 221 * scale, 16 * scale)
  ceimg.surface:drawtoscreen(0, 0, ceimg.width, ceimg.height, gm - (105 * scale), gv - (35 * scale), 80 * scale, 30 * scale)

-- temp buffs

  -- quickly configure positions of the popup buffs
  local sunposx =  gm - 20
  local sunposy =  (gv - (96 + (numssmall.height / 2))) + 70

  local tsuposx = sunposx + 65
  local tsuposy = sunposy

  local fsoaposx = tsuposx + 65
  local fsoaposy = sunposy

  if bars.sunshine.start ~= nil then
    buffbg.surface:drawtoscreen(0, 0, buffbg.width, buffbg.height, sunposx - ( 14 * scale), (sunposy - 6) * scale, buffbg.width * scale, buffbg.height * scale)
    sunicon.surface:drawtoscreen(0, 0, sunicon.width, sunicon.height, sunposx * scale, sunposy, sunicon.width * scale, sunicon.height * scale)

    local timeleft = math.floor((bars.sunshine.max - (t - bars.sunshine.start)) / 1000000)
    local sundigit1, sundigit2 = numparse(timeleft, numssmall.width / 10)

    numssmall.surface:drawtoscreen(sundigit1, 0, numssmall.width / 10, numssmall.height, sunposx + (20 * scale), sunposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
    numssmall.surface:drawtoscreen(sundigit2, 0, numssmall.width / 10, numssmall.height, sunposx + ((20 + (numssmall.width / 10)) * scale), sunposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
  end
  if bars.gsunshine.start ~= nil then
    buffbg.surface:drawtoscreen(0, 0, buffbg.width, buffbg.height, sunposx - ( 14 * scale), (sunposy - 6) * scale, buffbg.width * scale, buffbg.height * scale)
    gsunicon.surface:drawtoscreen(0, 0, sunicon.width, sunicon.height, sunposx * scale, sunposy, sunicon.width * scale, sunicon.height * scale)

    local timeleft = math.floor((bars.gsunshine.max - (t - bars.gsunshine.start)) / 1000000)
    local sundigit1, sundigit2 = numparse(timeleft, numssmall.width / 10)

    numssmall.surface:drawtoscreen(sundigit1, 0, numssmall.width / 10, numssmall.height, sunposx + (20 * scale), sunposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
    numssmall.surface:drawtoscreen(sundigit2, 0, numssmall.width / 10, numssmall.height, sunposx + ((20 + (numssmall.width / 10)) * scale), sunposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
  end
  if bars.metamorphosis.start ~= nil then
    buffbg.surface:drawtoscreen(0, 0, buffbg.width, buffbg.height, sunposx - ( 14 * scale), (sunposy - 6) * scale, buffbg.width * scale, buffbg.height * scale)
    metaicon.surface:drawtoscreen(0, 0, metaicon.width, metaicon.height, sunposx * scale, sunposy, metaicon.width * scale, metaicon.height * scale)

    local timeleft = math.floor((bars.metamorphosis.max - (t - bars.metamorphosis.start)) / 1000000)
    local metadigit1, metadigit2 = numparse(timeleft, numssmall.width / 10)

    numssmall.surface:drawtoscreen(metadigit1, 0, numssmall.width / 10, numssmall.height, sunposx + (20 * scale), sunposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
    numssmall.surface:drawtoscreen(metadigit2, 0, numssmall.width / 10, numssmall.height, sunposx + ((20 + (numssmall.width / 10)) * scale), sunposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
  end


  if bars.critbuff.start ~= nil then
    buffbg.surface:drawtoscreen(0, 0, buffbg.width, buffbg.height, tsuposx - ( 14 * scale), (tsuposy - 6) * scale, buffbg.width * scale, buffbg.height * scale)
    tsuicon.surface:drawtoscreen(0, 0, tsuicon.width, tsuicon.height, tsuposx * scale, tsuposy, tsuicon.width * scale, tsuicon.height * scale)

    local timeleft = math.floor((bars.critbuff.max - (t - bars.critbuff.start)) / 1000000)
    local tsudigit1, tsudigit2 = numparse(timeleft, numssmall.width / 10)

    numssmall.surface:drawtoscreen(tsudigit1, 0, numssmall.width / 10, numssmall.height, tsuposx + (20 * scale), tsuposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
    numssmall.surface:drawtoscreen(tsudigit2, 0, numssmall.width / 10, numssmall.height, tsuposx + ((20 + (numssmall.width / 10)) * scale), tsuposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
  end

  if bars.instability.start ~= nil then
    buffbg.surface:drawtoscreen(0, 0, buffbg.width, buffbg.height, fsoaposx - ( 14 * scale), (fsoaposy - 6) * scale, buffbg.width * scale, buffbg.height * scale)
    fsoaicon.surface:drawtoscreen(0, 0, fsoaicon.width, fsoaicon.height, fsoaposx * scale, fsoaposy - 4, fsoaicon.width * scale, fsoaicon.height * scale)

    local timeleft = math.floor((bars.instability.max - (t - bars.instability.start)) / 1000000)
    local tsudigit1, tsudigit2 = numparse(timeleft, numssmall.width / 10)

    numssmall.surface:drawtoscreen(tsudigit1, 0, numssmall.width / 10, numssmall.height, fsoaposx + (20 * scale), fsoaposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
    numssmall.surface:drawtoscreen(tsudigit2, 0, numssmall.width / 10, numssmall.height, fsoaposx + ((20 + (numssmall.width / 10)) * scale), fsoaposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
  end



  btimg.surface:drawtoscreen(0, 0, btimg.width, btimg.height, gm - (12 * scale), gv + (8 * scale), btimg.width * scale, btimg.height * scale)
--  btbarbg.surface:drawtoscreen(0, 0, btbarbg.width, btbarbg.height, gm - ((13 + 55) * scale), gv + (18 * scale), btbarbg.width, btbarbg.height * scale)
  if bars.exsanguinate.start ~= nil then
    local btbar = mage['blood-tithe'].btbar
    local elapsed = bars.exsanguinate.max - (buffs.exsanguinate.number * 1000000)
    local width = -barfill(bars.exsanguinate.max, elapsed, 55)
    btbar.surface:drawtoscreen(0, 0, btbar.width, btbar.height, gm - (13 * scale), gv + (15 * scale), width * scale, 6 * scale)
  end

  geimg.surface:drawtoscreen(0, 0, geimg.width, geimg.height, gm + (12 * scale), gv + (8 * scale), geimg.width * scale, geimg.height * scale)
--  gebarbg.surface:drawtoscreen(0, 0, btbarbg.width, btbarbg.height, gm + ((13  + 22)* scale), gv + (18 * scale), gebarbg.width * scale, gebarbg.height * scale)
  if bars.incitefear.start ~= nil then
    local gebar = mage['glacial-embrace'].gebar
    local elapsed = bars.incitefear.max - (buffs.incitefear.number * 1000000)
    local width = math.floor(barfill(bars.incitefear.max, elapsed, 55) * scale)
    gebar.surface:drawtoscreen(0, 0, gebar.width, gebar.height, gm + ((13 + 22) * scale), gv + (15 * scale), width, 6 * scale)
  end



  asimg.surface:drawtoscreen(0, 0, asimg.width, asimg.height, gm - ((110 + 28) * scale), gv - (16 * scale), 32 * scale, 32 * scale)
end