# RISC-V-Pipelined-Processor

Readings (pg 155 topic 3.6 first two para, pg 396 topic 7.1.3, pg 415,416 topic 7.4, pg 439,440,441)

We design a pipelined processor by subdividing the single-cycle processor into five pipeline stages. Thus, five instructions can execute simultaneously, one in each stage. Because each stage has only one-fifth of the entire logic, the clock frequency is approximately five times faster. So, ideally, the latency of each instruction is unchanged, but the throughput is five times better. Microprocessors execute millions or billions of instructions per second, so throughput is more
important than latency. Pipelining introduces some overhead, so the throughput will not be as high as we might ideally desire, but pipelining nevertheless gives such great advantage for so little cost that all modern high-performance microprocessors are pipelined.

<img width="651" height="305" alt="image" src="https://github.com/user-attachments/assets/051c5c0b-4e6c-4635-90a6-66dcbbbf659d" />
Each pipeline stage is represented with its major component—instruction memory (IM), register file (RF) read, ALU execution, data memory (DM), and register file writeback—to illustrate the flow of instructions through the pipeline. 

<img width="666" height="525" alt="image" src="https://github.com/user-attachments/assets/6b234837-d02b-4ccf-a6fa-8f7d7f3da7be" />

<img width="636" height="368" alt="image" src="https://github.com/user-attachments/assets/c5905287-01ce-4f53-989c-4eef0d818552" />
<br>
<br>

1. Implementing Fetch Stage
   Modules: MUX, Program Counter (PC), Instruction Memory (IM), Adder, Fetch Stage Registers

<br>

2. Decode Stage
   Modules: Control Unit, Register File, Sign Extender, Decode Stage Registers

<br>
3. Execute Stage
Modules: ALU, Adder, MUX, Execute Stage Registers

<br>
4. Memory Read Write Stage
Modules: Data Memory, Memory RW Stage Registers

<br>
5. Writeback Register Stage
Module: MUX 
__________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

Outputs:

Raw (before implementing all modules)
<img width="1920" height="1080" alt="pipelined_raw" src="https://github.com/user-attachments/assets/25428035-1e1c-4b7a-8f5c-41629c8d1b5d" />


Without hazard control unit
<img width="1920" height="1080" alt="output_showing_data_hazard" src="https://github.com/user-attachments/assets/80332325-61fd-4d7a-9e4c-7a0de3cd8b53" />




<br>
With hazard control unit
<img width="1941" height="1080" alt="hazard handling" src="https://github.com/user-attachments/assets/230581ce-5d53-4b2e-bde2-71c87f7c9034" />



