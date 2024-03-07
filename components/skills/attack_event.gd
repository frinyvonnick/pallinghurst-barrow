class_name AttackEvent
extends Node

var damage: float
enum Types {PHYSICAL = 0, LIGHT = 1}
var type: int
var body: PhysicsBody2D

func _init(pDamage, pType, pBody):
	damage = pDamage
	type = pType
	body = pBody

