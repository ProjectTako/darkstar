-----------------------------------
-- Area: Stellar Fulcrum
-- NPC:  Kam'lanaut
-- Zilart Mission 8 BCNM Fight
-----------------------------------

require("scripts/globals/titles");
require("scripts/globals/status");
require("scripts/globals/magic");

local blades = {567, 570, 572, 569, 568, 571};

-----------------------------------
-- onMobSpawn Action
-----------------------------------

function onMobSpawn(mob)
end;

function onMobFight(mob, target)

    local changeTime = mob:getLocalVar("changeTime");
    local element = mob:getLocalVar("element");

    if (changeTime == 0) then
        mob:setLocalVar("changeTime",math.random(1,3)*15)
        return;
    end
    if (mob:getBattleTime() >= changeTime) then
        local newelement = element;
        while (newelement == element) do
            newelement = math.random(1,6);
        end
        if (element ~= 0) then
            mob:delMod(absorbMod[element], 100);
        end
        mob:useMobAbility(blades[newelement]);
        mob:addMod(absorbMod[newelement], 100);
        mob:setLocalVar("changeTime", mob:getBattleTime() + math.random(1,3)*15);
        mob:setLocalVar("element", newelement);
    end
end;

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob,killer)
	killer:addTitle(DESTROYER_OF_ANTIQUITY);
end;