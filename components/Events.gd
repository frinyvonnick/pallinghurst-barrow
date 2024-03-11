extends Node

signal actor_attacked(event)
signal health_changed(body: Actor, old_value: float, new_value: float)

# player
signal player_dodging_started()
signal player_dodging_finished()
