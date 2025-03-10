

### testbench generator

https://vhdl.lapinoo.net/testbench/

## academic background 

https://direct.mit.edu/books/monograph/4016/chapter-abstract/167107/Design-Steps-and-Classical-Mistakes?redirectedFrom=PDF

https://gtkwave.sourceforge.net/

https://ghdl.github.io/ghdl/development/building/index.html
https://github.com/open-logic/open-logic/blob/main/doc/tutorials/VivadoTutorial.md

https://repositorio.ufsm.br/handle/1/31325
https://ptolemy.berkeley.edu/books/leeseshia/releases/LeeSeshia_DigitalV2_2.pdf
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


# TODO coco tb

asynchronous assertion, synchronous deassertion
https://docs.cocotb.org/en/stable/simulator_support.html

## READ

### from academia research
https://www.mpp.mpg.de/en/research
https://liu.diva-portal.org/smash/record.jsf?pid=diva2%3A747961&dswid=-6785 https://liu.diva-portal.org/smash/get/diva2:747961/FULLTEXT01.pdf

https://portal.cs.umbc.edu/help/VHDL/sequential.html
https://web.stanford.edu/class/ee183/ee121_win2002_handouts/lect7.pdf

### from websites 
https://nandland.com/signed-vs-unsigned-dealing-with-negative-numbers/
https://nandland.com/arrays/
https://adaptivesupport.amd.com/s/question/0D52E00006hpKqxSAE/reset-asynchronous-assert-synchronous-deassert-why-asynchronous-assert?language=en_US
https://docs.amd.com/viewer/book-attachment/5Gn4aq9Up_2U3j5XVNpQrg/UJNqkwPD4M_y47APXIJVYQ
https://www.reddit.com/r/FPGA/comments/1gt92v1/ip_cores_and_fpga_limitations/
https://www.sigasi.com/tech/vhdl-resets/
https://vhdlwhiz.com/part-2-finite-impulse-response-fir-filters/#serial-implementation
https://vhdlwhiz.com/terminology/translate/
https://www.reddit.com/r/FPGA/comments/yu6s2h/clocks_vs_strobe_signals_to_multiplex_a_bus/
https://electronics.stackexchange.com/questions/408458/data-strobe-in-ddr-memory
https://www.linkedin.com/pulse/many-ways-mess-up-readyvalid-handshaking-lukas-vik-2mqdf/?trackingId=DXVQvI3YOqo1lLnP9RZAag%3D%3D

### to buy

https://digilent.com/shop/basys-3-artix-7-fpga-trainer-board-recommended-for-introductory-users/
https://digilent.com/shop/arty-a7-100t-artix-7-fpga-development-board/
https://github.com/muhammadaldacher/FPGA-Design-of-a-Digital-Analog-Clock-Display-using-Digilent-Basys3-Artix-7/blob/master/LAB7_PicoBlaze_Assembly/lab7.srcs/constrs_1/imports/ee178_fall2017_lab7/tutorial.xdc


https://wavedrom.com/

