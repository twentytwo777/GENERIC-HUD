------------------------------------------------------------------------------------------------------------------------------------------------------------------
/// MAKE HUD AUTHOR - TWENTY TWO
/// COMMUNICATION - DISCORD
/// DISCORD - twenty two#7777
/// YOU CAN LEAVE +REP ON MY STEAM PROFILE - https://steamcommunity.com/id/twentytwo777/
/// I`LL BE GRATEFUL
/// THANKS FOR DOWNLOAD MY HUD
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- СКРЫТИЕ СТАНДАРТНОГО ХУДА GMOD [НАЧАЛО]
hook.Add( "HUDShouldDraw", "hidehud", function( hudhide )
    if ( hudhide == "CHudHealth" or hudhide == "CHudBattery" or hudhide == "CHudAmmo" or hudhide == "CHudSecondaryAmmo" ) then
    return false
    end
end )
-- СКРЫТИЕ СТАНДАРТНОГО ХУДА GMOD [КОНЕЦ]

-- ЛОКАЛКИ ДЛЯ УПРОЩЕНИЯ ЖИЗНИ КОГДА ПЕРЕДВИГАЕШЬ ЧТО - ТО [НАЧАЛО]
local x = 15
local y = ScrH() - 150

local x_ammo = ScrW() - -70
local y_ammo = ScrH() - 110
-- ЛОКАЛКИ ДЛЯ УПРОЩЕНИЯ ЖИЗНИ КОГДА ПЕРЕДВИГАЕШЬ ЧТО - ТО [КОНЕЦ]

-- ШРИФТ ДЛЯ ХУДА [НАЧАЛО]
surface.CreateFont('fontforhud', {
	font = 'CloseCaption_Bold',
	size = 24,
	weight = 700
} )
-- ШРИФТ ДЛЯ ХУДА [КОНЕЦ]

-- ШРИФТ ДЛЯ НИКНЕЙМОВ НАД ГОЛОВОЙ [НАЧАЛО]
surface.CreateFont('fontnicknames', {
	font = 'CloseCaption_Bold',
	size = 70,
	weight = 800,
} )
-- ШРИФТ ДЛЯ НИКНЕЙМОВ НАД ГОЛОВОЙ [КОНЕЦ]

-- ШРИФТЫ ДЛЯ ПАТРОНОВ [НАЧАЛО]
surface.CreateFont('additionalfontforammo', {
	font = 'CloseCaption_Bold',
	size = 34,
	weight = 700
} )

surface.CreateFont('mainfontforammo', {
	font = 'CloseCaption_Bold',
	size = 24,
	weight = 600,
} )
-- ШРИФТЫ ДЛЯ ПАТРОНОВ [КОНЕЦ]	

local function simplehud()
	
-- ЕЩЁ ОДНИ ЛОКАЛКИ ДЛЯ УПРОЩЕНИЯ ЖИЗНИ [НАЧАЛО]
	local ply = LocalPlayer()
	local hp = ply:Health() or 0
	local arm = ply:Armor() or 0
-- ЕЩЁ ОДНИ ЛОКАЛКИ ДЛЯ УПРОЩЕНИЯ ЖИЗНИ [КОНЕЦ]

--АНИМАЦИЯ ДЛЯ HP И ARMOR [НАЧАЛО]
	animationforhp = Lerp(6.5 * FrameTime(), animationforhp or 0, hp or 0)
	animationforarmor = Lerp(6.5 * FrameTime(), animationforarmor or 0, arm or 0)
--АНИМАЦИЯ ДЛЯ HP И ARMOR[КОНЕЦ]

-- HP [НАЧАЛО]
if ply:Alive() then
	if hp > 0 then
		draw.RoundedBox(1, x + 26 , y + 120, 159, 10, Color(0, 0, 0, 150) )
		draw.RoundedBox(1, x + 26 , y + 120, math.Clamp(animationforhp, 0.1, 100)*1.6, 10, Color(255, 0, 0) )
		draw.SimpleText('' .. hp, 'fontforhud', x+89, y+90.8, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP) -- ТЕНЬ
		draw.SimpleText('' .. hp, 'fontforhud', x+86, y+90.8, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP) -- САМ ТЕКСТ
end
-- HP [КОНЕЦ]

-- ARMOR [НАЧАЛО]
	if arm > 0 then
		draw.RoundedBox(1, x + 188 , y + 120, 159, 10, Color(0, 0, 0, 150) )
		draw.RoundedBox(1, x + 188 , y + 120, math.Clamp(animationforarmor, 0, 100)*1.6, 10, Color(0, 0, 255) )
		draw.SimpleText(arm, 'fontforhud', x+273, y+103, Color(0, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)  -- ТЕНЬ
		draw.SimpleText(arm, 'fontforhud', x+270, y+103, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER) -- САМ ТЕКСТ
		draw.SimpleText('/', 'fontforhud', x+183, y+111, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP) -- ТЕНЬ
		draw.SimpleText('/', 'fontforhud', x+180, y+111, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP) -- САМ ТЕКСТ
		end
	end
end
-- ARMOR [КОНЕЦ]

-- AMMO [НАЧАЛО]
local function ammohud()
		local ply = LocalPlayer()
			if !IsValid(ply:GetActiveWeapon()) then return end
				local ammo, reloadammo = LocalPlayer():GetActiveWeapon():Clip1() < 0 and 0 or ply:GetActiveWeapon():Clip1(), ply:GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType())
				local disabledammo = ammo <= 0 and reloadammo <= 0 and true or false
				if disabledammo then return end
		draw.SimpleText(ammo..'/'..reloadammo, 'additionalfontforammo', x_ammo-69, y_ammo+74, Color(0, 0, 0), TEXT_ALIGN_RIGHT, TEXT_ALIGN_RIGHT) -- ТЕНЬ
		draw.SimpleText(ammo..'/'..reloadammo, 'additionalfontforammo', x_ammo-72, y_ammo+75, Color(255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_RIGHT) -- САМ ТЕКСТ
		draw.SimpleText('Патроны', 'mainfontforammo', x_ammo-70, y_ammo+55, Color(0, 0, 0), TEXT_ALIGN_RIGHT, TEXT_ALIGN_RIGHT) -- ТЕНЬ
		draw.SimpleText('Патроны', 'mainfontforammo', x_ammo-73, y_ammo+55, Color(255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_RIGHT) -- САМ ТЕКСТ

end
hook.Add('HUDPaint', 'ammohud', ammohud)
-- AMMO [КОНЕЦ]

-- NICKNAMES OVER HEAD [НАЧАЛО]
local function nicknamesoverhead( ply )

	if !IsValid( ply ) then return end

	local Distancenicknames = LocalPlayer():GetPos():Distance( ply:GetPos() )
	
	if ( Distancenicknames < 1000 ) then

	local Color1 = Color(255, 255, 255)

	local Color2 = Color(0, 0, 0)

	local namefornick = ply:Name()

	cam.Start3D2D( ply:GetPos() + Vector( 0, 0, 85), Angle( 0, RenderAngles().y - 90, 90 ), 0.1)
		draw.SimpleTextOutlined( namefornick, 'fontnicknames', 0, 3, Color2, TEXT_ALIGN_CENTER, 0, 0 )
		draw.SimpleTextOutlined( namefornick, 'fontnicknames', 0, 0, Color1, TEXT_ALIGN_CENTER, 0, 0 )
	cam.End3D2D()

end

end
-- NICKNAMES OVER HEAD [КОНЕЦ]
hook.Add('PostPlayerDraw', 'nicknamesoverhead', nicknamesoverhead )

hook.Add('HUDPaint', 'simplehud', simplehud)