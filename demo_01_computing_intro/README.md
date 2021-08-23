# Introduction to Computing





## What is a computer?

At a basic level, a computer is a list of information stored in memory, combined with some operations that can be performed on the information in memory. 
At any time, a computer has a state that is defined by the set of values at each of the locations in memory. 


## What is a program? 

A computer program is a list of instructions for operations to be performed on the values stored in memory. 
A program alters the state of the computer. 


## How do computers run programs? 

The human-readable computer program that you write is interpreted, or translated into another set of instructions, by another program called the interpreter. 
This interpreter translates the program into something that will run on the operating system. 
The operating system, such as Windows, Linux or Mac OS, is another set of programs that then translate your instructions into a more primitive set of instructions that are finally executed on the computer. 

<img src="Images/Interpreter.png" width="500"/>

Why go through all of this trouble? Well, first, the operating system uncouples your program from the particulars of the hardware on your physical computer, such as the monitor, the hard drive and the keyboard. 
Further, the interpreter separates the instructions in your program from the particular operating system on your computer. 
With this separation, you need only write the instructions in standardized syntax and the interpreter and operating system take care of the rest. 


## So how does the computer *really* run programs?

To illustrate the workings of a computer, we will consider one of the simplest forms of computers, called a *register machine*.


# The Register Machine

The register machine was introduced by a logician Hao Wang at the dawn of the computing age. 
It stores information in a list of registers, each one with a natural number. 
It can perform three operations:

* ```END``` will halt the program.
* ```INC``` will increase the number in a register by 1.
* ```DEB``` will decrease the number in a register by 1, if it is nonzero, otherwise ```BRANCH```.



Simple as they are, these operations are enough to do anything that any computer can do -- it just might take a long time.
The first command is not very interesting but it is still required to declare that the program has stopped. 
The second is fairly simple and makes a primitive change to the state of the register. 
The magic occurs with the third condition. 
Subtraction is nearly the same as addition, in reverse, except that it is undefined if the particular register has a value of zero. 
This is important because it provides an opportunity to execute a command that depends on the state of the register.

These commands are listed in a program in which each line has up to four parameters:

* The first is the *step* number of the program referring to a particular command.
* The second is the *instruction*, the command to either ```END```, ```INC``` or ```DEB```.
* The third is needed only in the case of the ```INC``` or ```DEB``` commands. After changing the register, it instructs the computer to *go to* a particular *step* in the program and execute the instruction at that step next. 
* The fourth column is ony needed for the ```DEB``` command. It indicates the *branch-to step* in the program to be executed next in the case that the register has a value of zero and cannot be decreased. 

Here are some examples that follow from the discussion of the [RodRego](http://sites.tufts.edu/rodrego/) program on the website of the philosopher Dan Dennet at Tufts University. 
RodRego is a program for running programs in a language called ```RAP```, which stands for *Register Assembly Programming*. 
A version that will run in your browser is available [here](http://proto.atech.tufts.edu/RodRego/).
The following examples are found in Dan Dennet's book *Intuition Pumps and Other Tools for Thinking*. 

### Program 1: ```ADD[1,2]```

This program adds the value in register 1 to the value in register 2.

```
1 DEB 1 2 3
2 INC 2 1
3 END
```

This process is illustrated in a *flow graph*. 
Each circle represents an instruction, with the number inside showing the *address* of the register to be changed, with a "+" for an ```INC``` instruction and a "-" for a ```DEB``` instruction. 
Only one arrow trails from the ```INC``` instruction but two arrows trail from the ```DEB``` instruction, with the *branch-to* step labeled with a zero. 
The program starts at &alpha; and ends at &Omega;.



<img src="Images/FlowGraphADD12.png" width="500"/>


Now run this program to see it in action. 
Open RodRego and it is initialized with ten registers, 
with *addresses* numbered zero to nine, each initialized with 
the *value* equal to the *address* of the register. 

<img src="Images/RodRegoStart.png" width="500"/>



Running the program above, results in the output below. 

<img src="Images/RodRegoADD12.png" width="500"/>

You can also watch each change by running the program step-by-step. 
Notice that the value in register 1 is empty, while register 2 contains the sum. 
To preserve the value of the inputs, we will have to learn a few more tools. 
We can run the following programs in the RodRego program as above. 

### Program 2: ```MOVE[4,5]```

This program moves the contents of register 4 into register 5:

```
1 DEB 5 1 2
2 DEB 4 3 4
3 INC 5 2
4 END
```

The flow graph is shown here:

<img src="Images/FlowGraphMOVE45.png" width="500"/>


Notice the first step is to remove the contents of register 5 so that the value does not get counted with the value moved from register 4.

### Program 4: ```COPY[1,3]```

This program copies the value in register 1 and records it in register 3. 

```
1 DEB 3 1 2
2 DEB 4 2 3
3 DEB 1 4 6
4 INC 3 5
5 INC 4 3
6 DEB 4 7 8
7 INC 1 6
8 END
```


<img src="Images/FlowGraphCOPY13.png" width="500"/>


As above, thie first steps are to clear spaces in memory to store the result (in register 3) and store the values of intermediate calculations (in register 4). 
Steps 3, 4 and 5 cycle through the subtraction of values from register 1 and the addition of each value to both registers 3 and 4. 
Moving to register 3 is the goal but the movement to register 4 is to store the original value of register 1.
When register 1 is empty, the program then alternates between steps 6 and 7 to move the values in register 4 back to register 1, leaving the value that was copied in its original location. 


### Program 4: Non-destructive ```ADD[1,2,3]```

This program now adds the values in registers 1 and 2 and stores the result in register 3, while preserving the values in registers 1 and 2. 

```
1  DEB 3  1  2
2  DEB 4  2  3
3  DEB 1  4  6
4  INC 3  5
5  INC 4  3
6  DEB 4  7  8
7  INC 1  6
8  DEB 2  9 11
9  INC 3 10
10 INC 4  8
11 DEB 4 12 13
12 INC 2 11
13 END
```

<img src="Images/FlowGraphNonDestrADD123.png" width="500"/>


Other programs can be written to multiply two values, with repeated addition. 
Subtraction can also be performed similarly, except that there is the potential for negative values, in which an extra register must be used to store a minus sign. 
Division can be completed by repeated subtraction, with an extra register for the remainder, with one additional hitch: storing an error message in a register to denote division by zero. 
Once these programs are written, one can create a program to emulate a pocket calculator by including a register with a value to indicate the desired operation. 
For example, zero for ```ADD```, one for ```SUBTRACT```, two for ```MULTIPLY``` and three for ```DIVIDE```. 

The extension to more advanced computers is described in this note: [Secrets to Computer Power Revealed](http://sites.tufts.edu/rodrego/files/2011/03/Secrets-of-Computer-Power-Revealed-2008.pdf) and an updated version is available in [this note from a Royal Institution Masterclass](http://brainmindforum.com/docs/convergence-booklet-reprint.pdf) called *CONERGENCE of Biogenetics, Cognitive Neuroscience and Computing*.


