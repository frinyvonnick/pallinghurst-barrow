extends Node

signal actor_attacked(event)
signal health_changed(body, old_value, new_value)

# player
signal player_dodging_started()
signal player_dodging_finished()
