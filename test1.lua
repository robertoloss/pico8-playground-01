-- test game
-- by me
cls, btn, spr = cls, btn, spr

function _init()
	make_player()
	make_keymap()
end

function _update()
	key_checker()
	move_player()
end

function _draw()
	cls() --clear screen
	draw_player()
end

function make_player()
	player = {
		position = {
			x = 64,
			y = 64,
		},
		velocity = {
			x = 0,
			y = 0,
		},
		sprite = 18
	}
end

function move_player()
	if key_down(0) then player.velocity.x = -1 end -- left
	if key_down(1) then player.velocity.x = 1 end -- right
	if key_up(0) and not btn(1) then player.velocity.x = 0 end
	if key_up(1) and not btn(0) then player.velocity.x = 0 end

	player.position.x = player.position.x + player.velocity.x
	player.position.y = player.position.y + player.velocity.y
end

function draw_player()
	print(key_down(0))
	print_table(keys_previous, 10, 10)
	print_table(keys, 60, 10)
	spr(player.sprite, player.position.x,player.position.y)
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

function print_table(tbl, x, y)
    local line = 0
    for key, value in pairs(tbl) do
        print(key .. ": " .. tostring(value), x, y + line * 8)
        line = line + 1
    end
end


