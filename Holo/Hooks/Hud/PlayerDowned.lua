if Holo.Options:GetValue("Hud") and (not restoration or not (restoration.Options and restoration.Options:GetValue("HUD/MainHud"))) then
	Holo:Post(HUDPlayerDowned, "init", function(self)	
		self:UpdateHolo()
		Holo:AddUpdateFunc(callback(self, self, "UpdateHolo"))
	end)	
	function HUDPlayerDowned:UpdateHolo()
		local timer_msg = self._hud_panel:child("downed_panel"):child("timer_msg")
		timer_msg:configure({
			w = 400,
			font_size = 24,
		})
		self._hud.arrest_finished_text:set_font_size(24)
		self._hud.timer:set_font_size(24)
		
		managers.hud:make_fine_text(timer_msg)
		managers.hud:make_fine_text(self._hud.arrest_finished_text)
		managers.hud:make_fine_text(self._hud.timer)

		timer_msg:set_world_center_x(self._hud_panel:world_center_x())
		self._hud.arrest_finished_text:world_center_x(timer_msg:world_center_x())	
		self._hud.timer:set_world_center_x(self._hud_panel:world_center_x())
		
		timer_msg:set_world_y(managers.hud._hud_heist_timer._heist_timer_panel:world_bottom() + 1)
		self._hud.arrest_finished_text:set_world_y(timer_msg:world_y())
		self._hud.timer:set_y(self._hud.arrest_finished_text:bottom())
	end
	function HUDPlayerDowned:show_timer()
		local downed_panel = self._hud_panel:child("downed_panel")
		local timer_msg = downed_panel:child("timer_msg")
		timer_msg:set_visible(true)
		self._hud.timer:set_visible(true)
		play_value(timer_msg, "alpha", 1)
		play_value(self._hud.timer, "alpha", 1)
	end
	function HUDPlayerDowned:hide_timer()
		local downed_panel = self._hud_panel:child("downed_panel")
		local timer_msg = downed_panel:child("timer_msg")
		play_value(timer_msg, "alpha", 0.65)
		play_value(self._hud.timer, "alpha", 0.65)
	end
	Holo:Post(HUDPlayerDowned, "on_downed", function(self)
		if managers.hud._teammate_panels[managers.hud.PLAYER_PANEL].UpdateHolo then
		 	managers.hud._teammate_panels[managers.hud.PLAYER_PANEL]:set_downed()
		end
	end)
end