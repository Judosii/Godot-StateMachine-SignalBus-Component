extends Component_Base

func CompGrav_ReturnGravity(delta: float) -> Vector2:
	return entityParent.get_gravity() * delta

func CompGrav_ApplyGravityToParent(delta: float):
	entityParent.velocity.y = entityParent.get_gravity().y * delta
