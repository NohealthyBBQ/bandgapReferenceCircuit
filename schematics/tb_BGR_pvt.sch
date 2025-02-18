v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 140 -160 180 -160 {
lab=porst}
N 320 -240 350 -240 {
lab=Vbg}
N 320 -220 350 -220 {
lab=#net1}
N 450 -380 490 -380 {
lab=#net2}
N 440 -380 450 -380 {
lab=#net2}
N 440 -450 440 -380 {
lab=#net2}
N 440 -450 450 -450 {
lab=#net2}
N 490 -450 550 -450 {
lab=VDD}
N 550 -510 550 -450 {
lab=VDD}
N 490 -510 550 -510 {
lab=VDD}
N 490 -390 490 -380 {
lab=#net2}
N 490 -420 490 -390 {
lab=#net2}
N 490 -510 490 -480 {
lab=VDD}
N 350 -220 490 -220 {
lab=#net1}
N 490 -380 490 -280 {
lab=#net2}
C {schematics/BGR.sym} 10 -40 0 0 {name=X1}
C {devices/code.sym} 640 -260 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
** opencircuitdesign pdks install
.lib $::SKYWATER_MODELS/sky130.lib.spice tt

"
spice_ignore=false}
C {devices/vsource.sym} 830 -210 0 0 {name=V1 net_name=true 
*value="'VDD' pwl 0us 0 1us 'VDD'"
value=1.8}
C {devices/vdd.sym} 830 -240 0 0 {name=l9 lab=VDD}
C {devices/gnd.sym} 830 -180 0 0 {name=l22 lab=GND}
C {devices/vsource.sym} 830 -100 0 0 {name=V2 net_name=true value="0 pulse(0V 1.8V 10us 0us 0us 5us)"}
C {devices/gnd.sym} 830 -70 0 0 {name=l12 lab=GND}
C {devices/lab_pin.sym} 830 -130 0 0 {name=l23 lab=porst}
C {devices/code_shown.sym} -240 -570 0 0 {name=NGSPICE3
only_toplevel=true
spice_ignore=false
value="
.option savecurrents
.option warn=1
.dc temp -20 100 1
.control
save all

run
plot Vbg
plot deriv(Vbg)


plot vm1#branch
plot deriv(vm1#branch)

plot v.x1.vm5#branch
plot deriv(v.x1.vm5#branch)

save vbg deriv(vbg)




unset askquit
*quit
.endc
" }
C {devices/vdd.sym} 230 -270 0 0 {name=l1 lab=VDD}
C {devices/gnd.sym} 230 -60 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} 140 -160 0 0 {name=l3 lab=porst}
C {devices/lab_pin.sym} 350 -240 0 1 {name=l4 lab=Vbg}
C {noconn.sym} 320 -200 0 1 {name=l5}
C {noconn.sym} 320 -180 0 1 {name=l6}
C {sky130_fd_pr/pfet_01v8_lvt.sym} 470 -450 0 0 {name=M19
L=1
W=1
nf=1
mult=5
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {devices/vdd.sym} 490 -510 0 0 {name=l7 lab=VDD}
C {devices/ammeter.sym} 490 -250 0 0 {name=Vm1 current=40e-6}
C {noconn.sym} 340 -240 1 0 {name=l8}
