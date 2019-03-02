local ufo = { 
	base = {veh = 'hydra', fakeveh = 'p_spinning_anus_s'},
	vehPR = {x = 0.0, y = 0.0, z = -0.6, xrot = 0.0, yrot = 0.0, zrot = 180.0},
}

local buttons = {
	{"Leave the vehicle", 23},
	{"Toggle stationary mode", 51},
	{"Toggle wheels", 113}
}

RegisterCommand('ufo', function(source, args)
    StartActivity(ufo)
end)

local function InstructionnalButtons(buttons)

	local scaleform = RequestScaleformMovie('instructional_buttons')
	while not HasScaleformMovieLoaded(scaleform) do Wait(10) end

	PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

	for k,v in ipairs(buttons) do
		PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	    PushScaleformMovieFunctionParameterInt(k)
	    PushScaleformMovieFunctionParameterString(GetControlInstructionalButton(2, v[2], true))
	    PushScaleformMovieMethodParameterString(v[1])
	    PopScaleformMovieFunctionVoid()
	end

	PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()

    return scaleform
end

function StartActivity(v)
	local cam = CreateCam('DEFAULT_SCRIPTED_CAMERA')
	local buttonsToDraw = InstructionnalButtons(buttons)

	Citizen.CreateThread(function()
		local playerPed = PlayerPedId()

		-- Creation of the real vehicle
		local hash = GetHashKey(v.base.veh)
		RequestModel(hash)
		while not HasModelLoaded(hash) do Citizen.Wait(10) end

		local veh = CreateVehicle(hash, GetEntityCoords(playerPed, false), GetEntityHeading(playerPed), true, true)
		SetEntityInvincible(veh, true)

		-- Creation of the fake vehicle
		local model = GetHashKey(v.base.fakeveh)
		RequestModel(model)
		while not HasModelLoaded(model) do Citizen.Wait(10) end

		local fakeveh = CreateObject(model, GetEntityCoords(playerPed, false), true, true, true)
		AttachEntityToEntity(fakeveh, veh, 0, v.vehPR.x, v.vehPR.y, v.vehPR.z,  v.vehPR.xrot, v.vehPR.yrot, v.vehPR.zrot, false, false, false, false, 2, true)
		SetPedIntoVehicle(playerPed, veh, -1)
		
		-- When in the vehicle
		while GetVehiclePedIsIn(playerPed) == veh do
			Wait(0)

			DrawScaleformMovieFullscreen(buttonsToDraw, 255, 255, 255, 255, 0)

			local coordsCam = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, -100.0, 10.0)
			local coordsPly = GetEntityCoords(PlayerPedId())
			SetCamCoord(cam, coordsCam)
			PointCamAtCoord(cam, coordsPly)

			SetCamActive(cam, true)
			RenderScriptCams(true, true, 500, true, true)
		end

		RenderScriptCams(false, true, 500, true, true)

		DeleteVehicle(veh)
		DeleteObject(fakeveh)
	end)
end