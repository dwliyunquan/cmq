
local _M = {}

function _M.init_conf()

  local config                = {
    SecretId                  = "1111111",
    SecretKey                 = "2222222",
    Domain                    = "cmq-queue-gz.api.qcloud.com",
    RequestUrl                = "cmq-queue-gz.api.qcloud.com/v2/index.php"
  }

  return config
end

return _M