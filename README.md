# Automated Planning and Reasoning

Coursework projects exploring **symbolic planning** and **approximate reasoning** through autonomous rescue, robotic cooking, and phishing-detection problems. The repository combines Planning Domain Definition Language (PDDL) models with a Mamdani fuzzy expert system implemented in MATLAB.

The work was completed for the *Planning and Approximate Reasoning* course in the master's programs in Artificial Intelligence and Computer Security & Artificial Intelligence at Universitat Rovira i Virgili (URV).

## Repository contents

| Deliverable | Method | Problem | Main files |
| --- | --- | --- | --- |
| **Practice 1** | Classical planning with PDDL | Plan routes for a rescue drone that collects stranded people, avoids obstacles, and respects the capacity of a safe zone | [report](Practice%201%20-%20Resuce%20Drone/Delivery/Practical_exercise_1__Rescue_drone_task.pdf), [PDDL domain and cases](Practice%201%20-%20Resuce%20Drone/Delivery/PDDL_source_code), [assignment](Practice%201%20-%20Resuce%20Drone/PlannerExercise1%20%281%29.pdf) |
| **Practice 2** | Classical planning with PDDL | Coordinate a robot chef that transports and prepares ingredients, cleans tools, assembles dishes, and serves sushi and ramen | [final PDDL models](Practice%202%20-%20Robot%20Chef%20Task/Code%20Final), [assignment](Practice%202%20-%20Robot%20Chef%20Task/PlannerExercise2.pdf) |
| **Practice 3** | Mamdani fuzzy inference | Estimate a website's phishing risk from URL, content, and external-service features | [fuzzy system](Practice%203%20-%20Fuzzy%20Logic/delivery/Assignment3_FuzzyExpertSystem.fis), [report](Practice%203%20-%20Fuzzy%20Logic/delivery/Assignment3_FuzzyExpertSystem.pdf), [dataset](Practice%203%20-%20Fuzzy%20Logic/phishing%2Bwebsites/Training%20Dataset.arff) |

## Project highlights

### Practice 1 - Rescue drone planning

This exercise models a drone navigating grid-based disaster zones. The drone must reach stranded people, carry them one at a time to a safe zone, avoid blocked cells, and empty the safe zone when its capacity is exhausted.

The PDDL domain defines four actions:

- `move` between adjacent, unobstructed locations;
- `pickup` a person when the drone is free;
- `dropoff` a carried person at the safe zone; and
- `empty-safe-zone` to release occupied capacity.

Four cases of increasing complexity cover 4 x 4 and 5 x 5 grids with different obstacles, rescue targets, and capacity constraints. The submitted solutions compare plans produced by the **BFWS-FF Parser** and **DELFI** planners. Both solve every case; DELFI produces shorter plans in the larger scenarios.

The `Delivery/PDDL_source_code` directory is the cleanest entry point. It contains separate, planner-compatible domain and problem files together with their generated plans and saved BFWS visualizations.

### Practice 2 - Robot chef planning

The second planning exercise models a restaurant kitchen with storage, cutting, mixing, cooking, preparation, dishwashing, and serving areas. The final domain controls a robot chef and represents the complete workflow for sushi and ramen:

- transport ingredients and tools between adjacent areas;
- cut fish, seaweed, and vegetables;
- mix and cook rice, noodles, and broth;
- clean knives, mixers, and pots after use;
- assemble sushi or ramen; and
- move and plate the finished dish in the serving area.

The four final problem instances cover a ramen order, two sushi configurations, and a combined sushi-and-ramen order. Saved outputs from **BFWS** and **LAMA** make it possible to compare the planners' action sequences without rerunning them.

### Practice 3 - Fuzzy phishing detection

This project implements a **Mamdani fuzzy expert system** that returns a phishing-risk score from 0 to 100 and assigns one of four linguistic labels: safe, weakly suspicious, strongly suspicious, or phishing.

The system combines five inputs selected from the accompanying phishing-detection literature and dataset:

- ratio of null hyperlinks;
- domain age;
- PageRank;
- URL length; and
- presence of suspicious login forms.

The delivered `.fis` model uses trapezoidal and triangular membership functions, 18 weighted rules, minimum conjunction and implication, maximum aggregation, and centroid defuzzification. The report validates the model with four contrasting website scenarios and proposes a larger system with additional URL, content, and external-service features.

## Getting started

Clone the repository:

```bash
git clone https://github.com/OscarCubeles/automated-planning-and-reasoning.git
cd automated-planning-and-reasoning
```

### Running the PDDL exercises

Use a PDDL editor or planner that supports the requirements declared by each domain:

- Practice 1 uses STRIPS and negative preconditions.
- Practice 2 uses STRIPS, typing, disjunctive preconditions, and negative preconditions.

For Practice 1, submit a domain file and one matching case file to the planner. The two final planner-specific directories are:

```text
Practice 1 - Resuce Drone/Delivery/PDDL_source_code/
|-- BFWS_planner_pddl/
`-- DELFI_planner_pddl/
```

For Practice 2, use the final domain with any of its four problem files:

```text
Practice 2 - Robot Chef Task/Code Final/
|-- domain (1).pddl
|-- ramen.pddl
|-- sushi.pddl
|-- sushi2.pddl
`-- sushiramen.pddl
```

The generated `.txt` and `.plan` files can be used to check the expected action sequences. Earlier prototypes are retained elsewhere in the practice directories for reference.

### Opening the fuzzy expert system

Practice 3 requires MATLAB with the **Fuzzy Logic Toolbox**. Open Fuzzy Logic Designer, import the following file, and use the rule viewer or surface viewer to inspect the inference process:

```text
Practice 3 - Fuzzy Logic/delivery/Assignment3_FuzzyExpertSystem.fis
```

The system expects inputs in these ranges:

| Input | Range |
| --- | ---: |
| Ratio of null hyperlinks | 0-1 |
| Domain age | 0-120 months |
| PageRank | 0-10 |
| URL length | 0-180 characters |
| Login forms | 0 (normal) or 1 (suspicious) |

### Optional rescue-plan animation

[`video_generator.py`](Practice%201%20-%20Resuce%20Drone/Code/planning/video_generator.py) visualizes a 4 x 4 rescue plan and writes an MP4. To use it, create a Python environment and install its dependencies:

```bash
python -m venv .venv
python -m pip install matplotlib imageio imageio-ffmpeg
```

Activate the environment, place compatible files at `problem.pddl` and `plan.txt` beside the script, and run:

```bash
python video_generator.py
```

The script is configured specifically for the 4 x 4 rescue representation and the action format emitted by the corresponding planner.

## Reproducing the results

1. Choose the final domain and a matching problem instance.
2. Run them with the planner used by that practice.
3. Compare the resulting action sequence and plan length with the saved output.
4. For the fuzzy system, load the `.fis` file in MATLAB and evaluate the four test cases documented in the report.

Planner implementations and tie-breaking strategies may produce a different valid action order. The important checks are that all problem goals are reached, domain constraints are respected, and the final plan is comparable in length to the supplied solutions.

## Authors

- **Oscar Cubeles Ollé**
- **Aina Llaneras**
- **María Angélica Jaimes**

## Acknowledgements

- Universitat Rovira i Virgili (URV)
- BFWS-FF Parser, DELFI, and LAMA planner contributors
- MATLAB Fuzzy Logic Toolbox
- Abdelhakim Hannousse and Salima Yahiouche for the phishing-feature study included with Practice 3

## License

No license has been specified for this repository. Unless a license is added, the materials remain subject to standard copyright restrictions.
