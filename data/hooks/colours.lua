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
    G.ARGS.LOC_COLOURS.unik_rgb = G.C.UNIK_RGB
    G.ARGS.LOC_COLOURS.unik_summit = G.C.UNIK_SUMMIT
    return locHook(_c,_default)
end