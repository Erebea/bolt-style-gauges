drawrangedgauge = function ()

  local bars = bars.ranged
  updatebarlist(bars, t)

  local ui = images['gauge-ui']['modern-condensed']
  local ranged = ui.ranged
  local nums = ranged.digits
  local numssmall = ranged.digitssmall
  local numsbg = ranged.blackbg3
  local numsbg2 = ranged.blackbg2
  local buffbg = ranged.blackbg

  local bolgstacks = ranged['perfect-equilibrium'][((not buffs.perfectequilibrium.active and '0') or buffs.perfectequilibrium.number) .. (buffs.balancebyforce.active and "-bbf" or "")]

  local dspimg

  local aspectposx =  gm - 124
  local aspectposy =  gv
  local dnessimg = ui.aspects.darkness[buffs.darkness.active and 'active' or 'inactive']
  local taimg = ui.aspects['temporal-anomaly'][(buffs.temporalanomaly.active and 'active') or (models.temporalanomaly.foundoncheckframe and 'ta-activate')]
  local adimg = ui.aspects['animate-dead'][buffs.animatedead.active and 'active']

  if buffs.temporalanomaly.active then
    taimg.surface:drawtoscreen(0, 0, taimg.width, taimg.height, aspectposx * scale, aspectposy * scale, taimg.width * scale, taimg.height * scale)
  elseif buffs.animatedead.active then
    adimg.surface:drawtoscreen(0, 0, adimg.width, adimg.height, aspectposx * scale, aspectposy * scale, adimg.width * scale, adimg.height * scale)
  elseif buffs.darkness.active then
    dnessimg.surface:drawtoscreen(0, 0, dnessimg.width, dnessimg.height, aspectposx * scale, aspectposy * scale, dnessimg.width * scale, dnessimg.height * scale)
  end

-- deathspores
  if not buffs.spore.parensnumber or not buffs.spore.active then
    dspimg = ranged.deathspore['0']
  else
    local num = tostring(buffs.spore.parensnumber)
    dspimg = ranged.deathspore[num]
  end
  local dspframe = ranged.deathspore.frame
  local dspbg = ranged.deathspore.barbg

  dspbg.surface:drawtoscreen(0, 0, dspbg.width, dspbg.height, gm - (102 * scale), gv - (2 * scale), dspbg.width * scale, dspbg.height * scale)

  dspimg.surface:drawtoscreen(0, 0, dspimg.width, dspimg.height, gm - (102 * scale), gv - (2 * scale), dspimg.width * scale, dspimg.height * scale)

  if buffs.sporecd.active and buffs.sporecd.number then
    local sporebarcd = ranged.deathspore.barfillcd
    local elapsed = buffs.sporecd.number * 1000000
    local width = math.floor(barfill(bars.sporecd.max, elapsed, 100) * scale)
    sporebarcd.surface:drawtoscreen(0, 0, sporebarcd.width, sporebarcd.height, gm - ((102 - sporebarcd.width - 5) * scale), gv - (2 * scale), width, sporebarcd.height * scale)
  end
  
  if bars.spore.start ~= nil then
    local sporebar = ranged.deathspore.barfill
    local elapsed = t - bars.spore.start
    local width = math.floor(barfill(bars.spore.max, elapsed, 100) * scale)
    sporebar.surface:drawtoscreen(0, 0, sporebar.width, sporebar.height, gm - ((102 - sporebar.width - 5) * scale), gv - (2 * scale), width, sporebar.height * scale)
  end

  dspframe.surface:drawtoscreen(0, 0, dspframe.width, dspframe.height, gm - (102 * scale), gv - (2 * scale), dspframe.width * scale, dspframe.height * scale)

-- wen arrows

  local wenicon = ranged.wen.icon
  local wennums = ranged.wen.digits
  local wennumsa = ranged.wen.digitsa
  local wenposx =  gm - 160
  local wenposy =  gv - 26

  numsbg2.surface:drawtoscreen(0, 0, numsbg2.width, numsbg2.height, wenposx * scale, wenposy * scale, numsbg2.width * scale, numsbg2.height * scale)

if not buffs.wenactive.active then
  local wdigit1, wdigit2 = numparse(buffs.wenstack.parensnumber, wennums.width / 10)
  local wenstacknum
  if buffs.wenstack.number == nil then
    wenstacknum = 0
  else
    wenstacknum = buffs.wenstack.parensnumber
  end
  if buffs.wenstack.active and wenstacknum >= 10 then
    wenicon.surface:drawtoscreen(0, 0, wenicon.width, wenicon.height, wenposx + (10 * scale), wenposy + ( 6 * scale), wenicon.width * scale, wenicon.height * scale)
    wennums.surface:drawtoscreen(wdigit1, 0, wennums.width / 10, wennums.height, wenposx + ((8 + wenicon.width) * scale), wenposy + ( wennums.height / 2 * scale), wennums.width / 10  * scale, wennums.height * scale)
    wennums.surface:drawtoscreen(wdigit2, 0, wennums.width / 10, wennums.height, wenposx + ((8 + wenicon.width + (wennums.width / 10)) * scale), wenposy + ( wennums.height / 2 * scale), wennums.width / 10 * scale, wennums.height * scale)
  else
    wenicon.surface:drawtoscreen(0, 0, wenicon.width, wenicon.height, wenposx + (12 * scale), wenposy + ( 6 * scale), wenicon.width * scale, wenicon.height * scale)
    wennums.surface:drawtoscreen(wdigit2, 0, wennums.width / 10, wennums.height, wenposx + ((12 + wenicon.width + 4) * scale), wenposy + ( wennums.height / 2 * scale), wennums.width / 10  * scale, wennums.height * scale)
  end
else
  local wdigit1, wdigit2 = numparse(buffs.wenactive.number, wennums.width / 10)
  wenicon.surface:drawtoscreen(0, 0, wenicon.width, wenicon.height, wenposx + (12 * scale), wenposy + ( 6 * scale), wenicon.width * scale, wenicon.height * scale)
  wennumsa.surface:drawtoscreen(wdigit2, 0, wennums.width / 10, wennums.height, wenposx + ((12 + wenicon.width + 4) * scale), wenposy + ( wennums.height / 2 * scale), wennums.width / 10  * scale, wennums.height * scale)
end

--temp buffs

  local dsicon = ranged['deaths-swiftness'][buffs.deathsswiftness.active and 'icon' or 'iconi']
  local gdsicon = ranged['deaths-swiftness'][buffs.gdeathsswiftness.active and 'gicon' or 'giconi']
  local incenicon = ranged.incen.icon
  local dracoicon = ranged.draco.edraco
  local ssicon = ranged['split-soul'].icon

-- quickly configure positions of the popup buffs
  local dsposx =  gm - 120
  local dsposy =  gv - 56

  local incenposx = dsposx + 70
  local incenposy = dsposy

  local ssposx = incenposx + 70
  local ssposy = incenposy

  local dracoposx = ssposx + 70
  local dracoposy = ssposy


-- ds
  if bars.gdeathsswiftness.start ~= nil then
    buffbg.surface:drawtoscreen(0, 0, buffbg.width, buffbg.height, dsposx - ( 14 * scale), (dsposy - 6) * scale, buffbg.width * scale, buffbg.height * scale)
    gdsicon.surface:drawtoscreen(0, 0, gdsicon.width, gdsicon.height, dsposx * scale, dsposy * scale, gdsicon.width * scale, gdsicon.height * scale)

    local timeleft = math.floor((bars.gdeathsswiftness.max - (t - bars.gdeathsswiftness.start)) / 1000000)
    local gdsdigit1, gdsdigit2 = numparse(timeleft, numssmall.width / 10)

    numssmall.surface:drawtoscreen(gdsdigit1, 0, numssmall.width / 10, numssmall.height, dsposx + (20 * scale), dsposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
    numssmall.surface:drawtoscreen(gdsdigit2, 0, numssmall.width / 10, numssmall.height, dsposx + ((20 + (numssmall.width / 10)) * scale), dsposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
  end
  if bars.deathsswiftness.start ~= nil then
    buffbg.surface:drawtoscreen(0, 0, buffbg.width, buffbg.height, dsposx - ( 14 * scale), (dsposy - 6) * scale, buffbg.width * scale, buffbg.height * scale)
    dsicon.surface:drawtoscreen(0, 0, gdsicon.width, gdsicon.height, dsposx * scale, dsposy * scale, gdsicon.width * scale, gdsicon.height * scale)

    local timeleft = math.floor((bars.deathsswiftness.max - (t - bars.deathsswiftness.start)) / 1000000)
    local dsdigit1, dsdigit2 = numparse(timeleft, numssmall.width / 10)

    numssmall.surface:drawtoscreen(dsdigit1, 0, numssmall.width / 10, numssmall.height, dsposx + (20 * scale), dsposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
    numssmall.surface:drawtoscreen(dsdigit2, 0, numssmall.width / 10, numssmall.height, dsposx + ((20 + (numssmall.width / 10)) * scale), dsposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
  end
-- incen
  if bars.critbuff.start ~= nil then
    buffbg.surface:drawtoscreen(0, 0, buffbg.width, buffbg.height, incenposx - ( 14 * scale), (incenposy - 6) * scale, buffbg.width * scale, buffbg.height * scale)
    incenicon.surface:drawtoscreen(0, 0, gdsicon.width, gdsicon.height, incenposx * scale, incenposy * scale, gdsicon.width * scale, gdsicon.height * scale)

    local timeleft = math.floor((bars.critbuff.max - (t - bars.critbuff.start)) / 1000000)
    local incendigit1, incendigit2 = numparse(timeleft, numssmall.width / 10)

    numssmall.surface:drawtoscreen(incendigit1, 0, numssmall.width / 10, numssmall.height, incenposx + (20 * scale), incenposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
    numssmall.surface:drawtoscreen(incendigit2, 0, numssmall.width / 10, numssmall.height, incenposx + ((20 + (numssmall.width / 10)) * scale), incenposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
  end
-- split soul
  if bars.splitsoul.start ~= nil then
    buffbg.surface:drawtoscreen(0, 0, buffbg.width, buffbg.height, ssposx - ( 14 * scale), (ssposy - 6) * scale, buffbg.width * scale, buffbg.height * scale)
    ssicon.surface:drawtoscreen(0, 0, gdsicon.width, gdsicon.height, ssposx * scale, ssposy, gdsicon.width * scale, gdsicon.height * scale)

    local timeleft = math.floor((bars.splitsoul.max - (t - bars.splitsoul.start)) / 1000000)
    local ssdigit1, ssdigit2 = numparse(timeleft, numssmall.width / 10)

    numssmall.surface:drawtoscreen(ssdigit1, 0, numssmall.width / 10, numssmall.height, ssposx + (20 * scale), ssposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
    numssmall.surface:drawtoscreen(ssdigit2, 0, numssmall.width / 10, numssmall.height, ssposx + ((20 + (numssmall.width / 10)) * scale), ssposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
  end
--[[ draco

  if buffs.draco.active then
    buffbg.surface:drawtoscreen(0, 0, buffbg.width, buffbg.height, dracoposx - ( 14 * scale), (dracoposy - 6) * scale, buffbg.width * scale, buffbg.height * scale)
    dracoicon.surface:drawtoscreen(0, 0, gdsicon.width, gdsicon.height, dracoposx * scale, dracoposy, gdsicon.width * scale, gdsicon.height * scale)

    local dracodigit1, dracodigit2 = numparse(buffs.draco.number, numssmall.width / 10)

    numssmall.surface:drawtoscreen(dracodigit1, 0, numssmall.width / 10, numssmall.height, dracoposx + (20 * scale), dracoposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
    numssmall.surface:drawtoscreen(dracodigit2, 0, numssmall.width / 10, numssmall.height, dracoposx + ((20 + (numssmall.width / 10)) * scale), dracoposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
  end
--]]
-- bolg stacks and related calculations
  bolgstacks.surface:drawtoscreen(0, 0, bolgstacks.width, bolgstacks.height, gm - (105 * scale), gv - (28 * scale), bolgstacks.width * scale, bolgstacks.height * scale)
  local penum
  if not buffs.perfectequilibrium.active then
    penum = 0
  else
    penum = buffs.perfectequilibrium.number
  end

  local nothing, bolgnum = numparse(penum, nums.width / 10)

  if bars.balancebyforce.start ~= nil then
    local bbfbarbg = ranged['perfect-equilibrium'].barbg
    local bbfbar = ranged['perfect-equilibrium'].bar
    local elapsed = t - bars.balancebyforce.start
    local width = math.floor(barfill(bars.balancebyforce.max, elapsed, 84) * scale)
    bbfbarbg.surface:drawtoscreen(0, 0, bbfbarbg.width, bbfbarbg.height, gm - ((105 - bolgstacks.width) * scale), gv - ((32 - bolgstacks.height + (bolgstacks.height /2) ) * scale), bbfbarbg.width * scale, bbfbarbg.height * scale)
    bbfbar.surface:drawtoscreen(0, 0, bbfbar.width, bbfbar.height, gm - ((105 - bolgstacks.width) * scale), gv - ((32 - bolgstacks.height + (bolgstacks.height /2) ) * scale), width * scale, bbfbar.height * scale)
    numsbg.surface:drawtoscreen(0, 0, numsbg.width, numsbg.height, gm - ((105 - bolgstacks.width - bbfbarbg.width - 8 - 1 + (nums.width / 25)) * scale), gv - ((32 - bolgstacks.height + (bolgstacks.height /2) + nums.height - 5) * scale), numsbg.width * scale, numsbg.height * scale)
    nums.surface:drawtoscreen(bolgnum, 0, nums.width / 10, nums.height, gm - ((105 - bolgstacks.width - bbfbarbg.width - 8) * scale), gv - ((38 - bolgstacks.height + (bolgstacks.height /2) ) * scale), (nums.width) / 10 * scale, (nums.height) * scale)
  else
    numsbg.surface:drawtoscreen(0, 0, numsbg.width, numsbg.height, gm - ((105 - bolgstacks.width - 5 - 1 + (nums.width / 25)) * scale), gv - ((32 - bolgstacks.height + (bolgstacks.height /2) + nums.height - 5) * scale), numsbg.width * scale, numsbg.height * scale)
    nums.surface:drawtoscreen(bolgnum, 0, nums.width / 10, nums.height, gm - ((105 - bolgstacks.width - 5) * scale), gv - ((38 - bolgstacks.height + (bolgstacks.height /2) ) * scale), (nums.width) / 10 * scale, (nums.height) * scale)
  end

-- bolg cheatsheet
  --[[
  local pemax
  if buffs.balancebyforce.active then
    pemax = 4
  else
    pemax = 8
  end

  local riconum = (penum + 7)
  local snapnum = (penum + 2)
  local rapidnum = (penum + 8)
  local deadshotnum = (penum + 5)

  local nothing, rico = numparse(riconum % pemax, numssmall.width / 10)
  local nothing, snap =  numparse(snapnum % pemax, numssmall.width / 10)
  local nothing, rapid = numparse(rapidnum % pemax, numssmall.width / 10)
  local nothing, deadshot = numparse(deadshotnum % pemax, numssmall.width / 10)

  local ricoimg = ranged['perfect-equilibrium'][(riconum >= pemax and 'ricochet-p') or "ricochet"]
  local snapimg = ranged['perfect-equilibrium'][(snapnum >= pemax and 'snapshot-p') or "snapshot"]
  local rapidimg = ranged['perfect-equilibrium'][(rapidnum >= pemax and 'rapidfire-p') or "rapidfire"]
  local deadshotimg = ranged['perfect-equilibrium'][(deadshotnum >= pemax and 'deadshot-p') or "deadshot"]

  local ricodot = ranged['perfect-equilibrium']["dot" .. math.floor(riconum / pemax)]
  local snapdot = ranged['perfect-equilibrium']["dot" .. math.floor(snapnum / pemax)]
  local rapiddot = ranged['perfect-equilibrium']["dot" .. math.floor(rapidnum / pemax)]
  local deadshotdot = ranged['perfect-equilibrium']["dot" .. math.floor(deadshotnum / pemax)]

  ricodot.surface:drawtoscreen(0, 0, ricodot.width, ricodot.height, gm + 60 - ((105) * scale), gv - ((22 + bolgstacks.height + 1 + (ricoimg.height / 2)) * scale), ricodot.width * scale, ricodot.height * scale)
  ricoimg.surface:drawtoscreen(0, 0, ricoimg.width, ricoimg.height, gm + 60 - (105 * scale), gv - (22 + bolgstacks.height * scale), ricoimg.width * scale, ricoimg.height * scale)

  snapdot.surface:drawtoscreen(0, 0, ricodot.width, ricodot.height, gm + 60 - ((75) * scale), gv - ((22 + bolgstacks.height + 1 + (ricoimg.height / 2)) * scale), ricodot.width * scale, ricodot.height * scale)
  snapimg.surface:drawtoscreen(0, 0, ricoimg.width, ricoimg.height, gm + 60 - (75 * scale), gv - (22 + bolgstacks.height * scale), ricoimg.width * scale, ricoimg.height * scale)

  rapiddot.surface:drawtoscreen(0, 0, ricodot.width, ricodot.height, gm + 60 - ((45) * scale), gv - ((22 + bolgstacks.height + 1 + (ricoimg.height / 2)) * scale), ricodot.width * scale, ricodot.height * scale)
  rapidimg.surface:drawtoscreen(0, 0, ricoimg.width, ricoimg.height, gm + 60 - (45 * scale), gv - (22 + bolgstacks.height * scale), ricoimg.width * scale, ricoimg.height * scale)

  deadshotdot.surface:drawtoscreen(0, 0, ricodot.width, ricodot.height, gm + 60 - ((15) * scale), gv - ((22 + bolgstacks.height + 1 + (ricoimg.height / 2)) * scale), ricodot.width * scale, ricodot.height * scale)
  deadshotimg.surface:drawtoscreen(0, 0, ricoimg.width, ricoimg.height, gm + 60 - (15 * scale), gv - (22 + bolgstacks.height * scale), ricoimg.width * scale, ricoimg.height * scale)

  numssmall.surface:drawtoscreen(rico, 0, numssmall.width / 10, numssmall.height, gm + 60 - (90 * scale), gv - (28 + bolgstacks.height * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)

  numssmall.surface:drawtoscreen(snap, 0, numssmall.width / 10, numssmall.height, gm + 60 - (60 * scale), gv - (28 + bolgstacks.height * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)

  numssmall.surface:drawtoscreen(rapid, 0, numssmall.width / 10, numssmall.height, gm + 60 - (30 * scale), gv - (28 + bolgstacks.height * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)

  numssmall.surface:drawtoscreen(deadshot, 0, numssmall.width / 10, numssmall.height, gm + (60 * scale), gv - (28 + bolgstacks.height * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
--]]

end