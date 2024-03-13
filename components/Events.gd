extends Node

# combat
signal actor_attacked(event)
signal health_changed(body: Actor, old_value: float, new_value: float)

# player
signal player_dodging_started()
signal player_dodging_finished()
signal player_trigger_entered()
signal player_weapon_changed(weapon: String)
signal player_cooldown_progressed(type: String, old_value: float, new_value: float, max_value: float)

# boss
signal boss_killed()
