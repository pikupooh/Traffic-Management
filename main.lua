class = require 'class'
require 'car'
require 'traffic_light'

WINDOW_WIDTH = 720
WINDOW_HEIGHT = 720

COUNT_DOWN = 50 ;
cars = {}
trafficLights = {}

function love.load()
  math.randomseed(os.time())
  love.window.setMode( WINDOW_WIDTH , WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    centered = true,
  })

  love.window.setTitle('Traffic Management')

  count_down = COUNT_DOWN

  table.insert(trafficLights , trafficLight(1))
  table.insert(trafficLights, trafficLight(2))

end

function love.update(dt)

  count_down  = count_down - 1

  if count_down == 0 then
    road = math.random(1,2)
    dir = math.random(0, 1) == 0 and 1 or -1
    car = Car(road , dir)

    table.insert(cars, car)

    table.insert(cars, car)

    count_down = COUNT_DOWN
  end

  for i,v in pairs(cars) do
      v:update(dt)
    if (v.y > WINDOW_HEIGHT + 2 * CAR_WIDTH + 10 or v.y < - 2 * CAR_WIDTH - 10)   or
      ((v.x > WINDOW_WIDTH + 2 * CAR_WIDTH + 10 or v.x < - 2 * CAR_WIDTH - 10)) then
      table.remove(cars, i)
    end
  end

  for i,v in pairs(trafficLights) do
    v:update(dt)
  end


end

function love.keypressed(key)

    if key == 'escape' then
      love.event.quit()
    end
end

function love.draw()
  love.graphics.line(WINDOW_WIDTH/2 - 2 * (CAR_WIDTH + CAR_GAP) , 0 , WINDOW_WIDTH/2 - 2 * (CAR_WIDTH + CAR_GAP), WINDOW_HEIGHT)
  love.graphics.line(WINDOW_WIDTH/2 + 2 * (CAR_WIDTH + CAR_GAP) , 0 , WINDOW_WIDTH/2 + 2 * (CAR_WIDTH + CAR_GAP), WINDOW_HEIGHT)
  love.graphics.line(0, WINDOW_HEIGHT/2 - 2*(CAR_WIDTH + CAR_GAP), WINDOW_WIDTH, WINDOW_HEIGHT/2 - 2*(CAR_WIDTH + CAR_GAP))
  love.graphics.line(0, WINDOW_HEIGHT/2 + 2*(CAR_WIDTH + CAR_GAP), WINDOW_WIDTH, WINDOW_HEIGHT/2 + 2*(CAR_WIDTH + CAR_GAP))

  for i,v in pairs(cars) do
    v:render()
  end

  for i,v in pairs(trafficLights) do
    v:render()
  end
end
