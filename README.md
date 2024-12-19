https://gtkwave.sourceforge.net/

https://ghdl.github.io/ghdl/development/building/index.html

https://repositorio.ufsm.br/handle/1/31325

https://www.typhoon-hil.com/blog/meet-the-new-hil606-with-cto-dusan-majstorovic/

https://direct.mit.edu/books/monograph/4016/Finite-State-Machines-in-HardwareTheory-and-Design

https://adaptivesupport.amd.com/s/question/0D52E00006hpaHISAY/dcm-mmcm-and-pll?language=en_US

https://www.researchgate.net/profile/Tarek-Ould-Bachir-2/publication/304411809_FPGA-based_real-time_simulation_of_a_PSIM_model_An_indirect_matrix_converter_case_study/links/6079c034907dcf667ba43e4f/FPGA-based-real-time-simulation-of-a-PSIM-model-An-indirect-matrix-converter-case-study.pdf?origin=publication_detail&__cf_chl_tk=Dm0AGkdgergbSqmoqsZqZPQnMYLLUh8uLXuvod25oHA-1734439991-1.0.1.1-9rYZ4bxMoc3kET_Z5oTNNyzf6Bi5FZo6_ihhMvqf9Cc

https://electronics.stackexchange.com/questions/21696/reset-synchronous-vs-asynchronous
https://vlsiuniverse.blogspot.com/2016/09/reset-synchronizer.html

https://ohwr-gitlab.cern.ch/project/fmc-hv-2ch/blob/master/hdl/testbench/adc_ltc2484.vhd

https://ohwr-gitlab.cern.ch/project/fmc-hv-2ch/blob/master/hdl/testbench/adc_ltc2484.vhd

# Coding Guidelines 
from https://www.amd.com/content/dam/xilinx/support/documents/sw_manuals/xilinx2022_1/ug901-vivado-synthesis.pdf

• Do not asynchronously set or reset registers.

° Control set remapping becomes impossible.

° Sequential functionality in device resources such as block RAM components and DSP blocks can be set or reset synchronously only.

° If you use asynchronously set or reset registers, you cannot leverage device resources, or those resources are configured sub-optimally.

• Do not describe flip-flops with both a set and a reset.
°
No Flip-flop primitives feature both a set and a reset, whether synchronous or asynchronous.

° Flip-flop primitives featuring both a set and a reset may adversely affect area and  performance.

• Avoid operational set/reset logic whenever possible. There may be other, less  expensive, ways to achieve the desired effect, such as taking advantage of the circuit  global reset by defining an initial content.

• Always describe the clock enable, set, and reset control inputs of flip-flop primitives as active-High. If they are described as active-Low, the resulting inverter logic will penalize circuit performance.


TODO 

asynchronous assertion, synchronous deassertion


READ
https://adaptivesupport.amd.com/s/question/0D52E00006hpKqxSAE/reset-asynchronous-assert-synchronous-deassert-why-asynchronous-assert?language=en_US

