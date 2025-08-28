-- setup
local lineprogram = bolt.createshaderprogram(
  bolt.createvertexshader(
"layout (location = 0) in vec2 vXY;".. -- points from -1 to 1, as needed by opengl to draw a rectangle
"out vec2 xy;".. -- calculated pixel coordinate of the vertex based on vXY and target_wh
"layout (location = 0) uniform vec2 target_wh;".. -- pixel width and height of the target area
"void main() {"..
  "xy = vec2(((vXY.x + 1.0) / 2.0) * target_wh.x, ((vXY.y + 1.0) / 2.0) * target_wh.y);"..
  "gl_Position = vec4(vXY, 0.0, 1.0);"..
"}"
  ),
  bolt.createfragmentshader(
"in vec2 xy;".. -- pixel coordinate of this fragment
"out highp vec4 col;".. -- fragment colour output
"layout (location = 1) uniform vec4 line_points;".. -- the pixel coordinates of the two points of the line we want to draw
"layout (location = 2) uniform vec4 line_colour;".. -- the RGBA colour of the central part of the line
"layout (location = 3) uniform float line_thickness;".. --thickness of the line in pixels
"void main() {"..
  "vec2 p1 = line_points.st;"..
  "vec2 p2 = line_points.pq;"..
  "vec2 perpendicular = vec2(line_points.t - line_points.q, line_points.p - line_points.s);"..
  "float dist_line = abs(dot(normalize(perpendicular), p2 - xy));"..
  "float dist_p1 = length(p1 - xy);"..
  "float dist_p2 = length(p2 - xy);"..
  "bool nearestp1 = dot(xy - p1, p2 - p1) < 0.0;"..
  "bool nearestp2 = dot(xy - p2, p1 - p2) < 0.0;"..
  "float dist = mix(mix(dist_p2, dist_p1, nearestp1), dist_line, !nearestp1 && !nearestp2);"..
  "col = vec4(line_colour.stp, line_colour.q * (1.0 - smoothstep(line_thickness, line_thickness + 0.5, dist)));"..
"}"
  )
)
lineprogram:setattribute(0, 1, true, false, 2, 0, 2)
local linebuffer = bolt.createshaderbuffer("\xFF\xFF\x01\xFF\x01\x01\xFF\xFF\x01\x01\xFF\x01")
local linesurfacesize = 256
local linesurface = bolt.createsurface(linesurfacesize, linesurfacesize)
lineprogram:setuniform2f(0, linesurfacesize, linesurfacesize)
lineprogram:setuniform4f(2, 197/255, 110/255, 234/255, 1) -- line colour (rgba, 0.0 - 1.0)
lineprogram:setuniform1f(3, 8) -- line thickness (px)

-- function to redraw the hexagon to the surface
local updatelinesurface = function (elapsed, maxtime, program, surface, surfacesize)
  linesurface:clear()
  if elapsed > maxtime then return false end
  local surfaceradius = surfacesize / 2
  for i = 1, 6 do
    local hexradius = 100
    local angle = (90 + ((i - 1) * 60)) * math.pi / 180.0
    local nextangle = (90 + (i * 60)) * math.pi / 180.0
    local x = math.cos(angle) * hexradius + surfaceradius
    local y = surfacesize - (math.sin(angle) * hexradius + surfaceradius)
    local nextx = math.cos(nextangle) * hexradius + surfaceradius
    local nexty = surfacesize - (math.sin(nextangle) * hexradius + surfaceradius)
    local timestart = maxtime * (6 - i) / 6
    local lastline = elapsed > timestart
    if lastline then
      local length = (1.0 - ((elapsed - timestart) / (maxtime / 6))) * hexradius
      local relangle = math.atan2(nexty - y, nextx - x)
      nextx = math.cos(relangle) * length + x
      nexty = math.sin(relangle) * length + y
    end
    program:setuniform4f(1, x, y, nextx, nexty)
    program:drawtosurface(surface, linebuffer, 6)
    if lastline then return true end
  end
  return true
end

-- do this every frame before you need to use the hexagon
updatelinesurface(ELAPSED_TIME_HERE, TIMER_DURATION_HERE)

-- this just draws to (100,150) on the screen but you get the idea
linesurface:drawtoscreen(0, 0, linesurfacesize, linesurfacesize, 100, 150, linesurfacesize, linesurfacesize)
