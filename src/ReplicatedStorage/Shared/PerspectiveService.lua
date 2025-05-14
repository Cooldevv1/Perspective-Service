

--[[                                                              
 _____                        _   _         _____             _         
|  _  |___ ___ ___ ___ ___ ___| |_|_|_ _ ___|   __|___ ___ _ _|_|___ ___ 
|   __| -_|  _|_ -| . | -_|  _|  _| | | | -_|__   | -_|  _| | | |  _| -_|
|__|  |___|_| |___|  _|___|___|_| |_|\_/|___|_____|___|_|  \_/|_|___|___|
            
 
 By Cooldevv (cool1234great)   
 ---------------------------------------
 Created to remake the somewhat impossible suggestion of adding the Perspective property
 to CatWeb, however can be used for any game.
 
 Not affiliated with HumanCat222.

]]



local PerspectiveService = {}


function PerspectiveService.addPerspective(uiContainer, useZ4, meshId)
	assert(typeof(uiContainer) == "Instance" and uiContainer:IsA("GuiObject"),
		"PerspectiveService - addPerspective expects a GUIObject as parent")

	local sourceVP = script:FindFirstChild("Perspective")
	assert(sourceVP and sourceVP:IsA("ViewportFrame"),
		"PerspectiveService - No Perspective object found as a child of the ModuleScript")

	local vpClone = sourceVP:Clone()
	vpClone.Parent = uiContainer
	vpClone.Visible = true
	
	uiContainer.BackgroundTransparency = 1
	
	local perspectiveObject = vpClone:FindFirstChild("PerspectiveObject")
	if perspectiveObject then
		perspectiveObject.Color = uiContainer.BackgroundColor3
	end
	
	if meshId then -- Allows the use for custom meshes instead of a block
		perspectiveObject.MeshId = meshId
	end
	
	if useZ4 then -- Allows the use of plastering an image of z4 on the Mesh
		for _,z4 in pairs(script["z4-Textures"]:GetChildren()) do
			z4.Parent = perspectiveObject
		end
	end

	return vpClone
end



function PerspectiveService.setPerspectiveOrientation(uiContainer, orientation)
	assert(typeof(uiContainer) == "Instance" and uiContainer:IsA("GuiObject"),
		"PerspectiveService - setPerspectiveOrientation expects a GUIObject as parent of the PerspectiveFrame")

	local vpFrame = uiContainer:FindFirstChild("Perspective")
	assert(vpFrame and vpFrame:IsA("ViewportFrame"),
		"PerspectiveService - No Perspective ViewportFrame found under the given parent")

	local perspectiveObject = vpFrame:FindFirstChild("PerspectiveObject")
	if perspectiveObject then
		perspectiveObject.Orientation = orientation
	end
end



function PerspectiveService.ReloadColors()
	local Players = game:GetService("Players")
	local player = Players.LocalPlayer
	if not player then return end

	local playerGui = player:FindFirstChild("PlayerGui")
	if not playerGui then return end

	for _, gui in ipairs(playerGui:GetDescendants()) do
		if gui:IsA("ViewportFrame") then
			local perspectiveObject = gui:FindFirstChild("PerspectiveObject")
			if perspectiveObject and gui.Parent and gui.Parent:IsA("GuiObject") then
				perspectiveObject.Color = gui.Parent.BackgroundColor3
			end
		end
	end
end

function PerspectiveService.removePerspective(uiContainer)
	uiContainer:WaitForChild("PerspectiveObject"):Destroy()
end

print("💎 Loaded PerspectiveService")
return PerspectiveService