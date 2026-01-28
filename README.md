# bolt-style-gauges
FFXIV Inspired Combat Style Gauges for RS3, made specifically for Bolt: https://codeberg.com/Adamcake/Bolt

Also Inspired by the alt1 plugin: https://github.com/NadyaNayme/job-gauges

Currently the gauges are toggled on/off based on which level 70, 95, or 99 statboosting prayer or damage boosting ultimate you have activated. Or conjuring skeleton for necromancy.

**Also note: A mostly unintended update of indicators for low prayer points as well as low overload, summoning, poison, and aura timers has been pushed**

Previews:

![This is Necromancy](/assets/preview-necromancy.png)
![This is Magic](/assets/preview-magic.png)
![This is Ranged](/assets/preview-ranged.png)
![This is Melee](/assets/preview-melee.png)

# How what

## Installation
Go to your plugins on the bolt launcher and click "Install plugin from updater url", paste https://raw.githubusercontent.com/Erebea/bolt-style-gauges/refs/heads/master/meta.json, and enter

## Configuration

The position of the gauges can be changed by holding shift+alt and then clicking and dragging the gauge

Inside the main.lua file there are a few configurable variables.

`scale` - Interface scaling value. Every (hopefully) element is sized and positioned in a way that scales with this number, make it higher to scale the entire gauge (useful for 4K res players)

Within each gauge script there are a few more position variables to configure a gauge to your liking, these were a later addition so not every element has easily configurable position variables. These will be suffixed by `posx` and `posy`

# Guide

## Necromancy Gauge

![Necromancy guide](/assets/guide-necromancy.png)

The script includes a check for bloat that will reset the timer if you reuse the bloat ability. This works by checking for a particular model that seems to be part of the animation. If this is behaving weirdly or badly please let me know.

## Magic Gauge

![Magic guide](/assets/guide-magic.png)

When using temporal anomaly, the indicator for it flashes when it procs (but also does so when the roar of awakening DoT reset passive procs.)
## Ranged Gauge

![Ranged guide](/assets/guide-ranged.png)

Currently equipped ammo to be added. Also includes an "experimental" bolg cheatsheet that displays key abilities and the bolg stacks you will end on after fully using them, along with indicators for how many times the perfect equilibrium shot will go off. This is currently written for the beta, so deadshot is calculated as giving 5 stacks. You will have to either move them or the temp buff timers since they would overlap.

## Melee Gauge

![Made you read this](/assets/guide-melee.png)


# todo

- omni guard and devourer's guard timers

- Better icons

- Different styles, maybe 

- Overload indicator cause why not
