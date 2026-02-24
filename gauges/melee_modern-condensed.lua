drawmeleegauge = function ()

  local bars = bars.melee
  updatebarlist(bars, t)

  local ui = images['gauge-ui']['modern-condensed']
  local melee = ui.melee
  local numssmall = melee.digitssmall
  local buffbg = melee.blackbg
  local dotbg = melee.blackbg4

  local berserkicon = melee.berserk.icon
  local meteoricon =  melee.meteorstrike.icon
  local gbargeicon = melee.gbarge.icon

  local lengstacks
  if not buffs.primordialice.active then
    lengstacks = melee.lengs['0']
  else
    num = tostring(buffs.primordialice.number)
    lengstacks = melee.lengs[num]
  end
  local lengbarframe = melee.lengs.barframe
  local lengbarbg = melee.lengs.barbg
  local lengbarfill = melee.lengs.barfill

  local bloodlustimg = melee.bloodlust[((not buffs.bloodlust.active and '0') or buffs.bloodlust.number) .. (buffs.berserk.active and "-b" or "")]

-- easily configure positions of major element groups

  local lengposx =  gm - 105
  local lengposy =  gv - 28

  local bloodlustposx = lengposx + lengstacks.width + 4
  local bloodlustposy = gv - 24

  local berserkposx =  lengposx + 4
  local berserkposy =  gv - 60

  local meteorposx = berserkposx + 65
  local meteorposy = berserkposy

  local gbargeposx = gm - lengstacks.width - 12
  local gbargeposy = bloodlustposy - 1

  local aspectposx = gbargeposx + 1
  local aspectposy = gbargeposy + 24

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

  if buffs.frostblades.active and buffs.frostblades.number then
    lengbarbg.surface:drawtoscreen(0, 0, lengbarbg.width, lengbarbg.height, (lengposx + 5) * scale, (lengposy + lengstacks.height - 5) * scale, lengbarbg.width * scale, lengbarbg.height * scale)

    local elapsed = bars.frostblades.max - (buffs.frostblades.number * 1000000)
    local width = math.floor(barfill(bars.frostblades.max, elapsed, 110) * scale)

    lengbarfill.surface:drawtoscreen(0, 0, width, lengbarfill.height, (lengposx + 7) * scale, (lengposy + lengstacks.height - 5) * scale, width, lengbarfill.height * scale)
    lengbarframe.surface:drawtoscreen(0, 0, lengbarbg.width, lengbarbg.height, (lengposx + 5) * scale, (lengposy + lengstacks.height - 5) * scale, lengbarbg.width * scale, lengbarbg.height * scale)
  end
  lengstacks.surface:drawtoscreen(0, 0, lengstacks.width, lengstacks.height, lengposx * scale, lengposy * scale, lengstacks.width * scale, lengstacks.height * scale)

-- temp buffs

  if buffs.berserk.active then
    buffbg.surface:drawtoscreen(0, 0, buffbg.width, buffbg.height, berserkposx - ( 14 * scale), (berserkposy - 6) * scale, buffbg.width * scale, buffbg.height * scale)
    berserkicon.surface:drawtoscreen(0, 0, berserkicon.width, berserkicon.height, berserkposx * scale, berserkposy, berserkicon.width * scale, berserkicon.height * scale)

    local timeleft = buffs.berserk.number
    local berserkdigit1, berserkdigit2 = numparse(timeleft, numssmall.width / 10)

    numssmall.surface:drawtoscreen(berserkdigit1, 0, numssmall.width / 10, numssmall.height, berserkposx + (20 * scale), berserkposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
    numssmall.surface:drawtoscreen(berserkdigit2, 0, numssmall.width / 10, numssmall.height, berserkposx + ((20 + (numssmall.width / 10)) * scale), berserkposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
  end

  if bars.meteor.start ~= nil then
    buffbg.surface:drawtoscreen(0, 0, buffbg.width, buffbg.height, meteorposx - ( 14 * scale), (meteorposy - 6) * scale, buffbg.width * scale, buffbg.height * scale)
    meteoricon.surface:drawtoscreen(0, 0, meteoricon.width, meteoricon.height, meteorposx * scale, meteorposy, meteoricon.width * scale, meteoricon.height * scale)

    local timeleft = math.floor((bars.meteor.max - (t - bars.meteor.start)) / 1000000)
    local meteordigit1, meteordigit2 = numparse(timeleft, numssmall.width / 10)

    numssmall.surface:drawtoscreen(meteordigit1, 0, numssmall.width / 10, numssmall.height, meteorposx + (20 * scale), meteorposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
    numssmall.surface:drawtoscreen(meteordigit2, 0, numssmall.width / 10, numssmall.height, meteorposx + ((20 + (numssmall.width / 10)) * scale), meteorposy + (6 * scale), (numssmall.width) / 10 * scale, (numssmall.height) * scale)
  end

  if buffs.gbarge.active then
    --dotbg.surface:drawtoscreen(0, 0, dotbg.width, dotbg.height, (gbargeposx - 1) * scale, (gbargeposy - 1) * scale, dotbg.width * scale, dotbg.height * scale)
    gbargeicon.surface:drawtoscreen(0, 0, gbargeicon.width, gbargeicon.height, gbargeposx * scale, gbargeposy, gbargeicon.width * scale, gbargeicon.height * scale)
  end

  bloodlustimg.surface:drawtoscreen(0, 0, bloodlustimg.width, bloodlustimg.height, bloodlustposx * scale, bloodlustposy * scale, bloodlustimg.width * scale, bloodlustimg.height * scale)
end