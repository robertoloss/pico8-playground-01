fget = fget
gravity = 0.2				--0.4
h_increase = 1

function fl(num)
	return flr(num / 8)
end

function check_collision(x, y)
	vx = player.velocity.x
	vy = player.velocity.y

	t_u_l = mget( fl(x+vx), fl(y+vy) )
	t_u_r = mget( fl(x+vx+7), fl(y+vy) )

	t_d_l = mget( fl(x+vx), fl(y+7+vy) )
	t_d_r = mget( fl(x+vx+7), fl(y+7+vy) )

	t_l_u = mget( fl(x+vx), fl(y) )
	t_l_d = mget( fl(x+vx), fl(y+7) )

	t_r_u = mget( fl(x+vx+7), fl(y) )
	t_r_d = mget( fl(x+vx+7), fl(y+7) )

	collision = {
		top = {},
		bottom = {},
		right = {},
		left = {}
	}

	if vx > 0 then
		collision.right.yes = fget(t_r_d, 0) or fget(t_r_u, 0)
		if fget(t_r_d, 0) then
			collision.right.tile = t_r_d
		else
			collision.right.tile = t_r_u
		end
	elseif vx < 0 then
		collision.left.yes = fget(t_l_d, 0) or fget(t_l_u, 0)
		if fget(t_l_d, 0) then
			collision.left.tile = t_l_d
		else
			collision.left.tile = t_l_u
		end
	end
	if vy > 0 then
		collision.bottom.yes = fget(t_d_l, 0) or fget(t_d_r, 0)
		if fget(t_d_l, 0) then
			collision.bottom.tile = t_d_l
		else
			collision.bottom.tile = t_d_r
		end
	elseif vy < 0 then
		collision.top.yes = fget(t_u_r, 0) or fget(t_u_l, 0)
		if fget(t_u_r, 0) then
			collision.top.tile = t_u_r
		else
			collision.top.tile = t_u_l
		end
	end

	if (collision.top.yes or collision.bottom.yes)
		and (not collision.left.yes and not collision.right.yes)
	then
		if collision.top.yes then
			player.position.y = (fl(y+vy)*8) + 8
		end
		if collision.bottom.yes then
			player.position.y = (fl(y+vy+7)*8) - 8
		end
		player.velocity.y = 0
	end
	if collision.right.yes or collision.left.yes then
		player.velocity.x = 0
		if collision.left.yes then
			player.position.x = (fl(x+vx)*8) + 8
		else
			player.position.x = (fl(x+7+vx)*8) - 8
		end
	end
end

function move_player()
	if key_down(0) then player.go_left = true end -- left
	if key_down(1) then player.go_right = true end -- right
	if btn(3) then player.position.y = player.position.y + 1 end
	if btn(2) then player.position.y = player.position.y - 1 end
	if key_up(0) then
		player.go_left = false
		if btn(1) then
			player.go_right = true
		end
	end
	if key_up(1) then
		player.go_right = false
		if btn(0) then
			player.go_left = true
		end
	end
	if key_down(5) then
		player.velocity.y = -3
		player.on_the_ground = false
	end

	if player.go_left then
		player.velocity.x = -h_increase
	elseif player.go_right then
		player.velocity.x = h_increase
	else
		player.velocity.x = 0
	end

	check_collision(player.position.x, player.position.y)

	player.position.x = player.position.x + player.velocity.x  -- * delta_time
	player.position.y = player.position.y + player.velocity.y -- * delta_time

	if player.velocity.y < 3 then
		player.velocity.y = player.velocity.y + gravity
	end
end
