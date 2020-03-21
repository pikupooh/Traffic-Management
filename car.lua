Car = class{}

CAR_WIDTH = 30
CAR_GAP = 20

function Car:init(road, dir)
  self.tflag = 0
  self.flag = 0
  self.trafficstop = false
  self.stop = false
  self.road = road
  self.dir = dir
  self.acc = 0
  self.velocity = 0

  if self.road == 1 then
    if self.dir == 1 then
      self.y = - 2 * CAR_WIDTH
      self.x =  WINDOW_WIDTH/2 + CAR_GAP/2 + math.random(0,1) * (CAR_GAP + CAR_WIDTH)
    elseif self.dir == -1 then
      self.y = WINDOW_HEIGHT + 2 * CAR_WIDTH
      self.x = WINDOW_WIDTH/2 - CAR_GAP/2 - CAR_WIDTH - math.random(0,1) * (CAR_WIDTH + CAR_GAP)
    end
  elseif self.road == 2 then
    if self.dir == 1 then
      self.x = - 2 * CAR_WIDTH
      self.y = WINDOW_HEIGHT/2 - CAR_GAP/2 - CAR_WIDTH - math.random(0,1) * (CAR_GAP + CAR_WIDTH)
    elseif self.dir == -1 then
      self.x = WINDOW_WIDTH + 2 * CAR_WIDTH
      self.y = WINDOW_HEIGHT/2 + CAR_GAP/2 + math.random(0,1) * (CAR_GAP + CAR_WIDTH)
    end
  end

end

function Car:update(dt)

  if self.stop == false and self.trafficstop == false then
    self.acc = self.acc + self.dir * 0.5
    self.velocity = self.velocity + self.acc * dt
    if self.road == 1 then
      self.y = self.y + self.velocity*dt
    elseif self.road == 2 then
      self.x = self.x + self.velocity*dt
    end
  elseif self.stop == true or self.trafficstop == true then
    self.velocity = 0
    self.acc =0
  end

    for i,v in pairs(cars) do
      if self.road == 1 then
        if self.x == v.x then
          if self.dir == 1 then
            if self.y + CAR_WIDTH + CAR_GAP < v.y then
              self.stop = false
            elseif self.y + CAR_WIDTH + CAR_GAP > v.y and self.y < v.y then
              self.stop = true
            end
          elseif self.dir == -1 then
            if self.y - CAR_GAP > v.y + CAR_WIDTH then
              self.stop = false
            elseif self.y - CAR_GAP < v.y + CAR_WIDTH and self.y > v.y then
              self.stop = true
            end
          end
        end
      elseif self.road == 2 then
        if self.y == v.y then
          if self.dir == 1 then
            if self.x + CAR_GAP + CAR_WIDTH < v.x then
              self.stop = false
            elseif self.x + CAR_GAP + CAR_WIDTH > v.x and self.x < v.x then
              self.stop = true
            end
          elseif self.dir == -1 then
            if self.x - CAR_GAP > v.x + CAR_WIDTH then
              self.stop = false
            elseif self.x - CAR_GAP < v.x + CAR_WIDTH and self.x > v.x then
              self.stop = true
            end
          end
        end
      end
    end


    if self.road == 1 then
      if self.dir == 1 then
        if self.y + CAR_GAP + CAR_WIDTH < trafficLights[1].y1 - 10 or trafficLights[1].colour == 'green' or
            self.y + CAR_WIDTH + 5 > WINDOW_HEIGHT/2 - 2 * (CAR_GAP + CAR_WIDTH) then
          self.trafficstop = false
        else
          self.trafficstop = true
        end
      elseif self.dir == -1 then
        if self.y - 10 > trafficLights[1].y2 or trafficLights[1].colour == 'green' or
            self.y - 5 < WINDOW_HEIGHT/2 + 2 * (CAR_GAP + CAR_WIDTH)  then
          self.trafficstop = false
        else
          self.trafficstop = true
        end
      end
    elseif self.road == 2 then
      if self.dir == 1 then
        if self.x + CAR_GAP + CAR_WIDTH < trafficLights[2].y1 - 10 or trafficLights[2].colour == 'green' or
            self.x + CAR_WIDTH +  5 > WINDOW_WIDTH/2 - 2 * (CAR_GAP + CAR_WIDTH) then
          self.trafficstop = false
        else
          self.trafficstop = true
        end
      elseif self.dir == -1 then
        if self.x - 10 > trafficLights[2].y2 or trafficLights[2].colour == 'green' or
            self.x - 5 < WINDOW_WIDTH/2 + 2 * (CAR_GAP + CAR_WIDTH)  then
          self.trafficstop = false
        else
          self.trafficstop = true
        end
      end
    end

    if self.trafficstop then
      if self.road == 1 then
        if trafficLights[2]:checkForGreen() then
          trafficLights[2]:changeToRed()
        end
      elseif self.road == 2 then
        if trafficLights[1]:checkForGreen(self) then
          trafficLights[1]:changeToRed()
        end
      end
    end

end


function Car:render()
  love.graphics.rectangle('fill', self.x, self.y, CAR_WIDTH, CAR_WIDTH)
end
