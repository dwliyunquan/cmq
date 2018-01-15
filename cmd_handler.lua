local cmq_service = require "cmq.service";

local action = ngx.var.arg_Action

if not action then 
   ngx.say("action is null ")
   return
end 

if action == "SendMessage" then 

   local msgBody=ngx.var.arg_msgBody
   if not msgBody then
      ngx.say("msgBody is null ")
      return
   end 

   cmq_service.SendMessage(msgBody)
   return
end

if action == "ReceiveMessage" then 
   cmq_service.ReceiveMessage()
   return
end 

if action == "DeleteMessage" then

   local receiptHandle=ngx.var.arg_receiptHandle
   if not receiptHandle then
      ngx.say("receiptHandle is null ")
      return
   end 

   cmq_service.DeleteMessage(receiptHandle)
   return
end 

if action == "BatchSendMessage" then

   local msgBody=ngx.var.arg_msgBody
   if not msgBody then
      ngx.say("msgBody is null ")
      return
   end 
   
   local tbl_msgBody=ngx.req.get_uri_args()["msgBody"]
   cmq_service.BatchSendMessage(tbl_msgBody)
   return
end 

if action == "BatchDeleteMessage" then

   local receiptHandle=ngx.var.arg_receiptHandle
   if not receiptHandle then
      ngx.say("receiptHandle is null ")
      return
   end 
   
   local tbl_receiptHandle=ngx.req.get_uri_args()["receiptHandle"]
   cmq_service.BatchDeleteMessage(tbl_receiptHandle)
   return
end 

ngx.say("action is not a function")