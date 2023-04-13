local redis = require "resty.redis"
local red = redis:new()

red:set_timeouts(1000, 1000, 1000) -- 1 sec

-- connect via ip address directly
local ok, err = red:connect("10.152.49.29", 6379)
if not ok then
    ngx.say("failed to connect: ", err)
    return
end

local res, err = red:auth("mall@j9y50e56")
if not res then
    ngx.say("failed to authenticate: ", err)
    return
end

ok, err = red:select(0)
if not ok then
    ngx.say("failed to select db: ", err)
    return
end



ok, err = red:set("dog", "an animal")
if not ok then
    ngx.say("failed to set dog: ", err)
    return
end

ngx.say("set result: ", ok)

local res, err = red:get("dog")
if not res then
    ngx.say("failed to get dog: ", err)
    return
end

if res == ngx.null then
    ngx.say("dog not found.")
    return
end

ngx.say("dog: ", res)


-- put it into the connection pool of size 100,
-- with 10 seconds max idle time
local ok, err = red:set_keepalive(10000, 100)
if not ok then
    ngx.say("failed to set keepalive: ", err)
    return
end

-- or just close the connection right away:
-- local ok, err = red:close()
-- if not ok then
--     ngx.say("failed to close: ", err)
--     return
-- end