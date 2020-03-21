trafficLight = class{}

trafficCheckLine = 50


function trafficLight:init(road)
  self.flag = 0
  self.COUNT_DOWN = 500
  self.count_down = self.COUNT_DOWN
  self.colour = 'red'
  self.road = road

  if self.road == 1 then
    self.x1 = WINDOW_WIDTH/2 + 2 * (CAR_WIDTH + CAR_GAP) + 20
    self.y1 = WINDOW_HEIGHT/2 - 2 * (CAR_WIDTH + CAR_GAP) - 20
    self.x2 = WINDOW_WIDTH/2 - 2 * (CAR_WIDTH + CAR_GAP) - 20
    self.y2 = WINDOW_HEIGHT/2 + 2 * (CAR_WIDTH + CAR_GAP) + 20
  elseif self.road == 2 then
    self.x1 = WINDOW_WIDTH/2 - 2 * (CAR_WIDTH + CAR_GAP) - 20
    self.y1 = WINDOW_HEIGHT/2 - 2 * (CAR_GAP + CAR_WIDTH) - 20
    self.x2 = WINDOW_WIDTH/2 + 2 * (CAR_GAP + CAR_WIDTH) + 20
    self.y2 = WINDOW_HEIGHT/2 + 2 * (CAR_GAP + CAR_WIDTH) + 20
  end

end

function trafficLight:update(dt)

  if self.colour == 'red' then
    self.count_down = self.count_down-1
    if self.count_down == 0 then
      self.count_down = self.COUNT_DOWN
      self:changeToGreen()
    end
  end

end

function trafficLight:changeToGreen()

  if self.colour == 'red'  then
    self.colour = 'green'
    for i,v in pairs(cars) do
      if self.road == v.road then
        v.trafficstop = false
      end
    end
  end

    for i,v in pairs(trafficLights) do
      if self.road ~= v.road  then
        v.colour = 'red'
        v.count_down = v.COUNT_DOWN
      end
    end

end

function trafficLight:changeToRed ()
  if self.colour == 'green'  then
    self.colour = 'red'
    for i,v in pairs(cars) do
      if self.road == v.road then

      end
    end
  end

    for i,v in pairs(trafficLights) do
      if self.road ~= v.road  then
        v.colour = 'green'
        v.count_down = v.COUNT_DOWN
      end
    end
end

function trafficLight:checkForGreen()

  for i,v in pairs(cars) do
    if self.road == 1 then
      if v.road == 1 then
        if (v.dir == 1 and (v.y + CAR_GAP + CAR_WIDTH  < self.y1 - trafficCheckLine or v.y > WINDOW_HEIGHT/2 + 2 * (CAR_GAP+CAR_WIDTH)) )
          or (v.dir == -1 and (v.y > self.y2 + trafficCheckLine or v.y < WINDOW_HEIGHT/2 + 2 * (CAR_GAP + CAR_WIDTH))) then

        else
          return  false
        end
      end
    elseif self.road == 2 then
      if v.road == 2 then
         if (v.dir == 1 and (v.x + CAR_GAP + CAR_WIDTH < self.x1 - trafficCheckLine or v.x > WINDOW_WIDTH/2 + 2 * (CAR_GAP + CAR_WIDTH)))
          or (v.dir == -1 and (v.x > self.x2 + trafficCheckLine or v.x < WINDOW_HEIGHT/2 + 2 * (CAR_GAP + CAR_WIDTH))) then

        else
          return false
        end
      end
    end
    return  true
  end

end

function trafficLight:render ()
  if self.colour == 'green' then
    love.graphics.setColor(0, 1, 0)
  else
    love.graphics.setColor(1, 0, 0)
  end


  love.graphics.circle('fill', self.x1, self.y1 , 10)
  love.graphics.circle('fill', self.x2, self.y2 , 10)
  love.graphics.setColor(1, 1, 1)
end
