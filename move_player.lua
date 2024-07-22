fget = fget
gravity = 0 --0.4

function check_collision_left(x, y)
	local vx = player.velocity.x
	local vy = player.velocity.y

	local t_u_l = mget(x+vx, y+vy)
	local t_u_r = mget(x+vx+7, y+vy)

	local t_d_l = mget(x+vx, y+7+vy)
	local t_d_r = mget(x+vx+7, y+7+vy)

	local t_d_l = mget(x+vx, y+7+vy)
	local t_d_r = mget(x+vx+7, y+7+vy)

	local t_d_l = mget(x+vx, y+7+vy)
	local t_d_r = mget(x+vx+7, y+7+vy)

	tile_x = flr(x / 8)
	tile_y = flr(y / 8)
	return fget(mget(tile_x, tile_y)) == 1
end

function move_player()
	if key_down(0) then player.velocity.x = -h_increase end -- left
	if key_down(1) then player.velocity.x = h_increase end -- right
	if btn(3) then player.position.y = player.position.y + 1 end
	if btn(2) then player.position.y = player.position.y - 1 end
	if key_up(0) then
		if not btn(1) then
			player.velocity.x = 0
		else
			player.velocity.x = h_increase
		end
	end
	if key_up(1) then
		if not btn(0) then
			player.velocity.x = 0
		else
			player.velocity.x = -h_increase
		end
	end
	if key_down(5) then
		player.velocity.y = -4
	end

	if player.position.y < 120 then
		if player.velocity.y < 3 then
			player.velocity.y = player.velocity.y + gravity
		end
	elseif player.position.y > 120 then
		player.velocity.y = 0
		player.position.y = 120
	end

	collision = check_collision_left(player.position.x, player.position.y)

	player.position.x = player.position.x + player.velocity.x  -- * delta_time
	player.position.y = player.position.y + player.velocity.y -- * delta_time
end
