if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
/*--------------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
-- Based off of the GMod lasertracer
EFFECT.MainMat = Material("vj_hl/beam")

function EFFECT:Init(data)
	self.StartPos = data:GetStart()
	self.EndPos = data:GetOrigin()
	self.Ent = data:GetEntity()
	self.Att = data:GetAttachment()
	if IsValid(self.Ent) then self.StartPos = self.Ent:GetAttachment(self.Att).Pos end
	
	self.HitPos = self.EndPos - self.StartPos
	self.DieTime = CurTime() + 0.2
	self:SetRenderBoundsWS(self.StartPos, self.EndPos)
	
	util.Decal("VJ_HLR_Scorch_Small", self.EndPos + self.HitPos:GetNormalized(), self.EndPos - self.HitPos:GetNormalized())
	local effectdata = EffectData()
	effectdata:SetOrigin(self.EndPos + self.HitPos:GetNormalized()*-2)
	effectdata:SetNormal(self.HitPos:GetNormalized()*-3)
	effectdata:SetMagnitude(0.1)
	effectdata:SetScale(1)
	effectdata:SetRadius(3)
	util.Effect("Sparks", effectdata)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function EFFECT:Think()
	if !IsValid(self.Ent) then return false end
	self.StartPos = self.Ent:GetAttachment(self.Att).Pos
	if (CurTime() > self.DieTime) then -- If it's dead then...
		return false
	end
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function EFFECT:Render()
	render.SetMaterial(self.MainMat)
	render.DrawBeam(self.StartPos, self.EndPos, math.Rand(200,200), math.Rand(0,1), ((self.StartPos - self.EndPos):Length() / 20000), Color(100,100,255,255))
	--render.DrawBeam(self.StartPos, self.EndPos, math.Rand(100,150), math.Rand(0,1.3) + ((self.StartPos - self.EndPos):Length() / 1280), ((self.StartPos - self.EndPos):Length() / 20000), Color(100,100,255,255))
end
/*--------------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/