drawgeneralgauge = function ()
  local bars = images['gauge-ui'].misc.bars
  local bg = bars.barbg
  local bga = bars.barbgadjusted
  local frame = bars.barframe
  local hpframe = bars.hpframe
  local hp = bars.hp
  local adframe = bars.adrenalineframe
  local ad = bars.adrenaline
  local pray = bars.prayer
  local summ = bars.summoning

  local hpposx = math.floor(gamewidth * 0.375)
  local hpposy = math.floor(gameheight * 0.62)
  local adposx = hpposx + bg.width + 25
  local adposy = hpposy
  local prayposx = hpposx
  local prayposy = adposy + bg.height
  local summposx = hpposx
  local summposy = prayposy + bg.height

  bga.surface:drawtoscreen(0, 0, bga.width, bga.height, hpposx, hpposy, bga.width * scale, bga.height * scale)
  local width = math.max(0, math.min(216, 216 * stats.health.fraction))
  hp.surface:drawtoscreen(0, 0, width, hp.height, hpposx + 28, hpposy, width, hp.height * scale)
  hpframe.surface:drawtoscreen(0, 0, hpframe.width, hpframe.height, hpposx, hpposy, hpframe.width * scale, hpframe.height * scale)

  bga.surface:drawtoscreen(0, 0, bga.width, bga.height, adposx, adposy, bga.width * scale, bga.height * scale)
  local width = math.max(0, math.min(216, 216 * stats.adrenaline.fraction))
  ad.surface:drawtoscreen(0, 0, width, ad.height, adposx + 28, adposy, width, ad.height * scale)
  adframe.surface:drawtoscreen(0, 0, hpframe.width, hpframe.height, adposx, adposy, hpframe.width * scale, hpframe.height * scale)
--[[
  bg.surface:drawtoscreen(0, 0, bg.width, bg.height, prayposx, prayposy, bg.width * scale, bg.height * scale)
  local width = math.max(0, math.min(216, 216 * stats.prayer.fraction))
  pray.surface:drawtoscreen(0, 0, width, pray.height, prayposx + 3, prayposy, width, pray.height * scale)
  frame.surface:drawtoscreen(0, 0, frame.width, frame.height, prayposx, prayposy, frame.width * scale, frame.height * scale)

  bg.surface:drawtoscreen(0, 0, bg.width, bg.height, summposx, summposy, bg.width * scale, bg.height * scale)
  local width = math.max(0, math.min(216, 216 * stats.summoning.fraction))
  summ.surface:drawtoscreen(0, 0, width, summ.height, summposx + 3, summposy, width, summ.height * scale)
  frame.surface:drawtoscreen(0, 0, frame.width, frame.height, summposx, summposy, frame.width * scale, frame.height * scale)
]]--
end