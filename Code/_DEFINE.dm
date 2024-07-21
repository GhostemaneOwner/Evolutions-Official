// Movement

#define EVENT_SCHEDULING_LOG_ERRORS
#define EVENT_SCHEDULING_LOG_WARNINGS

#define TeachNotice 1

#define LowDrain 0.35
#define MediumDrain 0.7
#define HighDrain 1
//#define VeryHighDrain 1.3

#define LowStaticDrain 15
#define MediumStaticDrain 25
#define HighStaticDrain 50

#define GenericReq 3500
#define GenericReq2 10000

#define CoolerForm1 20000
#define CoolerForm2 50000
#define CoolerForm4 1200000
#define KingKoldForm1 50000

#define ThirdEyeReq 30000 //This is assigned per character and can vary +/- 50%
#define SNjReq 150000 //This is assigned per character and can vary +/- 25%

#define Tier1Req  100000
#define Tier2Req  1500000
#define Tier3Req  2250000

#define EarlyALReq 70000
#define SSjReq 150000

#define FBMAt 1000000
#define AscensionAt 4000000


#define XPRate 20 //xp awarded per hour

#define MAX_DIST 256 // the max distance any automated movement will pursue
#define CLOUD_SPEED 1 // this is for cloud speeds

// Planes
#define DS_AREA_PLANE 50 // few things should be above this
#define DS_LIGHTING_PLANE 55
#define DS_HUD_PLANE 99 // keep this up top

// Layers
#define DS_MOB_LAYER 4
#define DS_OBJ_LAYER 2
#define DS_TURF_LAYER 1
#define DS_AREA_LAYER 100
#define DS_DAY_LAYER 100.1 // for day cycle
#define DS_WEATHER_LAYER 98
#define DS_SKY_LAYER 99 // for clouds currently
#define DS_HUD_LAYER 999 // for HUDs
#define DS_LIGHT_LAYER 145 // for lights that multiply into planes
#define DS_LIGHTNING_LAYER 150 // for lightning

// Tiles
#define TILE_SIZE 32 // use this for width and height, its square after all
#define HALF_TILE_SIZE 16

// Height
#define FLY_HEIGHT 32
#define STAND_HEIGHT 0

// Useful functions
#define clamp(value,low,high) min(max(value,low),high)
#define ceil(x) (-round(-(x))) // for rounding up
#define floor(x) round(x) // rounding down
#define ismovable(o) istype(o,/atom/movable)
#define islist(o) istype(o,/list)
#define DEBUG( _Msg... )        world.log << "[__LINE__]|[__FILE__] : [ ##_Msg ]"

// Map
#define SaveInt 18000
#define WEATHERTIMER 5
