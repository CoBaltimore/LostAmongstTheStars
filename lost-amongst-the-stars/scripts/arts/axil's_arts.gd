extends artsList

@export var playerStats: stats

func artZ(target: stats):
	# Pack arm slam - topples if break is inflicted on target
	var land: bool
	land = target.damage(playerStats, 3)
	if target.broken:
		target.topple()

func artX(target: stats):
	# Destabilizer - shoot a laser that inflicts paralysis
	var land: bool
	land = target.damage(playerStats, 2.5)
	if land:
		target.paralysis()

func artC(target: stats):
	# Drone barrier - DEF buff for 1 party member
	target.DEFUp()

func artV(target: stats):
	# Hefty Punch - More damage from the front
	target.damage(playerStats, 6)

func artB(target: stats):
	# Energy Leech - charges talent art gague 2x as much on hit. not powerful
	var land: bool
	land = target.damage(playerStats, 1.5)
	if land:
		pass

func artN():
	# Overclocked - Aura that grants haste
	playerStats.Haste()

func talentArt(target: stats):
	pass
