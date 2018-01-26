local vmf = get_mod("VMF")

-- ####################################################################################################################
-- ##### Hooks Functions ##############################################################################################
-- ####################################################################################################################

-- HOOK: [ChatManager.register_channel]
local hook_send_unsent_messages = function (func, self, channel_id, members_func)

  func(self, channel_id, members_func)

  if channel_id == 1 then
    for _, message in ipairs(vmf.unsended_chat_messages) do
      self:add_local_system_message(1, message, true)
    end
  end
end

-- ####################################################################################################################
-- ##### Event functions ##############################################################################################
-- ####################################################################################################################

-- at the moment of loading VMF Chat Manager is not initialized yet,
-- so it should be hooked with some delay
vmf.hook_chat_manager = function()

  if not vmf.is_chat_manager_hooked then
    vmf.is_chat_manager_hooked = true

    vmf:hook("ChatManager.register_channel", hook_send_unsent_messages)
  end
end