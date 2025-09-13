local globalHook = Game.set_globals
function Game:set_globals()
    globalHook(self)
    if self.C then
    self.C.UNIK_SHITTY_EDITION =self.C.UNIK_SHITTY_EDITION or {0,0,0,1}
    self.C.UNIK_LARTCEPS1 = self.C.UNIK_LARTCEPS1 or {1,0,0,1}
    self.C.UNIK_RGB = self.C.UNIK_RGB or {0,0,0,1}
    self.C.UNIK_ANCIENT = self.C.UNIK_ANCIENT or {0,0,0,1}
    self.C.UNIK_RGB_HUE = self.C.UNIK_RGB_HUE or 0
    self.C.UNIK_LARTCEPS_INVERSE = self.C.UNIK_LARTCEPS_INVERSE or {1,0,0,1}
    self.C.UNIK_THE_PLANT = HEX('709284')
    self.C.UNIK_THE_WHEEL = HEX('50bf7c')
    self.C.UNIK_THE_HOUSE = HEX('5186a8')
    self.C.UNIK_THE_TOOTH = HEX('b52d2d')
    self.C.UNIK_THE_MANACLE = HEX('575757')
    self.C.UNIK_THE_WALL = HEX('8a59a5')
    self.C.UNIK_THE_GOAD = HEX('b95c96')
    self.C.UNIK_THE_WINDOW = HEX('a9a295')
    self.C.UNIK_THE_CLUB = HEX('b9cb92')
    self.C.UNIK_THE_HEAD = HEX('ac9db4')
    self.C.UNIK_THE_ARM = HEX('6865f3')
    self.C.UNIK_THE_HOOK = HEX('a84024')
    self.C.UNIK_ORTA_THE_HAMMER = HEX('6a3847')
    self.C.UNIK_MAYA = HEX('ff00ab')
    self.C.UNIK_YOKANA = HEX('86cafe')
    self.C.UNIK_CHELSEA = HEX('d298fd')
    self.C.UNIK_EYE_SEARING_BLUE = HEX('0000ff')
    self.C.UNIK_SYNC_CATALYST_FAIL = self.C.UNIK_SYNC_CATALYST_FAIL or {0,0,0,1}
    self.C.UNIK_VOID_COLOR = HEX('000000')
    self.C.UNIK_EYE_SEARING_RED= HEX('ff0000')
    self.C.UNIK_UNIK = HEX('fe90ff')
    self.C.UNIK_CAPTION = HEX('009A9A')
    end
     
end

local locHook = loc_colour
function loc_colour(_c, _default)
    if not G.ARGS.LOC_COLOURS then
		locHook()
	end
    G.ARGS.LOC_COLOURS.unik_shitty_edition = G.C.UNIK_SHITTY_EDITION
    G.ARGS.LOC_COLOURS.unik_plant_color = G.C.UNIK_THE_PLANT
    G.ARGS.LOC_COLOURS.unik_manacle_color = G.C.UNIK_THE_MANACLE
    G.ARGS.LOC_COLOURS.unik_wall_color = G.C.UNIK_THE_WALL
    G.ARGS.LOC_COLOURS.unik_goad_color = G.C.UNIK_THE_GOAD
    G.ARGS.LOC_COLOURS.unik_window_color = G.C.UNIK_THE_WINDOW
    G.ARGS.LOC_COLOURS.unik_club_color = G.C.UNIK_THE_CLUB
    G.ARGS.LOC_COLOURS.unik_head_color = G.C.UNIK_THE_HEAD
    G.ARGS.LOC_COLOURS.unik_arm_color = G.C.UNIK_THE_ARM
    G.ARGS.LOC_COLOURS.unik_hook_color = G.C.UNIK_THE_HOOK
    G.ARGS.LOC_COLOURS.unik_orta_hammer_color = G.C.UNIK_ORTA_THE_HAMMER
    G.ARGS.LOC_COLOURS.unik_eye_searing_blue = G.C.UNIK_EYE_SEARING_BLUE
    G.ARGS.LOC_COLOURS.unik_eye_searing_red = G.C.UNIK_EYE_SEARING_RED
    G.ARGS.LOC_COLOURS.unik_void_color = G.C.UNIK_VOID_COLOR
    G.ARGS.LOC_COLOURS.unik_maya_color = G.C.UNIK_MAYA
    G.ARGS.LOC_COLOURS.unik_yokana_color = G.C.UNIK_YOKANA
    G.ARGS.LOC_COLOURS.unik_chelsea_color = G.C.UNIK_CHELSEA
    G.ARGS.LOC_COLOURS.unik_unik_color = G.C.UNIK_UNIK
    G.ARGS.LOC_COLOURS.unik_caption = G.C.UNIK_CAPTION
    G.ARGS.LOC_COLOURS.unik_lartceps1 = G.C.UNIK_LARTCEPS1
    G.ARGS.LOC_COLOURS.unik_lartceps_inverse = G.C.UNIK_LARTCEPS_INVERSE
    G.ARGS.LOC_COLOURS.unik_wheel_color = G.C.UNIK_THE_WHEEL
    G.ARGS.LOC_COLOURS.unik_house_color = G.C.UNIK_THE_HOUSE
    G.ARGS.LOC_COLOURS.unik_tooth_color = G.C.UNIK_THE_TOOTH
    return locHook(_c,_default)
end