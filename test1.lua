-- test game
-- by me

cls, btn, spr, time, cocreate, coresume, map, mget, flr =
cls, btn, spr, time, cocreate, coresume, map, mget, flr


function _init()
	make_player()
	make_keymap()
end

function _update60()
	key_checker()
	move_player()
end

function _draw()
	cls() --clear screen
	map()
	draw_player()
end

function make_player()
	player = {
		position = {
			x = 64,
			y = 112,
		},
		velocity = {
			x = 0,
			y = 0,
		},
		sprite = 18
	}
end

--local last_time = 0
--local delta_time = 0

function draw_player()
	spr(player.sprite, player.position.x,player.position.y)
	print(collision.top.yes)
	print(collision.bottom.yes)
	print(collision.left.yes)
	print(collision.right.yes)
	print(player.position.x, 40, 5)
	print(player.position.y, 40, 10)
end


function make_keymap()
	keys = {}
	for i = 0,5 do
		keys[i] = false
	end
	keys_previous = {}
	for i = 0,5 do
		keys_previous[i] = false
	end
end

function key_down(key)
	return keys[key] and not keys_previous[key]
end

function key_up(key)
	return not keys[key] and keys_previous[key]
end

function key_checker()
	for i=0,5 do
		keys_previous[i] = keys[i]
		keys[i] = btn(i)
	end
end




