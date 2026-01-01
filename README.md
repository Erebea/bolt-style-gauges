# bolt-style-gauges
FFXIV Inspired Combat Style Gauges for RS3, made specifically for Bolt: https://codeberg.com/Adamcake/Bolt

Also Inspired by the alt1 plugin: https://github.com/NadyaNayme/job-gauges


Previews:

![This is Necromancy](/assets/preview-necromancy.png)
![This is Magic](/assets/preview-magic.png)
![This is Ranged](/assets/preview-ranged.png)
![This is Melee](/assets/preview-melee.png)

# How what

## Installation
Go to your plugins on the bolt launcher and click "Install plugin from updater url", paste https://raw.githubusercontent.com/Erebea/bolt-style-gauges/refs/heads/master/meta.json, and enter

## Configuration
Inside the main.lua file there are a few configurable variables. These are:

`scale` - Interface scaling value. Every (hopefully) element is sized and positioned in a way that scales with this number, make it higher to scale the entire gauge (useful for 4K res players)

`gx` - X position of the gauge, number of pixels from the left

`gy` - Y position of the gauge, Number of pixels from the top

Within each gauge script there are a few more position variables to configure a gauge to your liking, these were a later addition so not every element has easily configurable position variables. These will be suffixed by `posx` and `posy`

In addition, in the ranged gauge script there is an "experimental" bolg cheatsheet that displays key abilities and the bolg stacks you will end on after fully using them, along with indicators for how many times the perfect equilibrium shot will go off. This is currently written for the beta, so deadshot is calculated as giving 5 stacks.

# Guide

## Necromancy Gauge

![Necromancy guide](/assets/guide-necromancy.png)

The script includes a check for bloat that will reset the timer if particles corresponding to using the bloat ability are used. This should exclude other players, but if it doesn't please let me know...

## Magic Gauge

![Magic guide](/assets/guide-magic.png)

## Ranged Gauge

![Ranged guide](/assets/guide-ranged.png)

Currently equipped ammo to be added

## Melee Gauge

![Made you read this](/assets/guide-melee.png)


# todo

- omni guard and devourer's guard timers

- Better icons

- Different styles, maybe 

- Overload indicator cause why not