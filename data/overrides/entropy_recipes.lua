--hooks and stuff for  new entropy recipes

Entropy.EnhancementPoints.m_unik_namta = -666
Entropy.EnhancementPoints.m_unik_pink = 5.7
Entropy.EnhancementPoints.m_unik_green = 6.9
Entropy.EnhancementPoints.m_unik_dollar = 5.3
Entropy.EnhancementPoints.m_unik_timber = 5.6
Entropy.EnhancementPoints.m_unik_bill = 5.3

function UNIK.build_fixed_recipe(enhancements,result)
    local newTable = {}
    for i,v in pairs(enhancements) do
        for j = 1, v do
            newTable[#newTable+1] = i
        end
    end
    print(newTable)
    if #newTable == 5 then
        table.sort(newTable, function(a,b)return (enhancements[a])>(enhancements[b]) end)
        local string = Entropy.ConcatStrings(newTable)
        Entropy.FixedRecipes[string] = result
        print("Recipe " .. string .. " created successfully")
        return true
    else
        print("INVALID RECIPE; MUST BE EXACTLY 5 CARDS!")
        return false
    end
end

UNIK.build_fixed_recipe({m_unik_timber = 5},'j_unik_beaver')
UNIK.build_fixed_recipe({m_unik_pink = 5},'j_unik_reggie')
UNIK.build_fixed_recipe({m_unik_dollar = 5},'j_unik_joker_dollar')
UNIK.build_fixed_recipe({m_unik_namta = 5},'j_unik_earthmover')
UNIK.build_fixed_recipe({m_unik_green = 5},'j_unik_onyx_agate')
UNIK.build_fixed_recipe({m_unik_bill = 5},'j_mf_top10')
UNIK.build_fixed_recipe({m_unik_bill = 1,m_entr_disavowed = 1, c_base = 3},'j_entr_tenner')
UNIK.build_fixed_recipe({m_entr_flesh = 4,m_unik_namta = 1},'j_unik_monster_spawner')
UNIK.build_fixed_recipe({m_unik_pink = 4,m_entr_disavowed = 1},'j_unik_xchips_hater')
UNIK.build_fixed_recipe({m_entr_flesh = 4,m_entr_disavowed = 1},'j_unik_autocannibalism')
UNIK.build_fixed_recipe({m_unik_bill = 1,m_entr_disavowed = 4},'j_unik_decaying_tooth')
UNIK.build_fixed_recipe({m_unik_bill = 1,m_entr_disavowed = 3,m_unik_namta = 1},'j_unik_impounded')
UNIK.build_fixed_recipe({m_bonus = 4,m_unik_pink = 1},'j_unik_chipzel')
UNIK.build_fixed_recipe({c_base = 2,m_unik_pink = 3},'j_unik_uniku')
UNIK.build_fixed_recipe({c_base = 4,m_unik_pink = 1},'j_unik_numerical_reinforcement')
UNIK.build_fixed_recipe({m_steel = 2,m_lucky = 2, m_entr_disavowed = 1},'j_unik_megatron')
UNIK.build_fixed_recipe({m_steel = 2,m_lucky = 2, c_base = 1},'j_unik_D16')
UNIK.build_fixed_recipe({m_steel = 1,m_entr_flesh = 3,m_unik_pink = 1},'j_unik_lily_sprunki')
UNIK.build_fixed_recipe({m_entr_ceramic = 1,m_entr_disavowed = 1,c_base = 3},'j_unik_vessel_kiln')
UNIK.build_fixed_recipe({m_entr_prismatic = 2,m_unik_pink = 3},'j_unik_unik')
UNIK.build_fixed_recipe({m_entr_prismatic = 2,m_glass = 3},'j_unik_white_lily_cookie')
UNIK.build_fixed_recipe({m_entr_ethereal = 2,m_base = 3},'j_unik_ghost_joker')
UNIK.build_fixed_recipe({m_unik_dollar = 3,m_gold = 2},'j_unik_compounding_interest')
UNIK.build_fixed_recipe({m_entr_disavowed = 1, m_stone = 4},'j_unik_border_wall')
--bunco recipes
UNIK.build_fixed_recipe({m_bunc_copper = 2,m_glass = 3},'j_unik_hall_of_mirrors')
UNIK.build_fixed_recipe({m_bunc_copper = 5},'j_bunc_kite_experiment')
UNIK.build_fixed_recipe({m_bunc_copper = 2,m_unik_pink = 1,c_base = 2},'j_unik_blossom')
UNIK.build_fixed_recipe({m_bunc_copper = 1,m_lucky = 1,m_wild = 1, m_mult = 1, m_bonus = 1},'j_bunc_jmjb')
UNIK.build_fixed_recipe({m_bunc_cracker = 5},'j_bunc_hardtack')
UNIK.build_fixed_recipe({m_steel = 1, m_gold = 2, m_stone = 2},'j_bunc_dwaven')

local entroper = Entropy.GetRecipeResult
function Entropy.GetRecipeResult(val,jokerrares,seed)
	local res = entroper(val,jokerrares,seed)

	local rare = 1
	local cost= 0
	for i, v in pairs({
		unik_detrimental = -99999999999999,
		unik_ancient = 37
	}) do
		if (v >= cost or (i == 'unik_detrimental' and val < 0))and val >= v then
			rare = i;cost=v
		end
	end
	if rare == 'unik_detrimental' or rare == 'unik_ancient' then
		return pseudorandom_element(jokerrares[rare] or {}, pseudoseed(seed)) or "j_joker"
	end
	--print(Entropy.EnhancementPoints)
	return res
end

local recipeRead = Entropy.GetRecipe
function Entropy.GetRecipe(cards)
    local ret = recipeRead(cards)
    if #cards == 5 then
        local enhancements = Entropy.EnhancementPoints
        local enh = {}
        for i = 1, 5 do
            local card = cards[i]
            if card then
                enh[#enh+1]=card.config.center.key
            end
        end
        table.sort(enh, function(a,b)return (enhancements[a])>(enhancements[b]) end)
        print(Entropy.ConcatStrings(enh))
    end
    return ret 
end