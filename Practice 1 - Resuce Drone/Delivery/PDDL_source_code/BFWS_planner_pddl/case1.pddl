(define (problem rescue-mission-4x4-with-obstacles)
  (:domain drone-rescue)
  
  ;; Objects: drone, people, and locations
  (:objects
    loc1 loc2 loc3 loc4   ;; Row 1 (0-indexed row)
    loc5 loc6 loc7 loc8   ;; Row 2 (1-indexed row)
    loc9 loc10 loc11 loc12 ;; Row 3 (2-indexed row)
    loc13 loc14 loc15 loc16 ;; Row 4 (3-indexed row)
    drone1 - drone         ;; The drone
    person1 person2 person3 - person ;; People to rescue
    S1 S2 S3
  )
  
  ;; Initial state: Drone and people locations, safe zones, obstacles, and adjacency
  (:init
    ;; Drone starting location (example starting location)
    (drone-location loc1)
    (drone-free)
    ;; People stranded locations
    (person-location person1 loc4)   ;; Person 1 in the last column of row 0
    (person-location person2 loc5)   ;; Person 2 in the first column of row 1
    (person-location person3 loc10)  ;; Person 3 in the second column of row 2
    
    ;; Safe zones
    (safe-zone loc14)  ;; Safe zone in column 2, row 3
    
    (spot S1)
    (spot S2)
    (spot S3)
    
    (spot-free S1)
    (spot-free S2)
    (spot-free S3)
    
    
    ;; Obstacles
    (obstacle loc7)    ;; Obstacle in column 3, row 1
    (obstacle loc11)   ;; Obstacle in column 3, row 2
    (obstacle loc16)   ;; Obstacle in column 4, row 3

    ;; Adjacency relationships
    ;; Row 1
    (adjacent loc1 loc2) (adjacent loc2 loc1)
    (adjacent loc2 loc3) (adjacent loc3 loc2)
    (adjacent loc3 loc4) (adjacent loc4 loc3)
    (adjacent loc1 loc5) (adjacent loc5 loc1)
    (adjacent loc2 loc6) (adjacent loc6 loc2)
    (adjacent loc3 loc7) (adjacent loc7 loc3)
    (adjacent loc4 loc8) (adjacent loc8 loc4)

    ;; Row 2
    (adjacent loc5 loc6) (adjacent loc6 loc5)
    (adjacent loc6 loc7) (adjacent loc7 loc6)
    (adjacent loc7 loc8) (adjacent loc8 loc7)
    (adjacent loc5 loc9) (adjacent loc9 loc5)
    (adjacent loc6 loc10) (adjacent loc10 loc6)
    (adjacent loc7 loc11) (adjacent loc11 loc7)
    (adjacent loc8 loc12) (adjacent loc12 loc8)

    ;; Row 3
    (adjacent loc9 loc10) (adjacent loc10 loc9)
    (adjacent loc10 loc11) (adjacent loc11 loc10)
    (adjacent loc11 loc12) (adjacent loc12 loc11)
    (adjacent loc9 loc13) (adjacent loc13 loc9)
    (adjacent loc10 loc14) (adjacent loc14 loc10)
    (adjacent loc11 loc15) (adjacent loc15 loc11)
    (adjacent loc12 loc16) (adjacent loc16 loc12)

    ;; Row 4
    (adjacent loc13 loc14) (adjacent loc14 loc13)
    (adjacent loc14 loc15) (adjacent loc15 loc14)
    (adjacent loc15 loc16) (adjacent loc16 loc15)
  )
  
  ;; Goal: All three persons must be rescued
  (:goal (and
    (rescued person1)
    (rescued person2)
    (rescued person3)
  ))
)
