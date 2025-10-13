/* Taken from https://github.com/djpohly/dwl/issues/466 */
#define COLOR(hex)    { ((hex >> 24) & 0xFF) / 255.0f, \
                        ((hex >> 16) & 0xFF) / 255.0f, \
                        ((hex >> 8) & 0xFF) / 255.0f, \
                        (hex & 0xFF) / 255.0f }
/* appearance */
static const int sloppyfocus               = 1;  /* focus follows mouse */
static const int bypass_surface_visibility = 0;  /* 1 means idle inhibitors will disable idle tracking even if it's surface isn't visible  */
static const unsigned int borderpx         = 1;  /* border pixel of windows */
static const int showbar                   = 1; /* 0 means no bar */
static const int topbar                    = 1; /* 0 means bottom bar */
static const char *fonts[]                 = {"monospace:size=10"};
static const float rootcolor[]             = COLOR(0x181716ff);
static const float fullscreen_bg[]         = COLOR(0xb16286ff);
static uint32_t colors[][3]                = {
	/*               fg          bg          border    */
	[SchemeNorm] = { 0xebdbb2ff, 0x181716ff, 0x282828ff },
	[SchemeSel]  = { 0xfbf1c7ff, 0x3c3836ff, 0x3c3836ff },
	[SchemeUrg]  = { 0,          0,          0x770000ff },
};

/* tagging - TAGCOUNT must be no greater than 31 */
static char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

/* logging */
static int log_level = WLR_ERROR;

/* NOTE: ALWAYS keep a rule declared even if you don't use rules (e.g leave at least one example) */
static const Rule rules[] = {
	{ NULL,  NULL,       0,       -1,           -1 },
};

/* layout(s) */
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* monitors */
/* (x=-1, y=-1) is reserved as an "autoconfigure" monitor position indicator
 * WARNING: negative values other than (-1, -1) cause problems with Xwayland clients
 * https://gitlab.freedesktop.org/xorg/xserver/-/issues/899
*/
/* NOTE: ALWAYS add a fallback rule, even if you are completely sure it won't be used */
static const MonitorRule monrules[] = {
	/* name       mfact  nmaster scale layout       rotate/reflect              x  y  resx resy rate mode adaptive*/
	/* example of a HiDPI laptop monitor at 120Hz:
	{ "eDP-1",    0.5f,  1,      2,    &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL, 0, 0, 0, 0, 120.000f, 1, 1},
	* mode let's the user decide on how dwl should implement the modes:
	* -1 Sets a custom mode following the users choice
	* All other number's set the mode at the index n, 0 is the standard mode; see wlr-randr
	*/
	// { "DP-2",     0.55f, 1,      1,    &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL, 768, 160, 0,   0,   0.0f, 1,   0 },
	// { "DP-1",     0.55f, 1,      1,    &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL, 768, 160, 0,   0,   0.0f, 1,   0 },
	// { "HDMI-A-1", 0.55f, 0,      1,    &layouts[0], WL_OUTPUT_TRANSFORM_90,     0,   0,   0,   0,   0.0f, 0,   0 },
	/* defaults */
	{ NULL,       0.55f, 1, 2,    &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL, 0, 0, 0, 0, 0.0f, 1, 1},
};

/* keyboard */
static const struct xkb_rule_names xkb_rules = {
	/* can specify fields: rules, model, layout, variant, options */
	/* example:
	.options = "ctrl:nocaps",
	*/
	.options = NULL,
};

static const int repeat_rate = 48;
static const int repeat_delay = 430;

/* Trackpad */
static const int tap_to_click = 1;
static const int tap_and_drag = 1;
static const int drag_lock = 1;
static const int natural_scrolling = 1;
static const int disable_while_typing = 1;
static const int left_handed = 0;
static const int middle_button_emulation = 0;
/* You can choose between:
LIBINPUT_CONFIG_SCROLL_NO_SCROLL
LIBINPUT_CONFIG_SCROLL_2FG
LIBINPUT_CONFIG_SCROLL_EDGE
LIBINPUT_CONFIG_SCROLL_ON_BUTTON_DOWN
*/
static const enum libinput_config_scroll_method scroll_method = LIBINPUT_CONFIG_SCROLL_2FG;

/* You can choose between:
LIBINPUT_CONFIG_CLICK_METHOD_NONE
LIBINPUT_CONFIG_CLICK_METHOD_BUTTON_AREAS
LIBINPUT_CONFIG_CLICK_METHOD_CLICKFINGER
*/
static const enum libinput_config_click_method click_method = LIBINPUT_CONFIG_CLICK_METHOD_BUTTON_AREAS;

/* You can choose between:
LIBINPUT_CONFIG_SEND_EVENTS_ENABLED
LIBINPUT_CONFIG_SEND_EVENTS_DISABLED
LIBINPUT_CONFIG_SEND_EVENTS_DISABLED_ON_EXTERNAL_MOUSE
*/
static const uint32_t send_events_mode = LIBINPUT_CONFIG_SEND_EVENTS_ENABLED;

/* You can choose between:
LIBINPUT_CONFIG_ACCEL_PROFILE_FLAT
LIBINPUT_CONFIG_ACCEL_PROFILE_ADAPTIVE
*/
static const enum libinput_config_accel_profile accel_profile = LIBINPUT_CONFIG_ACCEL_PROFILE_FLAT;
static const double accel_speed = 0.0;

/* You can choose between:
LIBINPUT_CONFIG_TAP_MAP_LRM -- 1/2/3 finger tap maps to left/right/middle
LIBINPUT_CONFIG_TAP_MAP_LMR -- 1/2/3 finger tap maps to left/middle/right
*/
static const enum libinput_config_tap_button_map button_map = LIBINPUT_CONFIG_TAP_MAP_LRM;

/* If you want to use the windows key for MODKEY, use WLR_MODIFIER_LOGO */
#define MODKEY WLR_MODIFIER_LOGO

#define TAGKEYS(KEY,SKEY,TAG) \
	{ MODKEY,                    KEY,            view,            {.ui = 1 << TAG} }, \
	{ MODKEY|WLR_MODIFIER_CTRL,  KEY,            toggleview,      {.ui = 1 << TAG} }, \
	{ MODKEY|WLR_MODIFIER_SHIFT, SKEY,           tag,             {.ui = 1 << TAG} }, \
	{ MODKEY|WLR_MODIFIER_CTRL|WLR_MODIFIER_SHIFT,SKEY,toggletag, {.ui = 1 << TAG} }

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char *termcmd[] = { "footclient", NULL };
static const char *trbucmd[] = { "foot", NULL };
static const char *menucmd[] = { "wmenu-run", NULL };
static const char *shotful[] = { "wshot", NULL };
static const char *shotsel[] = { "wshot", "-s", NULL };
static const char *audmute[] = { "vol", "mute", NULL };
static const char *micmute[] = { "vol", "mute", "mic", NULL };
static const char *audincn[] = { "vol", "incn", NULL };
static const char *auddecr[] = { "vol", "decr", NULL };
static const char *musplay[] = { "mpris", "play", NULL };
static const char *musnext[] = { "mpris", "next", NULL };
static const char *musprev[] = { "mpris", "prev", NULL };
static const char *bridecr[] = { "bri", "-10", NULL };
static const char *briincn[] = { "bri", "+10", NULL };

static const Key keys[] = {
	/* Note that Shift changes certain key codes: c -> C, 2 -> at, etc. */
	/* modifier                  key                 function        argument */
	{ 0, XKB_KEY_XF86AudioMute,                      spawn,          {.v = audmute} },
	{ 0, XKB_KEY_XF86AudioMicMute,                   spawn,          {.v = micmute} },
	{ 0, XKB_KEY_XF86AudioRaiseVolume,               spawn,          {.v = audincn} },
	{ 0, XKB_KEY_XF86AudioLowerVolume,               spawn,          {.v = auddecr} },
	{ 0, XKB_KEY_XF86AudioPlay,                      spawn,          {.v = musplay} },
	{ 0, XKB_KEY_XF86AudioNext,                      spawn,          {.v = musnext} },
	{ 0, XKB_KEY_XF86AudioPrev,                      spawn,          {.v = musprev} },
	{ 0, XKB_KEY_XF86MonBrightnessUp,                spawn,          {.v = bridecr} },
	{ 0, XKB_KEY_XF86MonBrightnessDown,              spawn,          {.v = briincn} },
	{ WLR_MODIFIER_SHIFT,        XKB_KEY_Print,      spawn,          {.v = shotful} },
	{ 0,                         XKB_KEY_Print,      regions,        {.v = shotsel} },
	{ MODKEY,                    XKB_KEY_m,          spawn,          {.v = menucmd} },
	{ MODKEY,                    XKB_KEY_e,          spawn,          {.v = termcmd} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_E,          spawn,          {.v = trbucmd} },
	{ MODKEY,                    XKB_KEY_b,          togglebar,      {0} },
	{ MODKEY,                    XKB_KEY_a,          focusstack,     {.i = +1} },
	{ MODKEY,                    XKB_KEY_d,          focusstack,     {.i = -1} },
	{ MODKEY,                    XKB_KEY_w,          incnmaster,     {.i = +1} },
	{ MODKEY,                    XKB_KEY_s,          incnmaster,     {.i = -1} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_A,          setmfact,       {.f = -0.05f} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_D,          setmfact,       {.f = +0.05f} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_W,          setcfact,       {.f = +0.25f} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_S,          setcfact,       {.f = -0.25f} },
	{ MODKEY,                    XKB_KEY_Return,     zoom,           {0} },
	{ MODKEY,                    XKB_KEY_Tab,        view,           {0} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_C,          killclient,     {0} },
	/*
	{ MODKEY,                    XKB_KEY_t,          setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                    XKB_KEY_f,          setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                    XKB_KEY_m,          setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                    XKB_KEY_space,      setlayout,      {0} },
	*/
	{ MODKEY,                    XKB_KEY_f,          togglefloating, {0} },
	{ MODKEY,                    XKB_KEY_q,        togglefullscreen, {0} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_Q,    togglefakefullscreen, {0} },
	{ MODKEY,                    XKB_KEY_0,          view,           {.ui = ~0} },
	{ MODKEY,                    XKB_KEY_r,          focusmon,       {.i = WLR_DIRECTION_LEFT} },
	{ MODKEY,                    XKB_KEY_t,          tagmon,         {.i = WLR_DIRECTION_RIGHT} },
	TAGKEYS(          XKB_KEY_1, XKB_KEY_exclam,                     0),
	TAGKEYS(          XKB_KEY_2, XKB_KEY_at,                         1),
	TAGKEYS(          XKB_KEY_3, XKB_KEY_numbersign,                 2),
	TAGKEYS(          XKB_KEY_4, XKB_KEY_dollar,                     3),
	TAGKEYS(          XKB_KEY_5, XKB_KEY_percent,                    4),
	TAGKEYS(          XKB_KEY_6, XKB_KEY_asciicircum,                5),
	TAGKEYS(          XKB_KEY_7, XKB_KEY_ampersand,                  6),
	TAGKEYS(          XKB_KEY_8, XKB_KEY_asterisk,                   7),
	TAGKEYS(          XKB_KEY_9, XKB_KEY_parenleft,                  8),
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_Z,          quit,           {0} },

	/* Ctrl-Alt-Backspace and Ctrl-Alt-Fx used to be handled by X server */
	{ WLR_MODIFIER_CTRL|WLR_MODIFIER_ALT,XKB_KEY_Terminate_Server, quit, {0} },
	/* Ctrl-Alt-Fx is used to switch to another VT, if you don't know what a VT is
	 * do not remove them.
	 */
#define CHVT(n) { WLR_MODIFIER_CTRL|WLR_MODIFIER_ALT,XKB_KEY_XF86Switch_VT_##n, chvt, {.ui = (n)} }
	CHVT(1), CHVT(2), CHVT(3), CHVT(4), CHVT(5), CHVT(6),
	CHVT(7), CHVT(8), CHVT(9), CHVT(10), CHVT(11), CHVT(12),
};

static const Button buttons[] = {
	{ ClkLtSymbol, 0,      BTN_LEFT,   setlayout,      {.v = &layouts[0]} },
	{ ClkLtSymbol, 0,      BTN_RIGHT,  setlayout,      {.v = &layouts[2]} },
	{ ClkTitle,    0,      BTN_MIDDLE, zoom,           {0} },
	{ ClkStatus,   0,      BTN_MIDDLE, spawn,          {.v = termcmd} },
	{ ClkClient,   MODKEY, BTN_LEFT,   moveresize,     {.ui = CurMove} },
	{ ClkClient,   MODKEY, BTN_MIDDLE, togglefloating, {0} },
	{ ClkClient,   MODKEY, BTN_RIGHT,  moveresize,     {.ui = CurResize} },
	{ ClkTagBar,   0,      BTN_LEFT,   view,           {0} },
	{ ClkTagBar,   0,      BTN_RIGHT,  toggleview,     {0} },
	{ ClkTagBar,   MODKEY, BTN_LEFT,   tag,            {0} },
	{ ClkTagBar,   MODKEY, BTN_RIGHT,  toggletag,      {0} },
};
