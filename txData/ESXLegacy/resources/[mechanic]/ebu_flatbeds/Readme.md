######
## There are no longer circles- makesure to read the controls. Bed controls are done at the back left or right of the truck.
#####

## Default Controls:
[E] - At bed to attach / detach vehicle (useable in vehicle on bed as well)
[LeftArrow] - Attach, Wind winch
[RightArrow] - Unwind winch
[UpArrow] - Raise Bed (automatic, click once)
[DownArrow] - Lower Bed (automatic, click once)
[G] - Remove Rope
[SHIFT] - Access Hand Winch controls
[SHIFT] + [LeftArrow] - Grab winch
[SHIFT] + [RightArrow] - Return winch
[SHIFT] + [E] - Attach winch

## How to use:
# For ROLLING beds:
1. Lower bed
2. Ensure the vehicle is behind the truck close to the bed
3. Press Left Arrow next to the flatbed truck body to attach the winch
4. Press Left Arrow again to wind the winch
5. Press E when the vehicle is ON the bed. If the vehicle is inside the bed, or too high, press E to disconnect then E again to reconnect the car.

# For Static beds:
1. Ensure the car is behind the truck.
2. Press E next to the truck, or inside the car.



## Exports / Events:
# wind start/stop winding the winch
targetflatbedWind(truck)
# OR connect target or wind start/stop winding the winch
targetflatbedWind(truck, target)
# event:
"ebu_flatbeds:client:targetflatbedWind"

# start/stop unwinding the winch
targetflatbedUnWind(truck) 
# event:
"ebu_flatbeds:client:targetflatbedUnWind"

# attach/detach vehicle on bed
targetflatbedAtt(truck)
# event:
"ebu_flatbeds:client:targetflatbedAtt"

# delete rope attached to truck
targetflatbedRope(truck)
# event
"ebu_flatbeds:client:targetflatbedRope"

# toggle wheel lift on truck (if applicable)
targetflatbedWheel(truck)
# event:
"ebu_flatbeds:client:targetflatbedWheel"

# Raise / stop the bed
targetflatbedRaise(truck)
# event:
"ebu_flatbeds:client:targetflatbedRaise"

# Lower /stop the bed
targetflatbedLower(truck)
# event:
"ebu_flatbeds:client:targetflatbedLower"