# bolt-style-gauges
FFXIV Inspired Combat Style Gauges for RS3, made specifically for Bolt: https://github.com/Adamcake/Bolt

Also Inspired by the alt1 plugin: https://github.com/NadyaNayme/job-gauges

Very WIP and messy, most code I've written in years

Previews:

![This is Necromancy](/assets/preview-necromancy.png)
![This is Magic](/assets/preview-magic.png)

# How what
Inside the main.lua file there are a few configurable variables. These are:

`scale` - Interface scaling value. Every (hopefully) element is sized and positioned in a way that scales with this number, make it higher to scale the entire gauge (useful for 4K res players)

`intstyle` - Interface style. Options are `modern` and `legacy` (legacy assets have not yet been made, currently would only change the background element that everything else is drawn around)

`gx` - X position of the gauge, number of pixels from the left

`gy` - Y position of the gauge, Number of pixels from the top

# todo
Better icons and different styles (more complex style, extremely simplified style, etc)

Temporal Anomaly procs, playing a sound and hilighting the ability - currently brightens the temporal anomaly icon but nothing else, and roar of awakening resets trigger it as well since they spawn the same 3d animation

Cooldown tracking that looks nice

FSOA tracking

95/99 prayer indicator as a treat

overload indicator cause why not

Ranged gauge, I don't use ranged lmao
