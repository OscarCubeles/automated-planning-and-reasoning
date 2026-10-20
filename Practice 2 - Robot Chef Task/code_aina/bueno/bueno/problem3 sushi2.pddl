(define 
  (problem preparesushi2)
  (:domain robot-cook2)
  ; objects
  (:objects
    robot-chef
    the-rice the-fish the-seaweed the-broth the-noodles the-vegetables
    the-knife the-pot the-mixer
    SA PA CA SVA DWA CTA MIXA
    sushi ramen 
  ) 

  ; initial state 
  (:init
    ; areas
    (cutting-location CTA)
    (cooking-location CA)
    (mixing-location MIXA)
    (preparation-location PA)
    (serving-location SVA)
    (cleaning-location DWA)

    ; adjacent areas
    (adjacent SA CTA) (adjacent CTA SA)
    (adjacent SA MIXA) (adjacent MIXA SA)
    (adjacent CTA MIXA) (adjacent MIXA CTA)
    (adjacent MIXA PA) (adjacent PA MIXA)
    (adjacent PA DWA) (adjacent DWA PA)
    (adjacent PA CA) (adjacent CA PA)
    (adjacent CA DWA) (adjacent DWA CA)
    (adjacent CA SVA) (adjacent SVA CA)

    ; robot 
    (is-robot robot-chef)
    (at robot-chef CA)
    (robot-empty robot-chef)

    ; Igredients: exclude ramen ingredients to see if it afects the outcome
    (is-rice the-rice)
    (at the-rice SA)
    (is-fish the-fish)
    (at the-fish SA)
    (is-seaweed the-seaweed)
    (at the-seaweed SA)

    ; Tools
    (is-knife the-knife)
    (at the-knife CTA)
    (clean the-knife)
    (is-pot the-pot)
    (at the-pot CA)
    (clean the-pot)
    (is-mixer the-mixer)
    (at the-mixer MIXA)
    (clean the-mixer)

    ; plate to prepare
    (is-sushi sushi)
  )
  ; Goals: sushi is prepared and served and the tools are clean
  (:goal (and
    (dish-served sushi)
    (clean the-knife)
    (clean the-pot)
    (clean the-mixer)
  ))
)