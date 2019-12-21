gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)
util.no_globals()

local json = require "json"
local font = resource.load_font "Ubuntu-C.ttf"

local status = {starting = 'no status yet'}

util.data_mapper{
    ["status"] = function(val)
        status = json.decode(val)
    end
}

local function write_status()
    local x, y = 10, 10
    local function write(xx, text, r,g,b,a)
        font:write(x+xx, y, text, 20, r,g,b,a)
        y = y + 20 + 3
    end
    local function write_obj(depth, obj)
        for k, v in pairs(obj) do
            if type(v) == "table" then
                y = y + 3
                write(depth*30, k, 1,1,1,1)
                write_obj(depth+1, v)
                y = y + 3
            else
                write(depth*30, string.format("%s    %s", k, v), 1,0.5,0.5,1)
            end
        end
    end
    write_obj(0, status)
end

function node.render()
    gl.clear(0,0,0,1)
    write_status()
end
