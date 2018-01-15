local http = require "http"
local httpc = http.new()

local _M = {}

function _M.Http_Get(request_url)

    local resp, resp_err = httpc:request_uri(request_url, 
    {
      method = "GET",
      headers = {["Content-Type"] = "application/json"}
    })

    if not resp then
       ngx.say("failed to request: ", resp_err)
       return
    end

    return resp.body

end


function _M.Url_Encode(s)  
    s = string.gsub(s, "([^%w%.%- ])", function(c) return string.format("%%%02X", string.byte(c)) end)  
    return string.gsub(s, " ", "+")  
end  
  
function _M.Url_Decode(s)  
    s = string.gsub(s, '%%(%x%x)', function(h) return string.char(tonumber(h, 16)) end)  
    return s  
end 


function _M.Sort_Para(tbl_para)

    table.sort(tbl_para)
    local para_url=""
    for key, value in pairs(tbl_para) do  

        if para_url == "" then 
           para_url = value;
        else 
           para_url = para_url.."&"..value;
        end  
    end 
    return para_url

end

return _M