-- https://github.com/yuz10/lua-resty-rocketmq#new
local cjson = require "cjson"
local producer = require "resty.rocketmq.producer"

local nameservers = { "10.152.49.54:9876" }

local message = "halo world"

local p = producer.new(nameservers, "produce_group")

-- set acl
-- local aclHook = require("resty.rocketmq.acl_rpchook").new("RocketMQ","123456781")
-- p:addRPCHook(aclHook)

-- use tls mode
p:setUseTLS(true)

local res, err = p:send("lua-test-topic", message)
if not res then
    ngx.say("send err:", err)
    return
end
ngx.say("send success")