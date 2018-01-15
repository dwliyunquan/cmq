local utils = require "cmq.utils";
local conf = require "cmq.conf";

local config=conf.init_conf()
local secretId=config.SecretId
local secretKey=config.SecretKey
local requestUrl=config.RequestUrl

local _M = {}


function _M.SendMessage(msgBody)

   local time_stamp=os.time()
   local tbl_para={"msgBody="..msgBody, "Action=SendMessage", "queueName=liyunquan-test","Region=gz","Timestamp="..time_stamp,"Nonce="..time_stamp,"SecretId="..secretId}

   local para_url=utils.Sort_Para(tbl_para)

   local digest_url="GET"..requestUrl.."?"..para_url;
   local digest = ngx.hmac_sha1(secretKey, digest_url)
   local base64_str=ngx.encode_base64(digest)
   local url_encode_str=utils.Url_Encode(base64_str)

   local send_message_url="http://"..requestUrl.."?"..para_url.."&Signature="..url_encode_str
   local resp = utils.Http_Get(send_message_url)

   if not resp then
      ngx.say("failed to sendMessage ")
      return
   end

   ngx.say(resp)
end

function _M.ReceiveMessage()

   local time_stamp=os.time()
   local tbl_para={"Action=ReceiveMessage", "queueName=liyunquan-test","Region=gz","Timestamp="..time_stamp,"Nonce="..time_stamp,"SecretId="..secretId}

   local para_url=utils.Sort_Para(tbl_para)

   local digest_url="GET"..requestUrl.."?"..para_url;
   local digest = ngx.hmac_sha1(secretKey, digest_url)
   local base64_str=ngx.encode_base64(digest)
   local url_encode_str=utils.Url_Encode(base64_str)

   local receive_message_url="http://"..requestUrl.."?"..para_url.."&Signature="..url_encode_str
   local resp = utils.Http_Get(receive_message_url)

   if not resp then
      ngx.say("failed to receiveMessage ")
      return
   end

   ngx.say(resp)
end


function _M.DeleteMessage(receiptHandle)

   local time_stamp=os.time()
   local tbl_para={"Action=DeleteMessage", "queueName=liyunquan-test","Region=gz","Timestamp="..time_stamp,"Nonce="..time_stamp,"receiptHandle="..receiptHandle,"SecretId="..secretId}

   local para_url=utils.Sort_Para(tbl_para)

   local digest_url="GET"..requestUrl.."?"..para_url;
   local digest = ngx.hmac_sha1(secretKey, digest_url)
   local base64_str=ngx.encode_base64(digest)
   local url_encode_str=utils.Url_Encode(base64_str)

   local receive_message_url="http://"..requestUrl.."?"..para_url.."&Signature="..url_encode_str
   local resp = utils.Http_Get(receive_message_url)

   if not resp then
      ngx.say("failed to eleteMessage ")
      return
   end

   ngx.say(resp)

end 


function _M.BatchSendMessage(tbl_msgBody)

   local time_stamp=os.time()
   local tbl_para={"Action=BatchSendMessage", "queueName=liyunquan-test","Region=gz","Timestamp="..time_stamp,"Nonce="..time_stamp,"SecretId="..secretId}
 
   local number=1
   for key, value in pairs(tbl_msgBody) do  
       local msgBody="msgBody."..number.."="..value
       table.insert(tbl_para, msgBody)
       number=number+1
   end
   
   local para_url=utils.Sort_Para(tbl_para)

   local digest_url="GET"..requestUrl.."?"..para_url;
   local digest = ngx.hmac_sha1(secretKey, digest_url)
   local base64_str=ngx.encode_base64(digest)
   local url_encode_str=utils.Url_Encode(base64_str)

   local send_message_url="http://"..requestUrl.."?"..para_url.."&Signature="..url_encode_str
   local resp = utils.Http_Get(send_message_url)

   if not resp then
      ngx.say("failed to batchSendMessage ")
      return
   end

   ngx.say(resp)

end 

function _M.BatchDeleteMessage(tbl_receiptHandle)

   local time_stamp=os.time()
   local tbl_para={"Action=BatchDeleteMessage", "queueName=liyunquan-test","Region=gz","Timestamp="..time_stamp,"Nonce="..time_stamp,"SecretId="..secretId}
 
   local number=1
   for key, value in pairs(tbl_receiptHandle) do  
       local receiptHandle="receiptHandle."..number.."="..value
       table.insert(tbl_para, receiptHandle)
       number=number+1
   end
   
   local para_url=utils.Sort_Para(tbl_para)

   local digest_url="GET"..requestUrl.."?"..para_url;
   local digest = ngx.hmac_sha1(secretKey, digest_url)
   local base64_str=ngx.encode_base64(digest)
   local url_encode_str=utils.Url_Encode(base64_str)

   local send_message_url="http://"..requestUrl.."?"..para_url.."&Signature="..url_encode_str
   local resp = utils.Http_Get(send_message_url)

   if not resp then
      ngx.say("failed to batchDeleteMessage ")
      return
   end

   ngx.say(resp)

end 

return _M