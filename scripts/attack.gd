extends Area2D

# Connect BOTH of these signals in the Node tab!
func _on_body_entered(body: Node2D) -> void:
	print("SWORD: Touched a body: ", body.name)
	if body.has_method("die"):
		body.die()

func _on_area_entered(area: Area2D) -> void:
	print("SWORD: Touched an Area2D: ", area.name)
	var enemy = area.get_parent()
	if enemy.has_method("die"):
		print("SWORD: Found die() function on ", enemy.name)
		enemy.die()
	else:
		print("SWORD: Touched an area, but its parent doesn't have die()")
