(define (problem rescue-mission-5x5-5people-with-obstacles)
  (:domain drone-rescue)
  
  ;; Objects: drone, people, and locations
  (:objects
    loc1 loc2 loc3 loc4 loc5      ;; Row 1 (0-indexed row)
    loc6 loc7 loc8 loc9 loc10     ;; Row 2 (1-indexed row)
    loc11 loc12 loc13 loc14 loc15 ;; Row 3 (2-indexed row)
    loc16 loc17 loc18 loc19 loc20 ;; Row 4 (3-indexed row)
    loc21 loc22 loc23 loc24 loc25 ;; Row 5 (4-indexed row)
    drone1 - drone         ;; The drone
    person1 person2 person3 person4 person5 - person ;; People to rescue
    S1 S2 S3 S4
  )
  
  ;; Initial state: Drone and people locations, safe zones, obstacles, and adjacency
  (:init
    ;; Drone starting location (example starting location)
    (drone-location loc13)
    (drone-free)
    ;; People stranded locations
    (person-location person1 loc3)   ;; Person 1 in the last column of row 0
    (person-location person2 loc6)   ;; Person 2 in the first column of row 1
    (person-location person3 loc10)  ;; Person 3 in the second column of row 2
    (person-location person4 loc25)  ;; Person 3 in the second column of row 0
    (person-location person5 loc9)

    ;; Safe zones
    (safe-zone loc21)  ;; Safe zone in column 2, row 3
    
    (spot S1)
    (spot S2)
    (spot S3)
    (spot S4)
    
    (spot-free S1)
    (spot-free S2)
    (spot-free S3)
    (spot-free S4)
    
    ;; Obstacles
    (obstacle loc8)    ;; Obstacle in column 3, row 1
    (obstacle loc11)   ;; Obstacle in column 3, row 2
    (obstacle loc14)   ;; Obstacle in column 4, row 3
    (obstacle loc19)

    ;; Adjacency relationships
    ;; Row 1
    (adjacent loc1 loc2) (adjacent loc2 loc1)
    (adjacent loc2 loc3) (adjacent loc3 loc2)
    (adjacent loc3 loc4) (adjacent loc4 loc3)
    (adjacent loc4 loc5) (adjacent loc5 loc4)
    (adjacent loc1 loc6) (adjacent loc6 loc1)
    (adjacent loc2 loc7) (adjacent loc7 loc2)
    (adjacent loc3 loc8) (adjacent loc8 loc3)
    (adjacent loc4 loc9) (adjacent loc9 loc4)
    (adjacent loc5 loc10) (adjacent loc10 loc5)

    ;; Row 2
    (adjacent loc6 loc7) (adjacent loc7 loc6)
    (adjacent loc7 loc8) (adjacent loc8 loc7)
    (adjacent loc8 loc9) (adjacent loc9 loc8)
    (adjacent loc9 loc10) (adjacent loc10 loc9)
    (adjacent loc6 loc11) (adjacent loc11 loc6)
    (adjacent loc7 loc12) (adjacent loc12 loc7)
    (adjacent loc8 loc13) (adjacent loc13 loc8)
    (adjacent loc9 loc14) (adjacent loc14 loc9)
    (adjacent loc10 loc15) (adjacent loc15 loc10)

    ;; Row 3
    (adjacent loc11 loc12) (adjacent loc12 loc11)
    (adjacent loc12 loc13) (adjacent loc13 loc12)
    (adjacent loc13 loc14) (adjacent loc14 loc13)
    (adjacent loc14 loc15) (adjacent loc15 loc14)
    (adjacent loc11 loc16) (adjacent loc16 loc11)
    (adjacent loc12 loc17) (adjacent loc17 loc12)
    (adjacent loc13 loc18) (adjacent loc18 loc13)
    (adjacent loc14 loc19) (adjacent loc19 loc14)
    (adjacent loc15 loc20) (adjacent loc20 loc15)

    ;; Row 4
    (adjacent loc16 loc17) (adjacent loc17 loc16)
    (adjacent loc17 loc18) (adjacent loc18 loc17)
    (adjacent loc18 loc19) (adjacent loc19 loc18)
    (adjacent loc19 loc20) (adjacent loc20 loc19)
    (adjacent loc16 loc21) (adjacent loc21 loc16)
    (adjacent loc17 loc22) (adjacent loc22 loc17)
    (adjacent loc18 loc23) (adjacent loc23 loc18)
    (adjacent loc19 loc24) (adjacent loc24 loc19)
    (adjacent loc20 loc25) (adjacent loc25 loc20)

    ;; Row 5
    (adjacent loc21 loc22) (adjacent loc22 loc21)
    (adjacent loc22 loc23) (adjacent loc23 loc22)
    (adjacent loc23 loc24) (adjacent loc24 loc23)
    (adjacent loc24 loc25) (adjacent loc25 loc24)
  )
  
  ;; Goal: All three persons must be rescued
  (:goal (and
    (rescued person1)
    (rescued person2)
    (rescued person3)
    (rescued person4)
    (rescued person5)
  ))
)
