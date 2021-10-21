# Programmable-Processor

This project implemented 6 instruction Programable Processor using System Verilog. The main module "Processor.sv" implemented both "Control.sv" and "Datapath.sv". The control then instanced the "InstructionMemory.v", "PC.sv", "IR.sv", and "FSM.sv". Similarly, the Datapath instances the "DataMemory.v", "Mux_2_to_1","ALU.sv", and "Regfile16x16". Lastly, the "Project.sv" instances the Processor as well as "ButtonSyncRegReg.sv","KeyFiler.sv", "Mux_3w_8_to_1.sv" and "Decoder.sv". The Project file uses these modules to verify it's results on ModelSim and display on a D2 board. 

More in-depth details on each module and project report is provided in the Project.pdf file.
