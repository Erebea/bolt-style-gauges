drawgauge = function ()
  lineprogram:setuniform4f(2, 150/255, 255/255, 97/255, 1) -- line colour (rgba, 0.0 - 1.0)

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

  if buffs.sporecd.active then
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
  local wdigit1, wdigit2 = numparse(buffs.wenstack.parensnumber, wennums.width / 10)

  numsbg2.surface:drawtoscreen(0, 0, numsbg2.width, numsbg2.height, gm - (124 * scale), gv - ((44 + (wennums.height / 2)) * scale), numsbg.width * 2 * scale, numsbg.height * 0.75 * scale)

  if buffs.wenstack.active and buffs.wenstack.parensnumber >= 10 then
    wennums.surface:drawtoscreen(wdigit1, 0, wennums.width / 10, wennums.height, gm - ((108 - 14) * scale), gv - (45 * scale), (wennums.width) / 10 * scale, (wennums.height) * scale)
    wennums.surface:drawtoscreen(wdigit2, 0, wennums.width / 10, wennums.height, gm - (((108 - 14) - (wennums.width / 10)) * scale), gv - (45 * scale), (wennums.width) / 10 * scale, (wennums.height) * scale)
  else
    wennums.surface:drawtoscreen(wdigit2, 0, wennums.width / 10, wennums.height, gm - (((108 - 14) - (wennums.width / 10 / 2)) * scale), gv - (45 * scale), (wennums.width) / 10 * scale, (wennums.height) * scale)
  end
  wenicon.surface:drawtoscreen(0, 0, wenicon.width, wenicon.height, gm - (108 * scale), gv - (45 * scale), wenicon.width * scale, wenicon.height * scale)

--temp buffs

  local dsicon = ranged['deaths-swiftness'].icon
  local dsdigit1, dsdigit2 = numparse(buffs.deathsswiftness.number, numssmall.width / 10)
  local gdsicon = ranged['deaths-swiftness'].gicon
  local gdsdigit1, gdsdigit2 = numparse(buffs.gdeathsswiftness.number, numssmall.width / 10)

  local incenicon = ranged.incen.icon
  local incendigit1, incendigit2 = numparse(buffs.critbuff.number, numssmall.width / 10)

  local dracoicon = ranged.draco.edraco
  local dracodigit1, dracodigit2 = numparse(buffs.draco.number, numssmall.width / 10)

  local ssicon = ranged['split-soul'].icon
  local ssdigit1, ssdigit2 = numparse(buffs.splitsoul.number, numssmall.width / 10)

-- quickly configure positions of the popup buffs
  local dsposx =  gm - 220
  local dsposy =  (gv - (96 + (nums.height / 2))) + 105

  local incenposx = dsposx
  local incenposy = dsposy - 35

  local ssposx = incenposx
  local ssposy = incenposy - 35

  local dracoposx = ssposx
  local dracoposy = ssposy - 35


-- ds
  if buffs.gdeathsswiftness.active then
    buffbg.surface:drawtoscreen(0, 0, buffbg.width, buffbg.height, dsposx - ( 4 * scale), (dsposy - 6) * scale, buffbg.width * scale, buffbg.height * scale)
    gdsicon.surface:drawtoscreen(0, 0, gdsicon.width, gdsicon.height, dsposx * scale, dsposy * scale, gdsicon.width * scale, gdsicon.height * scale)
    numssmall.surface:drawtoscreen(gdsdigit1, 0, numssmall.width / 10, numssmall.height, dsposx + (20 * scale), dsposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
    numssmall.surface:drawtoscreen(gdsdigit2, 0, numssmall.width / 10, numssmall.height, dsposx + ((20 + (numssmall.width / 10)) * scale), dsposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
  end
-- incen
  if buffs.critbuff.active then
    buffbg.surface:drawtoscreen(0, 0, buffbg.width, buffbg.height, incenposx - ( 4 * scale), (incenposy - 6) * scale, buffbg.width * scale, buffbg.height * scale)
    incenicon.surface:drawtoscreen(0, 0, gdsicon.width, gdsicon.height, incenposx * scale, incenposy * scale, gdsicon.width * scale, gdsicon.height * scale)
    numssmall.surface:drawtoscreen(incendigit1, 0, numssmall.width / 10, numssmall.height, incenposx + (20 * scale), incenposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
    numssmall.surface:drawtoscreen(incendigit2, 0, numssmall.width / 10, numssmall.height, incenposx + ((20 + (numssmall.width / 10)) * scale), incenposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
  end
-- split soul
  if buffs.splitsoul.active then
    buffbg.surface:drawtoscreen(0, 0, buffbg.width, buffbg.height, ssposx - ( 4 * scale), (ssposy - 6) * scale, buffbg.width * scale, buffbg.height * scale)
    ssicon.surface:drawtoscreen(0, 0, gdsicon.width, gdsicon.height, ssposx * scale, ssposy, gdsicon.width * scale, gdsicon.height * scale)
    numssmall.surface:drawtoscreen(ssdigit1, 0, numssmall.width / 10, numssmall.height, ssposx + (20 * scale), ssposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
    numssmall.surface:drawtoscreen(ssdigit2, 0, numssmall.width / 10, numssmall.height, ssposx + ((20 + (numssmall.width / 10)) * scale), ssposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
  end
-- draco
  if buffs.draco.active then
    buffbg.surface:drawtoscreen(0, 0, buffbg.width, buffbg.height, dracoposx - ( 4 * scale), (dracoposy - 6) * scale, buffbg.width * scale, buffbg.height * scale)
    dracoicon.surface:drawtoscreen(0, 0, gdsicon.width, gdsicon.height, dracoposx * scale, dracoposy, gdsicon.width * scale, gdsicon.height * scale)
    numssmall.surface:drawtoscreen(dracodigit1, 0, numssmall.width / 10, numssmall.height, dracoposx + (20 * scale), dracoposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
    numssmall.surface:drawtoscreen(dracodigit2, 0, numssmall.width / 10, numssmall.height, dracoposx + ((20 + (numssmall.width / 10)) * scale), dracoposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
  end

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


end