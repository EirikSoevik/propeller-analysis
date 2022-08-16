# Propeller analysis
Propeller analysis in MATLAB, for a semester project in the course TMA4220 - Naval Hydrodynamics. This project calculates propeller characteristics using no induced velocities, complete momentum theory and lifting line theory, as well as testing for convergence and cavitation.

## This program does 5 different tasks:
1. Propeller characteristics with no induced velocities
2. Propeller characteristics with simple induced
   velocities, using complete momentum theory
3. Propeller characteristics using lifting line theory
4. Convergence test for J=0.5 for different sections N
5. Cavitation test

## How to use

By opening the main.m file and editing the variables listed in line 3, as shown below, on can change different parameters as well as the chosen task
![how-to-use](https://user-images.githubusercontent.com/78209756/184908819-378c7e48-8ff9-4cf3-9c77-58fdd2d22db0.PNG)

The variables that can be changed are:
- N: number of sections
- task: which task to solve
- N_vec: Number of sections you want to run the convergence test for, reccomended values are N_vec = [6:6:36]
- J_inp: Which J to run convergence or cavitation test for must be one of these values: [0.5 0.6 0.7 0.8 0.9 1.0 1.1]. However, J=0.5 is recommended
- show_plots: set to true to show plots, and false to hide them



## Task 1: Propeller characteristics with no induced velocities
![task1](https://user-images.githubusercontent.com/78209756/184906377-5951604d-1d19-46e3-b388-ec7717a7a422.png)


## Task 2: Propeller characteristics with simple induced velocities, using complete momentum theory
![task2](https://user-images.githubusercontent.com/78209756/184906395-83b7fabe-aa80-4b85-9f70-4b2ba3f227c1.png)


## Task 3: Propeller characteristics using lifting line theory
![task3](https://user-images.githubusercontent.com/78209756/184906411-834352cb-0cd7-44ba-ab65-0793c603a2bf.png)


## Task 4: Convergence test for J=0.5 for different sections N
![task4](https://user-images.githubusercontent.com/78209756/184906425-d48cbced-e243-4203-8e2f-d9629b1d9dc7.png)


# Task 5: Cavitation test
![cpny_cav](https://user-images.githubusercontent.com/78209756/184907035-2b7fa97c-88df-435e-89a5-4f145228a328.png)
