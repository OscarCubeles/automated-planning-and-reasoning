import re
import matplotlib.pyplot as plt
import matplotlib.patches as patches
import imageio
import os

# Constants for grid size (4x4 grid in the problem)
GRID_SIZE = 4

# Parse the PDDL problem to extract initial positions and layout
def parse_pddl_problem(file_path):
    locations = {}
    obstacles = []
    drone_start = None
    person_locations = {}
    safe_zone = None

    with open(file_path, 'r') as file:
        data = file.read()

        # Find drone starting location
        drone_start = re.search(r'\(drone-location\s+(\w+)\)', data).group(1)
        
        # Find person locations
        persons = re.findall(r'\(person-location\s+(\w+)\s+(\w+)\)', data)
        for person, loc in persons:
            person_locations[person] = loc

        # Find safe zone
        safe_zone = re.search(r'\(safe-zone\s+(\w+)\)', data).group(1)
        
        # Find obstacles
        obstacles = re.findall(r'\(obstacle\s+(\w+)\)', data)
        
        # Find adjacency relationships to understand grid structure
        adjacencies = re.findall(r'\(adjacent\s+(\w+)\s+(\w+)\)', data)
        for loc1, loc2 in adjacencies:
            locations[loc1] = loc1
            locations[loc2] = loc2
    
    return {
        "drone_start": drone_start,
        "person_locations": person_locations,
        "safe_zone": safe_zone,
        "obstacles": obstacles,
        "locations": locations
    }

# Parse the plan to extract the sequence of actions
def parse_plan(file_path):
    actions = []
    with open(file_path, 'r') as file:
        for line in file:
            match = re.match(r'\d+\.\d+:\s+\((.+)\)', line)
            if match:
                actions.append(match.group(1).split())
    return actions

# Generate grid and render each step
def generate_frame(grid, drone_pos, people_pos, obstacles, safe_zone, step, action_desc):
    fig, ax = plt.subplots()
    
    # Create a grid
    ax.set_xlim(0, GRID_SIZE)
    ax.set_ylim(0, GRID_SIZE)
    ax.set_xticks(range(GRID_SIZE))
    ax.set_yticks(range(GRID_SIZE))
    ax.grid(True)
    
    # Draw obstacles
    for obs in obstacles:
        x, y = location_to_grid(obs)
        rect = patches.Rectangle((x, y), 1, 1, linewidth=1, edgecolor='black', facecolor='grey')
        ax.add_patch(rect)
    
    # Draw safe zone
    x, y = location_to_grid(safe_zone)
    rect = patches.Rectangle((x, y), 1, 1, linewidth=1, edgecolor='green', facecolor='lightgreen')
    ax.add_patch(rect)
    
    # Draw people
    for person, loc in people_pos.items():
        x, y = location_to_grid(loc)
        ax.text(x + 0.5, y + 0.5, person, color='blue', ha='center', va='center')
    
    # Draw drone
    x, y = location_to_grid(drone_pos)
    ax.add_patch(patches.Circle((x + 0.5, y + 0.5), 0.3, color='red'))
    
    # Set the title with the action description
    plt.title(f"Step {step}: {action_desc}")
    
    # Save the frame as an image
    frame_path = f'frame_{step:03d}.png'
    plt.savefig(frame_path)
    plt.close(fig)
    return frame_path

# Convert a location string (e.g., "loc1") to grid coordinates
def location_to_grid(loc):
    idx = int(loc[3:]) - 1  # Extract the number from "locX"
    row = idx // GRID_SIZE
    col = idx % GRID_SIZE
    return col, GRID_SIZE - row - 1

# Generate a video from the plan
def generate_video(problem_file, plan_file, output_video='rescue_plan.mp4'):
    # Parse the problem and the plan
    problem_data = parse_pddl_problem(problem_file)
    plan_actions = parse_plan(plan_file)
    
    # Extract initial state
    drone_pos = problem_data['drone_start']
    people_pos = problem_data['person_locations'].copy()
    obstacles = problem_data['obstacles']
    safe_zone = problem_data['safe_zone']
    
    # Store frames for each step
    frames = []
    
    # Simulate the plan step-by-step
    for step, action in enumerate(plan_actions):
        action_desc = ' '.join(action)
        verb = action[0]
        
        if verb == 'MOVE':
            _, from_loc, to_loc = action
            drone_pos = to_loc
        elif verb == 'PICKUP':
            _, person, loc = action
            people_pos[person] = 'drone'  # Person is picked up by drone
        elif verb == 'DROPOFF':
            _, person, loc, _ = action
            people_pos[person] = loc  # Person is dropped off at a safe zone
        
        # Generate a frame for this step
        frame_path = generate_frame(
            grid=GRID_SIZE,
            drone_pos=drone_pos,
            people_pos=people_pos,
            obstacles=obstacles,
            safe_zone=safe_zone,
            step=step,
            action_desc=action_desc
        )
        frames.append(frame_path)
    
    # Create a video from frames
    with imageio.get_writer(output_video, mode='I', fps=1) as writer:
        for frame in frames:
            image = imageio.imread(frame)
            writer.append_data(image)
    
    # Clean up temporary frame files
    for frame in frames:
        os.remove(frame)

# Example usage
generate_video('problem.pddl', 'plan.txt')
