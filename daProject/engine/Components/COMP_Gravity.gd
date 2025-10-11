extends Component_Base

func CompGrav_ReturnGravity(delta: float) -> Vector2:
	return entityParent.get_gravity() * delta
