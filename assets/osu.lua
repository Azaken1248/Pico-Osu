
-- ==========================================================
--                        PICO OSU
-- ==========================================================

--By Azaken

function snap_to_grid(coord, grid_size)
    return flr(coord / grid_size) * grid_size + flr(grid_size / 2)
end

_prev_btn_state = {}
function btnr(b)
  return _prev_btn_state[b] and not btn(b)
end

function is_nan(x)
  return x ~= x
end

function is_inf(x)
  return x == 1/0 or x == -1/0
end

function sanitize_pico8_int(val)
    if is_nan(val) or is_inf(val) then
        return 0
    end
    val = flr(val) 
    if val > 32767 then return 32767 end
    if val < -32768 then return -32768 end
    return val
end


local point_300 = 75   
local point_100 = 25   
local point_50 = 12   

local ur_error_scaler = 10

function _init()
  poke(0x5f2d, 3) 
  load_marshmary_data()

  for i=0,5 do 
    _prev_btn_state[i] = false
  end

  if (global_od == nil) then
    global_od = 5
  end
  if (global_ar == nil) then
    global_ar = 8 
  end
  calculate_settings()

  songs = {
    {
      title="pico-beat!",
      artist="mboffin",
      music_pattern=0,
      beatmap={
        {sec=1, x=64, y=64, radius=10}, {sec=2, x=30, y=40, radius=10},
        {sec=3, x=98, y=90, radius=10}, {sec=4, x=64, y=64, radius=10}
      }
    },
    {
      title="chiptune mania",
      artist="lexaloffle",
      music_pattern=1,
      beatmap={
        {sec=1.0, x=32, y=32, radius=10}, {sec=1.5, x=96, y=32, radius=10},
        {sec=2.0, x=32, y=96, radius=10}, {sec=2.5, x=96, y=96, radius=10},
        {sec=3.0, x=64, y=64, radius=10}
      }
    },
    {
      title="marshmary",
      artist="mimi",
      music_pattern=3,
      beatmap={
        -- full marshmary beatmap restored
        {sec=11.044, x=45, y=8, radius=10}, {sec=11.208, x=45, y=8, radius=10},
        {sec=11.373, x=59, y=35, radius=10}, {sec=11.703, x=96, y=11, radius=10},
        {sec=11.868, x=96, y=11, radius=10}, {sec=14.011, x=6, y=88, radius=10},
        {sec=14.175, x=6, y=88, radius=10}, {sec=15.165, x=39, y=9, radius=10},
        {sec=16.154, x=32, y=100, radius=10}, {sec=16.648, x=18, y=42, radius=10},
        {sec=16.978, x=61, y=53, radius=10}, {sec=17.143, x=61, y=53, radius=10},
        {sec=17.802, x=102, y=86, radius=10}, {sec=17.967, x=93, y=117, radius=10},
        {sec=19.121, x=35, y=86, radius=10}, {sec=19.78, x=39, y=17, radius=10},
        {sec=19.945, x=47, y=47, radius=10}, {sec=20.11, x=47, y=47, radius=10},
        {sec=20.274, x=70, y=58, radius=10}, {sec=20.439, x=66, y=26, radius=10},
        {sec=20.769, x=48, y=86, radius=10}, {sec=22.252, x=92, y=8, radius=10},
        {sec=22.417, x=73, y=27, radius=10}, {sec=23.901, x=32, y=88, radius=10},
        {sec=24.066, x=17, y=114, radius=10}, {sec=24.725, x=35, y=88, radius=10},
        {sec=25.715, x=55, y=43, radius=10}, {sec=26.703, x=97, y=68, radius=10},
        {sec=27.197, x=54, y=77, radius=10}, {sec=27.527, x=14, y=99, radius=10},
        {sec=27.692, x=14, y=99, radius=10}, {sec=28.351, x=41, y=50, radius=10},
        {sec=28.516, x=39, y=19, radius=10}, {sec=29.67, x=83, y=19, radius=10},
        {sec=30.329, x=98, y=102, radius=10}, {sec=30.494, x=81, y=126, radius=10},
        {sec=30.659, x=81, y=126, radius=10}, {sec=30.823, x=59, y=111, radius=10},
        {sec=30.988, x=36, y=123, radius=10}, {sec=31.318, x=21, y=67, radius=10},
        {sec=32.307, x=102, y=122, radius=10}, {sec=33.626, x=63, y=112, radius=10},
        {sec=35.439, x=51, y=12, radius=10}, {sec=37.582, x=66, y=51, radius=10},
        {sec=38.901, x=88, y=5, radius=10}, {sec=40.714, x=86, y=118, radius=10},
        {sec=42.692, x=1, y=40, radius=10}, {sec=42.857, x=19, y=63, radius=10},
        {sec=44.011, x=46, y=102, radius=10}, {sec=44.175, x=46, y=102, radius=10},
        {sec=45.0, x=75, y=97, radius=10}, {sec=45.824, x=66, y=47, radius=10},
        {sec=47.143, x=18, y=49, radius=10}, {sec=47.967, x=38, y=107, radius=10},
        {sec=48.461, x=103, y=124, radius=10}, {sec=49.121, x=97, y=19, radius=10},
        {sec=49.945, x=12, y=39, radius=10}, {sec=50.11, x=12, y=39, radius=10},
        {sec=50.439, x=54, y=66, radius=10}, {sec=50.604, x=54, y=66, radius=10},
        {sec=51.099, x=50, y=116, radius=10}, {sec=51.263, x=29, y=108, radius=10},
        {sec=51.428, x=10, y=124, radius=10}, {sec=52.088, x=12, y=124, radius=10},
        {sec=52.912, x=36, y=123, radius=10}, {sec=53.406, x=36, y=123, radius=10},
        {sec=54.23, x=23, y=35, radius=10}, {sec=54.724, x=23, y=35, radius=10},
        {sec=55.055, x=46, y=52, radius=10}, {sec=55.219, x=58, y=46, radius=10},
        {sec=55.549, x=82, y=59, radius=10}, {sec=56.043, x=82, y=59, radius=10},
        {sec=56.868, x=35, y=120, radius=10}, {sec=57.362, x=35, y=120, radius=10},
        {sec=58.187, x=100, y=118, radius=10}, {sec=58.681, x=100, y=118, radius=10},
        {sec=59.506, x=66, y=44, radius=10}, {sec=60.0, x=66, y=44, radius=10},
        {sec=61.978, x=99, y=103, radius=10}, {sec=62.307, x=122, y=61, radius=10},
        {sec=62.637, x=102, y=106, radius=10}, {sec=62.802, x=123, y=92, radius=10},
        {sec=64.121, x=12, y=56, radius=10}, {sec=64.285, x=35, y=39, radius=10},
        {sec=64.45, x=8, y=22, radius=10}, {sec=65.11, x=66, y=91, radius=10},
        {sec=65.274, x=51, y=61, radius=10}, {sec=66.429, x=123, y=117, radius=10},
        {sec=66.593, x=128, y=82, radius=10}, {sec=66.758, x=103, y=94, radius=10},
        {sec=67.088, x=103, y=94, radius=10}, {sec=67.747, x=41, y=74, radius=10},
        {sec=67.912, x=22, y=100, radius=10}, {sec=68.406, x=27, y=12, radius=10},
        {sec=68.571, x=46, y=37, radius=10}, {sec=69.89, x=126, y=62, radius=10},
        {sec=71.044, x=85, y=102, radius=10}, {sec=71.208, x=63, y=122, radius=10},
        {sec=71.703, x=6, y=123, radius=10}, {sec=72.362, x=6, y=17, radius=10},
        {sec=73.516, x=42, y=62, radius=10}, {sec=73.681, x=67, y=75, radius=10},
        {sec=73.846, x=83, y=46, radius=10}, {sec=74.67, x=63, y=92, radius=10},
        {sec=74.834, x=48, y=120, radius=10}, {sec=74.999, x=24, y=102, radius=10},
        {sec=75.659, x=50, y=37, radius=10}, {sec=75.823, x=70, y=15, radius=10},
        {sec=76.318, x=119, y=39, radius=10}, {sec=76.978, x=82, y=96, radius=10},
        {sec=77.142, x=64, y=123, radius=10}, {sec=77.307, x=52, y=91, radius=10},
        {sec=77.637, x=52, y=91, radius=10}, {sec=78.296, x=37, y=34, radius=10},
        {sec=78.461, x=13, y=17, radius=10}, {sec=80.274, x=102, y=71, radius=10},
        {sec=82.253, x=83, y=20, radius=10}, {sec=82.417, x=83, y=20, radius=10},
        {sec=82.582, x=64, y=40, radius=10}, {sec=82.912, x=29, y=15, radius=10},
        {sec=83.077, x=29, y=15, radius=10}, {sec=85.22, x=117, y=80, radius=10},
        {sec=85.384, x=117, y=80, radius=10}, {sec=86.374, x=86, y=4, radius=10},
        {sec=87.363, x=71, y=93, radius=10}, {sec=87.857, x=120, y=94, radius=10},
        {sec=88.186, x=98, y=45, radius=10}, {sec=88.352, x=98, y=45, radius=10},
        {sec=89.011, x=62, y=51, radius=10}, {sec=89.176, x=42, y=35, radius=10},
        {sec=90.33, x=43, y=85, radius=10}, {sec=90.989, x=96, y=75, radius=10},
        {sec=91.154, x=75, y=62, radius=10}, {sec=91.319, x=75, y=62, radius=10},
        {sec=91.483, x=52, y=72, radius=10}, {sec=91.648, x=40, y=43, radius=10},
        {sec=91.978, x=50, y=107, radius=10}, {sec=92.966, x=11, y=19, radius=10},
        {sec=94.285, x=96, y=33, radius=10}, {sec=96.098, x=54, y=75, radius=10},
        {sec=96.263, x=38, y=94, radius=10}, {sec=98.241, x=19, y=118, radius=10},
        {sec=99.56, x=107, y=124, radius=10}, {sec=101.373, x=101, y=10, radius=10},
        {sec=103.352, x=21, y=79, radius=10}, {sec=103.517, x=4, y=102, radius=10},
        {sec=104.671, x=9, y=25, radius=10}, {sec=104.835, x=9, y=25, radius=10},
        {sec=105.66, x=39, y=38, radius=10}, {sec=106.484, x=72, y=109, radius=10},
        {sec=107.803, x=98, y=34, radius=10}, {sec=108.296, x=41, y=46, radius=10},
        {sec=108.627, x=41, y=46, radius=10}, {sec=109.121, x=31, y=89, radius=10},
        {sec=109.781, x=113, y=106, radius=10}, {sec=110.605, x=113, y=6, radius=10},
        {sec=110.769, x=93, y=24, radius=10}, {sec=110.934, x=72, y=7, radius=10},
        {sec=111.264, x=36, y=33, radius=10}, {sec=111.759, x=33, y=72, radius=10},
        {sec=111.923, x=9, y=67, radius=10}, {sec=112.088, x=6, y=99, radius=10},
        {sec=112.748, x=8, y=96, radius=10}, {sec=113.572, x=28, y=41, radius=10},
        {sec=114.066, x=28, y=41, radius=10}, {sec=114.89, x=64, y=113, radius=10},
        {sec=115.384, x=64, y=113, radius=10}, {sec=115.715, x=88, y=99, radius=10},
        {sec=115.879, x=100, y=108, radius=10}, {sec=116.209, x=124, y=95, radius=10},
        {sec=116.703, x=124, y=95, radius=10}, {sec=117.528, x=81, y=28, radius=10},
        {sec=118.022, x=81, y=28, radius=10}, {sec=118.847, x=64, y=113, radius=10},
        {sec=119.341, x=64, y=113, radius=10}, {sec=120.166, x=28, y=41, radius=10},
        {sec=120.66, x=28, y=41, radius=10}, {sec=122.638, x=89, y=22, radius=10},
        {sec=122.967, x=55, y=48, radius=10}, {sec=123.297, x=17, y=34, radius=10},
        {sec=123.462, x=40, y=25, radius=10}, {sec=124.781, x=112, y=119, radius=10},
        {sec=124.945, x=86, y=114, radius=10}, {sec=125.11, x=104, y=87, radius=10},
        {sec=125.77, x=73, y=48, radius=10}, {sec=125.934, x=54, y=23, radius=10},
        {sec=127.089, x=69, y=99, radius=10}, {sec=127.253, x=88, y=122, radius=10},
        {sec=127.418, x=110, y=101, radius=10}, {sec=127.748, x=110, y=101, radius=10},
        {sec=129.066, x=55, y=45, radius=10}, {sec=129.231, x=32, y=27, radius=10},
        {sec=130.384, x=105, y=106, radius=10}, {sec=131.044, x=76, y=4, radius=10},
        {sec=131.704, x=32, y=10, radius=10}, {sec=132.197, x=31, y=87, radius=10},
        {sec=133.022, x=102, y=48, radius=10}, {sec=134.176, x=77, y=50, radius=10},
        {sec=134.341, x=51, y=59, radius=10}, {sec=134.506, x=32, y=34, radius=10},
        {sec=135.33, x=55, y=107, radius=10}, {sec=135.494, x=78, y=126, radius=10},
        {sec=135.659, x=101, y=109, radius=10}, {sec=136.319, x=94, y=57, radius=10},
        {sec=136.483, x=74, y=32, radius=10}, {sec=137.638, x=38, y=107, radius=10},
        {sec=138.132, x=7, y=53, radius=10}, {sec=138.296, x=33, y=61, radius=10},
        {sec=138.956, x=64, y=14, radius=10}, {sec=139.121, x=41, y=32, radius=10},
        {sec=140.934, x=128, y=56, radius=10}, {sec=143.077, x=74, y=46, radius=10},
        {sec=143.241, x=74, y=46, radius=10}, {sec=143.571, x=41, y=20, radius=10},
        {sec=144.395, x=46, y=75, radius=10}, {sec=144.56, x=46, y=75, radius=10},
        {sec=145.549, x=128, y=93, radius=10}, {sec=145.714, x=128, y=93, radius=10},
        {sec=145.879, x=113, y=73, radius=10}, {sec=146.044, x=94, y=85, radius=10},
        {sec=146.208, x=80, y=65, radius=10}, {sec=146.538, x=80, y=65, radius=10},
        {sec=148.351, x=72, y=65, radius=10}, {sec=148.516, x=72, y=65, radius=10},
        {sec=148.846, x=108, y=41, radius=10}, {sec=150.494, x=69, y=117, radius=10},
        {sec=150.824, x=40, y=85, radius=10}, {sec=150.989, x=40, y=85, radius=10},
        {sec=151.813, x=57, y=72, radius=10}, {sec=152.472, x=85, y=36, radius=10},
        {sec=153.791, x=6, y=77, radius=10}, {sec=154.121, x=40, y=52, radius=10},
        {sec=154.78, x=95, y=68, radius=10}, {sec=155.44, x=116, y=36, radius=10},
        {sec=155.769, x=128, y=84, radius=10}, {sec=155.989, x=118, y=113, radius=10},
        {sec=156.758, x=45, y=103, radius=10}, {sec=157.747, x=11, y=48, radius=10},
        {sec=157.967, x=20, y=20, radius=10}, {sec=158.077, x=33, y=26, radius=10},
        {sec=158.406, x=69, y=11, radius=10}, {sec=159.395, x=78, y=82, radius=10},
        {sec=159.725, x=47, y=53, radius=10}, {sec=160.384, x=32, y=119, radius=10},
        {sec=160.714, x=69, y=112, radius=10}, {sec=160.934, x=93, y=123, radius=10},
        {sec=161.044, x=105, y=114, radius=10}, {sec=161.373, x=91, y=66, radius=10},
        {sec=162.033, x=71, y=11, radius=10}, {sec=162.252, x=54, y=35, radius=10},
        {sec=162.362, x=41, y=27, radius=10}, {sec=163.681, x=41, y=27, radius=10},
        {sec=165.0, x=34, y=38, radius=10}, {sec=166.318, x=32, y=53, radius=10},
        {sec=167.637, x=39, y=65, radius=10}, {sec=168.956, x=48, y=73, radius=10},
        {sec=170.274, x=52, y=87, radius=10}, {sec=171.593, x=51, y=102, radius=10},
        {sec=172.912, x=44, y=114, radius=10}, {sec=174.89, x=114, y=17, radius=10},
        {sec=175.054, x=91, y=33, radius=10}, {sec=175.219, x=114, y=53, radius=10},
        {sec=175.879, x=30, y=7, radius=10}, {sec=176.043, x=10, y=31, radius=10},
        {sec=177.198, x=19, y=127, radius=10}, {sec=177.362, x=44, y=116, radius=10},
        {sec=177.527, x=70, y=124, radius=10}, {sec=177.857, x=70, y=124, radius=10},
        {sec=178.516, x=115, y=85, radius=10}, {sec=178.681, x=115, y=85, radius=10},
        {sec=178.846, x=122, y=51, radius=10}, {sec=179.011, x=122, y=51, radius=10},
        {sec=179.505, x=60, y=12, radius=10}, {sec=180.659, x=49, y=90, radius=10},
        {sec=181.154, x=49, y=90, radius=10}, {sec=181.813, x=52, y=33, radius=10},
        {sec=181.977, x=73, y=55, radius=10}, {sec=182.143, x=95, y=39, radius=10},
        {sec=182.472, x=95, y=39, radius=10}, {sec=183.131, x=97, y=95, radius=10},
        {sec=185.11, x=16, y=64, radius=10}, {sec=185.274, x=16, y=64, radius=10},
        {sec=185.439, x=27, y=34, radius=10}, {sec=185.769, x=20, y=98, radius=10},
        {sec=185.934, x=20, y=98, radius=10}, {sec=188.077, x=62, y=7, radius=10},
        {sec=188.241, x=62, y=7, radius=10}, {sec=189.231, x=34, y=81, radius=10},
        {sec=190.22, x=115, y=58, radius=10}, {sec=190.714, x=118, y=5, radius=10},
        {sec=191.044, x=72, y=16, radius=10}, {sec=191.209, x=72, y=16, radius=10},
        {sec=191.868, x=43, y=30, radius=10}, {sec=192.033, x=23, y=47, radius=10},
        {sec=193.187, x=21, y=100, radius=10}, {sec=193.846, x=82, y=118, radius=10},
        {sec=194.011, x=106, y=110, radius=10}, {sec=194.176, x=106, y=110, radius=10},
        {sec=194.34, x=98, y=79, radius=10}, {sec=194.505, x=74, y=88, radius=10},
        {sec=194.835, x=38, y=52, radius=10}, {sec=196.318, x=122, y=114, radius=10},
        {sec=196.483, x=100, y=126, radius=10}, {sec=197.967, x=56, y=47, radius=10},
        {sec=198.132, x=37, y=26, radius=10}, {sec=198.791, x=34, y=20, radius=10},
        {sec=199.781, x=38, y=56, radius=10}, {sec=200.769, x=104, y=39, radius=10},
        {sec=201.263, x=115, y=128, radius=10}, {sec=201.593, x=73, y=111, radius=10},
        {sec=201.758, x=73, y=111, radius=10}, {sec=202.417, x=37, y=82, radius=10},
        {sec=202.582, x=57, y=62, radius=10}, {sec=203.736, x=41, y=6, radius=10},
        {sec=204.395, x=117, y=25, radius=10}, {sec=204.56, x=108, y=56, radius=10},
        {sec=204.725, x=108, y=56, radius=10}, {sec=204.889, x=85, y=44, radius=10},
        {sec=205.054, x=70, y=69, radius=10}, {sec=205.384, x=98, y=113, radius=10}
      }
    }
  }

  game_state = "main_menu"
  selected_song_index = 1
  main_menu_selection = 1 
end

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for k, v in pairs(orig) do
            copy[k] = deepcopy(v)
        end
    else
        copy = orig
    end
    return copy
end


function _init_play(song_index)
  score=0 
  combo=0
  active_notes={}
  feedback_popups={}
  count_300,count_100,count_50,count_miss=0,0,0,0
  accuracy_int=100 
  final_grade=""
  map_finished=false
  hit_errors={} 
  final_ur_int=0

  _prev_score = 0
  _prev_accuracy_int = 100
  _prev_final_ur_int = 0

  od=global_od
  ar=global_ar
  calculate_settings()

  current_song = songs[song_index]
  beatmap = current_song.beatmap

  beatmap_index=1
  start_time=time()
  pause_menu_selection=0
  song_started = false
  print("\0",0,0)

  game_state = "playing"
end

function update_main_menu()
  if btnp(2) then
    main_menu_selection = max(1, main_menu_selection - 1)
    sfx(0)
  end
  if btnp(3) then 
    main_menu_selection = min(2, main_menu_selection + 1)
    sfx(0)
  end

  local options_x = 80
  local option_y_start = 40
  local option_spacing = 15
  local option_width = 40
  local option_height = 7


  if is_mouse_in_box(options_x-2, option_y_start-2, option_width+4, option_height+4) then
    if main_menu_selection ~= 1 then sfx(0) end
    main_menu_selection = 1
  elseif is_mouse_in_box(options_x-2, option_y_start + option_spacing - 2, option_width+4, option_height+4) then
    if main_menu_selection ~= 2 then sfx(0) end
    main_menu_selection = 2
  end


  if btnp(4) or btnp(5) then
    if main_menu_selection == 1 then 
      game_state = "song_select"
      sfx(0)
    elseif main_menu_selection == 2 then 
      game_state = "settings"
      sfx(0)
    end
  end
end

function draw_main_menu()
  cls(1) 

  local circle_x = 40
  local circle_y = 64
  local circle_radius_inner = 30
  local circle_radius_outer = 32 
  circfill(circle_x, circle_y, circle_radius_inner, 8) 
  circ(circle_x, circle_y, circle_radius_outer, 7) 

  print("osu!", circle_x - (4*2)/2, circle_y - 2, 7)

  local options_x = 80
  local option_y_start = 40
  local option_spacing = 15
  local option_width = 40
  local option_height = 7

  local play_color = 7
  local options_color = 7

  if main_menu_selection == 1 then play_color = 8 end
  if main_menu_selection == 2 then options_color = 8 end

  print_button("play", options_x, option_y_start, option_width, play_color)
  print_button("options", options_x, option_y_start + option_spacing, option_width, options_color)

  local current_time = time()
  local minutes = flr(current_time / 60)
  local seconds = flr(current_time % 60)
  print("it is currently: " .. tostr(minutes) .. ":" .. tostring(seconds), 1, 120, 7)
end


function update_song_select()
  if btnp(2) then
    selected_song_index=max(1,selected_song_index-1)
    sfx(0)
  end;
  if btnp(3) then
    selected_song_index=min(#songs,selected_song_index+1)
    sfx(0)
  end;

  for i=1,#songs do
    local y = 30 + (i-1)*14;
    local song_entry_x = 10
    local song_entry_y = y-2
    local song_entry_width = 118-10
    local song_entry_height = (y+10)-(y-2)

    if is_mouse_in_box(song_entry_x, song_entry_y, song_entry_width, song_entry_height) then
      if selected_song_index ~= i then
        selected_song_index = i
        sfx(0)
      end
      break
    end
  end;

  if btnp(4) or btnp(5) then
    local y_selected = 30 + (selected_song_index-1)*14;
    if is_mouse_in_box(10, y_selected-2, 108, 12) then
      _init_play(selected_song_index)
    elseif is_mouse_in_box(40,110,48,7) then
      game_state="main_menu"
      sfx(2)
    end
  end;
end

function draw_song_select()
  print("song select", 44, 10, 7);
  for i = 1, #songs do
    local song = songs[i];
    local y = 30 + (i - 1) * 14;

    local color = 7;
    if i == selected_song_index then
      color = 8;
      rectfill(10, y-2, 118, y+10, 5)
    end;

    local full_song_info = song.title .. " - " .. song.artist;
    local display_text = full_song_info;
    local max_display_chars = 28;

    local is_hovered = is_mouse_in_box(10, y-2, 108, 12);

    if is_hovered then
      print(full_song_info, 15, y, color);
    else
      if #full_song_info > max_display_chars then
        display_text = sub(full_song_info, 1, max_display_chars - 2) .. "..";
      end
      print(display_text, 15, y, color);
    end
  end;
  print_button("quit to title", 40, 110, 48)
end

function update_play()
  if not song_started then
    music(current_song.music_pattern,100);
    song_started=true
  end;
  if stat(30) and stat(31)=="`" then 
    game_state="paused";
    sfx(2);
    music(-1)
    return
  end;
  local ct=time()-start_time;
  if beatmap_index<=#beatmap and ct>=beatmap[beatmap_index].sec-preempt_time then
    local n=beatmap[beatmap_index];
    add(active_notes,{x=n.x,y=n.y,hit_time=n.sec,radius=10,judged=false,number=beatmap_index});
    beatmap_index+=1
  end;
  if btnp(4) or btnp(5) then 
    local best_n,best_d,mx,my=nil,1,stat(32),stat(33); 
    for n in all(active_notes) do
      if not n.judged and abs(n.hit_time-ct)<best_d then
        best_n,best_d=n,abs(n.hit_time-ct)
      end
    end;
    if best_n and best_d<(hit_window_ms_50/1000) then
      best_n.judged=true;
      local err_in_seconds=ct-best_n.hit_time;
      local err_in_scaled_ms=flr(err_in_seconds * 1000 / ur_error_scaler);
      local dx,dy=best_n.x-mx,best_n.y-my;
      
      local score_increase = 0
      if dx*dx+dy*dy<best_n.radius*best_n.radius then 
        if best_d<(hit_window_ms_300/1000) then
          score_increase = point_300;count_300+=1;add_feedback("300",best_n.x,best_n.y,12, 30)
        elseif best_d<(hit_window_ms_100/1000) then
          score_increase = point_100;count_100+=1;add_feedback("100",best_n.x,best_n.y,11, 30)
        else
          score_increase = point_50;count_50+=1;add_feedback("50",best_n.x,best_n.y,9, 30)
        end;
        combo+=1;
        sfx(0); 
        add(hit_errors,err_in_scaled_ms) 
      else
        combo=0;count_miss+=1;sfx(1);add_feedback("miss",mx,my,8, 30)
      end;
    
      local temp_score = score + score_increase
      temp_score = sanitize_pico8_int(temp_score)

      if temp_score < _prev_score then 
          score = _prev_score
      else
          score = temp_score 
      end
      _prev_score = score 

      update_accuracy()
    end
  end;

  for n in all(active_notes) do
    if n.judged then
      del(active_notes,n)
    elseif ct>n.hit_time+(hit_window_ms_50/1000) then
      n.judged=true;
      combo=0;count_miss+=1;sfx(1);add_feedback("miss",n.x,n.y,8, 30);
      update_accuracy();del(active_notes,n)
    end
  end;

  for p in all(feedback_popups) do
    p.y-=0.5;
    p.life-=1;
    if p.life<=0 then
      del(feedback_popups,p)
    end
  end;

  score = sanitize_pico8_int(score)
  accuracy_int = sanitize_pico8_int(accuracy_int)


  if(beatmap_index>#beatmap and #active_notes==0) then
    final_grade=calculate_grade()
    
    local new_ur_val = calculate_ur()
    new_ur_val = sanitize_pico8_int(new_ur_val)
    if is_nan(new_ur_val) or is_inf(new_ur_val) or new_ur_val < 0 then
        final_ur_int = _prev_final_ur_int
    else
        final_ur_int = new_ur_val
    end
    _prev_final_ur_int = final_ur_int

    game_state="results";
    music(-1) 
  end
end

function draw_play()
  for n in all(active_notes) do
    circfill(n.x,n.y,n.radius+1,7);
    circfill(n.x,n.y,n.radius,12); 
    local s=tostr(n.number);
    print(s,n.x-(#s*2),n.y-2,7);
    local left=n.hit_time-(time()-start_time); 
    if left<=preempt_time then
      local p=left/preempt_time;
      circ(n.x,n.y,n.radius*(1+3*p),12)
    end
  end;
  for p in all(feedback_popups) do
    if p.life > 0 then
        print(p.text,p.x-(#p.text*2),p.y,p.color)
    end
  end;

  print("score: "..tostr(score),2,2,7);
  print("combo: "..combo,90,2,7);

  print("acc: "..tostr(accuracy_int).."%",2,120,7)
end

function update_pause_menu()
  if stat(30) and stat(31)=="`" then
    game_state="playing";
    sfx(2);
    music(current_song.music_pattern)
  end;
  local old=pause_menu_selection;

  if is_mouse_in_box(50,60,28,7) then
    pause_menu_selection=1
  elseif is_mouse_in_box(44,70,40,7) then
    pause_menu_selection=2
  elseif is_mouse_in_box(54,80,20,7) then
    pause_menu_selection=3
  else
    pause_menu_selection=0
  end;

  if pause_menu_selection!=old and pause_menu_selection!=0 then
    sfx(0)
  end;

  if btnp(4) or btnp(5) then
    if pause_menu_selection==1 then
      _init_play(selected_song_index)
    elseif pause_menu_selection==2 then
      game_state="playing";
      sfx(2);
      music(current_song.music_pattern)
    elseif pause_menu_selection==3 then 
      game_state="song_select";
      sfx(2);
      music(-1)
    end
  end;
end

function draw_pause_menu()
  draw_play();
  fillp(0b0101010101010101.1);
  rectfill(0,0,127,127,0);
  fillp();
  print("paused",52,40,7);

  local retry_color = 7;
  local continue_color = 7;
  local quit_color = 7;

  if pause_menu_selection==1 then
    retry_color=8
  elseif pause_menu_selection==2 then
    continue_color=8
  elseif pause_menu_selection==3 then
    quit_color=8
  end;

  print("retry",53,60,retry_color);
  print("continue",45,70,continue_color);
  print("quit",54,80,quit_color)
end

function update_results()
  if btnp(4) or btnp(5) then
    game_state="song_select"
  end
end

function draw_results()
  print(final_grade,58,20,11);
  print("score",20,44,7);
  print(tostr(score),80,44,7);

  print("accuracy",20,54,7);
  print(tostr(accuracy_int).."%",80,54,7);

  print("ur (aae/10 ms)",20,64,7);
  print(tostr(final_ur_int),80,64,7);

  print("300:"..count_300,20,80,12);
  print("100:"..count_100,20,90,11);
  print("50:"..count_50,80,80,9);
  print("miss:"..count_miss,80,90,8);
  print("click to continue",29,120,7)
end

function update_settings()
  local mx,my=stat(32),stat(33);
  if btn(4)or btn(5)then
    if is_mouse_in_box(20,48,88,10)then global_od=sanitize_pico8_int(flr((mx-20)/88*11))end;
    if is_mouse_in_box(20,78,88,10)then global_ar=sanitize_pico8_int(flr((mx-20)/88*11))end
  end;
  if btnp(4)or btnp(5)then
    if is_mouse_in_box(50,110,28,7)then
      game_state="main_menu";
      calculate_settings()
    end
  end
end

function draw_settings()
  print("settings",44,20,7);
  print("od: "..global_od,20,40,7);
  draw_slider(20,50,global_od,10);
  print("ar: "..global_ar,20,70,7);
  draw_slider(20,80,global_ar,10);
  print_button("back",50,110,28)
end

function calculate_settings()
  hit_window_ms_300=80-6*global_od;
  hit_window_ms_100=140-8*global_od;
  hit_window_ms_50=200-10*global_od;
  if global_ar<5 then
    preempt_time=(1800-120*global_ar)/1000
  else
    preempt_time=(1950-150*global_ar)/1000
  end
end

function calculate_ur()
  local n = #hit_errors;
  if n == 0 then return 0 end;

  local sum_abs_errors_scaled_ms = 0;
  for e_scaled_ms in all(hit_errors) do
    sum_abs_errors_scaled_ms += abs(e_scaled_ms)
    sum_abs_errors_scaled_ms = sanitize_pico8_int(sum_abs_errors_scaled_ms)
  end;


  local aae_scaled_ms_int = 0;
  if n > 0 then
      aae_scaled_ms_int = flr(sum_abs_errors_scaled_ms / n);
  end

  return aae_scaled_ms_int 
end

function calculate_grade()
  if count_miss==0 then
    if accuracy_int==100 then return"ss"end;
    if accuracy_int>=95 then return"s"end;
    if accuracy_int>=85 then return"a"end;
    if accuracy_int>=80 then return"b"end;
    if accuracy_int>=65 then return"c"end;
    return"d"
  else
    if accuracy_int==100 then return"ss"end;
    if accuracy_int>=95 then return"a"end;
    if accuracy_int>=85 then return"b"end;
    if accuracy_int>=70 then return"c"end;
    return"d"
  end
end

function add_feedback(t,x,y,c, life)
  local popup_life = life or 30 
  add(feedback_popups,{text=t,x=x,y=y,color=c,life=popup_life})
end


function update_accuracy()
  local t_total = count_300 + count_100 + count_50 + count_miss;
  if t_total == 0 then
    accuracy_int = 100; -- 100%
    _prev_accuracy_int = 100
    return
  end;

  local w_weighted_score = (count_300 * point_300) + (count_100 * point_100) + (count_50 * point_50);
  w_weighted_score = sanitize_pico8_int(w_weighted_score)

  local max_possible_w_score = t_total * point_300;
  max_possible_w_score = sanitize_pico8_int(max_possible_w_score)

  local calculated_acc_int = 0
  if max_possible_w_score > 0 then
      calculated_acc_int = flr((w_weighted_score / max_possible_w_score) * 100);
  end

  calculated_acc_int = max(0, min(100, calculated_acc_int))
  calculated_acc_int = sanitize_pico8_int(calculated_acc_int)

  if is_nan(calculated_acc_int) or is_inf(calculated_acc_int) then
      accuracy_int = _prev_accuracy_int
  else
      accuracy_int = calculated_acc_int
  end
  _prev_accuracy_int = accuracy_int
end

function is_mouse_in_box(x,y,w,h)
  local mx,my=stat(32),stat(33);
  return mx>=x and mx<x+w and my>=y and my<y+h
end

function print_button(t,x,y,w,c)
  c = c or 1 
  rectfill(x-2,y-2,x+w+1,y+6,5); 
  rectfill(x-1,y-1,x+w,y+5,13); 
  if is_mouse_in_box(x-2,y-2,w+4,9) then
    rectfill(x-1,y-1,x+w,y+5,7); 
    print(t,x,y,0)
  else
    print(t,x,y,c) 
  end
end

function draw_slider(x,y,v,max_v)
  rectfill(x,y,x+88,y+5,0);
  rectfill(x+1,y+1,x+87,y+4,5);
  local kx=x+2+flr(v/max_v*82);
  rectfill(kx-1,y-1,kx+1,y+6,7)
end


function load_marshmary_data()
  poke(0x32cc,43)
  poke(0x32cd,85)
  poke(0x32ce,45)
  poke(0x32cf,85)
  poke(0x32d0,46)
  poke(0x32d1,85)
  poke(0x32d2,43)
  poke(0x32d3,85)
  poke(0x32d4,45)
  poke(0x32d5,85)
  poke(0x32d6,46)
  poke(0x32d7,85)
  poke(0x32d8,53)
  poke(0x32d9,85)
  poke(0x32da,46)
  poke(0x32db,85)
  poke(0x32dc,53)
  poke(0x32dd,85)
  poke(0x32de,53)
  poke(0x32df,85)
  poke(0x32e0,55)
  poke(0x32e1,85)
  poke(0x32e2,53)
  poke(0x32e3,85)
  poke(0x32e4,50)
  poke(0x32e5,85)
  poke(0x32e6,48)
  poke(0x32e7,85)
  poke(0x32e8,46)
  poke(0x32e9,85)
  poke(0x32ea,48)
  poke(0x32eb,85)
  poke(0x32ec,43)
  poke(0x32ed,85)
  poke(0x32ee,45)
  poke(0x32ef,85)
  poke(0x32f0,46)
  poke(0x32f1,85)
  poke(0x32f2,43)
  poke(0x32f3,85)
  poke(0x32f4,45)
  poke(0x32f5,85)
  poke(0x32f6,46)
  poke(0x32f7,85)
  poke(0x32f8,41)
  poke(0x32f9,85)
  poke(0x32fa,39)
  poke(0x32fb,85)
  poke(0x32fc,41)
  poke(0x32fd,85)
  poke(0x32fe,46)
  poke(0x32ff,85)
  poke(0x3300,39)
  poke(0x3301,85)
  poke(0x3302,48)
  poke(0x3303,85)
  poke(0x3304,43)
  poke(0x3305,85)
  poke(0x3306,45)
  poke(0x3307,85)
  poke(0x3308,46)
  poke(0x3309,85)
  poke(0x330a,43)
  poke(0x330b,85)
  for i=26,31 do
    poke(0x32cc+i*2,0)
    poke(0x32cc+i*2+1,0)
  end;
  poke(0x32cc+64,4)
  poke(0x32cc+65,0)
  poke(0x32cc+66,31)
  poke(0x32cc+67,0)
  poke(0x3103,3)
end

function _update()
  -- update previous button states at the beginning of each frame
  -- this needs to happen before any btnp() or btnr() calls in this frame.
  for i=0,5 do
    _prev_btn_state[i] = btn(i)
  end

  if game_state=="main_menu" then
    update_main_menu()
  elseif game_state=="song_select" then
    update_song_select()
  elseif game_state=="playing" then
    update_play()
  elseif game_state=="paused" then
    update_pause_menu()
  elseif game_state=="results" then
    update_results()
  elseif game_state=="settings" then
    update_settings()
  end
end

function _draw()
  cls(1) 
  if game_state=="main_menu" then
    draw_main_menu()
  elseif game_state=="song_select" then
    draw_song_select()
  elseif game_state=="playing" then
    draw_play()
  elseif game_state=="paused" then
    draw_pause_menu()
  elseif game_state=="results" then
    draw_results()
  elseif game_state=="settings" then
    draw_settings()
  end;
  circfill(stat(32),stat(33),2,8) 
end
